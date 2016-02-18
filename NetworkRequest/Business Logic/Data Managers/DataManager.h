//
//  DataManager.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 18/02/16.
//  Copyright © 2016 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParserDelegate.h"

typedef void (^successfulRequestBlock)(id data);
typedef void (^failedRequestBlock)(id data);
typedef void (^successfulFetchBlock)(id data);
typedef void (^failedFetchBlock)(id data);

@protocol BaseDataManager <NSObject>

@property (nonatomic, strong) NSArray    *items;

- (NSArray *)fetchData:(successfulFetchBlock)success failBlock:(failedFetchBlock)fail;
- (void)requestDataWitchSuccess:(successfulRequestBlock)success failBlock:(failedRequestBlock)fail;
- (void)verifyMissingData:(NSArray *)existingData success:(successfulRequestBlock)success failBlock:(failedFetchBlock)fail;
- (void)cancelRequest;


@end

@interface DataManager : NSObject <BaseDataManager>

- (NSString *)path;
- (NSString *)specificPathWithArray:(NSArray *)resourceURIs;
- (NSString *)objectClassString;
- (void)finish:(successfulRequestBlock)success;
@end
