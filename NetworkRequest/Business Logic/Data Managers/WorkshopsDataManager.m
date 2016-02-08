//
//  WorkshopsDataManager.m
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/27/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "WorkshopsDataManager.h"
#import "WorkshopsParserDelegate.h"
#import "WorkshopObject.h"
#import "SettingsManager.h"
#import "DownloadManager.h"

@interface WorkshopsDataManager ()

@property (nonatomic, strong) NSOperation *operation;

@end

@implementation WorkshopsDataManager

@synthesize items;

+(WorkshopsDataManager *)sharedInstance {
    static WorkshopsDataManager *shardObject;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shardObject = [[WorkshopsDataManager alloc] init];
    });
    
    return shardObject;
}

-(void)cancelRequest {
    if (self.operation) {
        [self.operation cancel];
        self.operation = nil;
    }
}

-(void)requestDataWitchSuccess:(successfulRequestBlock)success failBlock:(failedRequestBlock)fail {
    
    self.operation = [[DownloadManager sharedInstance] requestPath:[self path] withSuccessBlock:^(id jsonData) {
        
        NSError *error = nil;
        id parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",[parsedData description]);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            WorkshopsParserDelegate *parser = [[WorkshopsParserDelegate alloc] init];
            [parser parseAndSaveObjects:parsedData];
            
            NSArray *rooms = parser.rooms;
            if (rooms.count) {
                [[SettingsManager sharedInstance].workshopsFilter addPossibleValues:rooms];
                NSString *room = [rooms objectAtIndex:0];
                [[SettingsManager sharedInstance].workshopsFilter addToSelectedValues:room];

            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
        
    } FailureBlock:^(NSError *error) {
        fail(error);
    }];
}

-(NSArray *)fetchData:(successfulFetchBlock)success failBlock:(failedFetchBlock)fail {
    self.items = [WorkshopObject fetchWorkshops];
    
    if (self.items.count>0) {
        
        success(self.items);
        return [NSArray arrayWithArray:self.items];
    } else {
        
        fail(nil);
        return [NSArray array];
    }
}

-(NSArray *)fetchDataForDay:(NSDate *)day{
    
    id result = [WorkshopObject fetchWorkshopsForDay:day rooms:[SettingsManager sharedInstance].workshopsFilter.selectedValues];
    if ([result respondsToSelector:@selector(count)]) {
        self.items = result;
    } else {
        self.items = @[result];
    }
    return self.items;
}

-(NSString*)path {
    return @"api/saf/workshopitem/?limit=0&format=json";
}

@end
