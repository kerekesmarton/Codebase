//
//  DataManager.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 18/02/16.
//  Copyright © 2016 Jozsef-Marton Kerekes. All rights reserved.
//

#import "DataManager.h"
#import "VIManagedObject.h"
#import "ParsedObject.h"
#import "DownloadManager.h"

static NSString * const SET_SUFFIX = @"set";
static NSString * const FORMAT = @"?format=json";
static NSString * const NOT_FOUND = @"not_found";

@implementation DataManager

@synthesize items;

- (NSArray *)fetchData:(successfulFetchBlock)success failBlock:(failedFetchBlock)fail
{
    NSAssert(1, @"Base implementation");
    return nil;
}
- (void)requestDataWitchSuccess:(successfulRequestBlock)success failBlock:(failedRequestBlock)fail
{
    NSAssert(1, @"Base implementation");
}
- (void)verifyMissingData:(NSArray *)existingData success:(successfulRequestBlock)success failBlock:(failedFetchBlock)fail
{
    NSManagedObjectContext *context = [[VICoreDataManager getInstance] startTransaction];
    
    NSArray *allItems = [[VICoreDataManager getInstance] arrayForModel:[self objectClassString] forContext:context];
    NSMutableArray *URIs = [NSMutableArray array];
    [allItems enumerateObjectsUsingBlock:^(VIManagedObject *managedObject, NSUInteger idx, BOOL * _Nonnull stop)
    {
        [URIs addObject:managedObject.uID];
    }];

    [existingData enumerateObjectsUsingBlock:^(ParsedObject *parsedObj, NSUInteger idx, BOOL * _Nonnull stop)
    {
        [URIs removeObject:parsedObj.identifier];
    }];
    
    [[VICoreDataManager getInstance] endTransactionForContext:context];

    if (URIs.count)
    {
        NSString *path = [self specificPathWithArray:URIs];
        [self fixWithPath:path success:success failBlock:fail];
    } else
    {
        [self finish:success];
    }
}

-(void)fixWithPath:(NSString *)path success:(successfulRequestBlock)success failBlock:(failedFetchBlock)fail
{
    [[DownloadManager sharedInstance] requestPath:path withSuccessBlock:^(id jsonData) {

        NSError *error = nil;
        NSDictionary *parsedData = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];

        NSArray *notFound = [NSArray arrayWithArray:parsedData[NOT_FOUND]];
        if (notFound.count)
        {

            NSManagedObjectContext *context = [[VICoreDataManager getInstance] startTransaction];

            [notFound enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"uID == %@", notFound[idx]];
                NSArray *fetchResult = [[VICoreDataManager getInstance] arrayForModel:[self objectClassString] withPredicate:predicate forContext:context];
                VIManagedObject *object = [fetchResult firstObject];
                [[VICoreDataManager getInstance] deleteObject:object];
            }];
            [[VICoreDataManager getInstance] endTransactionForContext:context];

            [self finish:success];
        }
    } FailureBlock:^(NSError *error) {
        [self finish:fail];
    }];

}

- (NSString*)path
{
    NSAssert(0, @"Base implementation");
    return nil;
}
-(NSString *)specificPathWithArray:(NSArray *)resourceURIs
{
    NSMutableString *setPath = [[[[self path] stringByDeletingLastPathComponent] stringByAppendingPathComponent:SET_SUFFIX] mutableCopy];
    [setPath appendFormat:@"/"];
    [resourceURIs enumerateObjectsUsingBlock:^(NSNumber *identifier, NSUInteger idx, BOOL * _Nonnull stop) {

        [setPath appendFormat:@"%ld;",(long)[identifier integerValue]];
    }];

    setPath = [[setPath substringToIndex:[setPath length]-1] mutableCopy];

    return [setPath stringByAppendingPathComponent:FORMAT];
}
- (void)cancelRequest
{
    NSAssert(0, @"Base implementation");
}
- (NSString *)objectClassString
{
    NSAssert(0, @"Base implementation");
    return nil;
}
-(void)finish:(successfulRequestBlock)success
{
    dispatch_async(dispatch_get_main_queue(), ^{
        success(nil);
    });
}

@end
