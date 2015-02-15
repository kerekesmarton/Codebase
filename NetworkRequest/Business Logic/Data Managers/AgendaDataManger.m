//
//  AgendaDataManger.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/1/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "AgendaDataManger.h"
#import "AgendaObject.h"
#import "AgendaParserDelegate.h"

#import "DownloadManager.h"

@interface AgendaDataManger ()

@property (nonatomic, strong) NSOperation *operation;

@end

@implementation AgendaDataManger

@synthesize items;

+(AgendaDataManger *)sharedInstance {
    static AgendaDataManger *shardObject;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shardObject = [[AgendaDataManger alloc] init];
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
            AgendaParserDelegate *parser = [[AgendaParserDelegate alloc] init];
            [parser parseAndSaveObjects:parsedData];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                success(nil);
            });
        });
        
        
    } FailureBlock:^(NSError *error) {
        fail(error);
    }];
}

-(NSArray *)fetchData:(successfulFetchBlock)success failBlock:(failedFetchBlock)fail {
    self.items = [AgendaObject fetchAgenda];
    
    if (self.items.count>0) {
        
        success(self.items);
        return [NSArray arrayWithArray:self.items];
    } else {
        
        fail(nil);
        return [NSArray array];
    }
}

-(NSString*)path {

    return @"api/saf/schedule/?limit=0&format=json";
}


@end