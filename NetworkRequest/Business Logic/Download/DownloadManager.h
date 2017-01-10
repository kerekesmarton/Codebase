//
//  DownloadManager.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AFHTTPRequestOperation;

@interface DownloadManager : NSObject

typedef void (^ ErrorBlock)(NSError *);
typedef void (^ ExecutionBlock)(id);

+(DownloadManager*) sharedInstance;

- (NSOperation *)requestFileForPath:(NSString*)path withSuccessBlock:(ExecutionBlock)successBlock FailureBlock:(ErrorBlock)failureBlock;

- (NSOperation *)requestPath:(NSString*)path withSuccessBlock:(ExecutionBlock)successBlock FailureBlock:(ErrorBlock)failureBlock;

- (NSOperation *)performRequest:(NSURLRequest *)urlRequest withSuccessBlock:(ExecutionBlock)successBlock FailureBlock:(ErrorBlock)failureBlock;

-(NSString*) defaultHeaderTitle;
-(NSString*) defaultHeaderValue;

-(void)cancelAllOperations;
@end
