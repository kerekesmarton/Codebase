//
//  NewsDataManager.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "NewsDataManager.h"
#import "NewsParserDelegate.h"

#import "DownloadManager.h"
#import "SettingsManager.h"
#import "NewsObject.h"


@interface NewsDataManager ()

@property (nonatomic, strong) NSOperation *operation;

@end

@implementation NewsDataManager

@synthesize items;

+(NewsDataManager *)sharedInstance {
    static NewsDataManager *shardObject;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        shardObject = [[NewsDataManager alloc] init];
    });
    return shardObject;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        [self setupRefreshRate];
    }
    return self;
}

-(void)cancelRequest {
    if (self.operation) {
        [self.operation cancel];
        self.operation = nil;
    }
}

-(void)requestDataWitchSuccess:(successfulRequestBlock)success failBlock:(failedRequestBlock)fail {
    
    [self setupRefreshRate];
    [self cancelRequest];
    
    self.operation = [[DownloadManager sharedInstance] requestPath:[self path] withSuccessBlock:^(id jsonData) {
        
        NSError *error = nil;
        id parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
        
        NSLog(@"%@",[parsedData description]);
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
            NewsParserDelegate *parser = [[NewsParserDelegate alloc] init];
            NSArray *results = [parser parseAndSaveObjects:parsedData];
            [self verifyMissingData:results success:success failBlock:fail];
        });        
        
    } FailureBlock:^(NSError *error) {
        fail(error);
    }];
}

-(void)setupRefreshRate{
    id refreshRate = [[SettingsManager sharedInstance].newsRefreshSettings.selectedValues lastObject];
    
    if ([refreshRate isKindOfClass:[NSNumber class]]) {
        //interval int
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        [self performSelector:@selector(requestData) withObject:nil afterDelay:[refreshRate integerValue]*3600];
    } else {
        //off string
        [NSObject cancelPreviousPerformRequestsWithTarget:self];
    }
}

-(NSArray *)fetchData:(successfulFetchBlock)success failBlock:(failedFetchBlock)fail {
    self.items = [NewsObject fetchUndeletedNews];
    
    if (self.items.count>0) {
        
        success(nil);
        return [NSArray arrayWithArray:self.items];
    } else {
        
        fail(nil);
        return [NSArray array];
    }
}

-(NSString*)path {
    
    return @"api/saf/newsitem/?limit=0&format=json";
}

- (NSString *)objectClassString
{
    return NSStringFromClass([NewsObject class]);
}

@end
