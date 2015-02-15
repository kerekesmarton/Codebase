//
//  NewsDataManager.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ParserDelegate.h"

typedef void (^successfulRequestBlock)(id data);
typedef void (^failedRequestBlock)(id data);
typedef void (^successfulFetchBlock)(id data);
typedef void (^failedFetchBlock)(id data);


@protocol BaseDataManager <NSObject>

@property (nonatomic, strong) NSArray    *items;

- (NSArray *) fetchData:(successfulFetchBlock)success failBlock:(failedFetchBlock)fail;
- (void) requestDataWitchSuccess:(successfulRequestBlock)success failBlock:(failedRequestBlock)fail;
- (NSString*) path;

- (void)cancelRequest;

@end
