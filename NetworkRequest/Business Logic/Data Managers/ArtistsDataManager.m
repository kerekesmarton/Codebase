//
//  ArtistsDataManager.m
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/31/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ArtistsDataManager.h"
#import "ArtistParserDelegate.h"
#import "ArtistObject.h"
#import "SettingsManager.h"
#import "DownloadManager.h"

@interface ArtistsDataManager ()

@property (nonatomic, strong) NSOperation *operation;

@end

@implementation ArtistsDataManager

@synthesize items;

//@synthesize imageDelegate;
//static int kPlaceHolderImageWidth = 60;

+(ArtistsDataManager *)sharedInstance {
    static ArtistsDataManager *shardObject;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shardObject = [[ArtistsDataManager alloc] init];
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
            ArtistParserDelegate *parser = [[ArtistParserDelegate alloc] init];
            NSArray *results = [parser parseAndSaveObjects:parsedData];
            [self verifyMissingData:results success:success failBlock:fail];
        });
        
        
    } FailureBlock:^(NSError *error) {
       fail(error);
    }];
}

-(NSArray *)fetchData:(successfulFetchBlock)success failBlock:(failedFetchBlock)fail {
    self.items = [ArtistObject fetchArtists];
    
    if (self.items.count>0) {
        
        success(self.items);
        return [NSArray arrayWithArray:self.items];
    } else {
        
        fail(nil);
        return [NSArray array];
    }
}

-(NSString*)path {
    
    return  @"api/saf/artistitem/?limit=0&format=json";
}

- (NSString *)objectClassString
{
    return NSStringFromClass([ArtistObject class]);
}


@end