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
- (void)verifyMissingData:(NSArray *)existingData success:(successfulRequestBlock)success failBlock:(failedRequestBlock)fail
{
//    NSManagedObjectContext *context = [[VICoreDataManager getInstance] startTransaction];
//    
//    NSArray *allItems = [[VICoreDataManager getInstance] arrayForModel:[self objectClassString] forContext:context];
//    
//    [existingData enumerateObjectsUsingBlock:^(ParsedObject *obj, NSUInteger idx, BOOL * _Nonnull stop)
//    {
//        [allItems enumerateObjectsUsingBlock:^(VIManagedObject *managedObject, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//        }];
//    }];
//    
//    [[VICoreDataManager getInstance] endTransactionForContext:context];
//    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        success(nil);
    });

}

- (NSString*)path
{
    NSAssert(1, @"Base implementation");
    return nil;
}
- (void)cancelRequest
{
    NSAssert(1, @"Base implementation");
}
- (NSString *)objectClassString
{
    NSAssert(1, @"Base implementation");
    return nil;
}


@end
