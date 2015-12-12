//
//  DownloadManager.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "DownloadManager.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFXMLRequestOperation.h"

@implementation DownloadManager {
    
    AFHTTPClient        *_client;
}

+(DownloadManager*) sharedInstance {
    static DownloadManager *_downloadManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _downloadManager = [[DownloadManager alloc] init];
    });
    return _downloadManager;
}

- (id)init
{
    self = [super init];
    if (self) {
        _client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[self baseURL]]];
    }
    return self;
}

-(void)cancelAllOperations {
    [_client.operationQueue cancelAllOperations];
}

- (NSOperation *)requestFileForPath:(NSString*)path withSuccessBlock:(ExecutionBlock)successBlock FailureBlock:(ErrorBlock)failureBlock {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self imageHost] stringByAppendingPathComponent:path]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:30];
    
    return [self performRequest:request withSuccessBlock:successBlock FailureBlock:failureBlock];
}

-(NSOperation *)requestPath:(NSString *)path withSuccessBlock:(ExecutionBlock)successBlock FailureBlock:(ErrorBlock)failureBlock {
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
    
    return [self performRequest:request withSuccessBlock:successBlock FailureBlock:failureBlock];
}

#pragma mark - private

- (NSOperation *)performRequest:(NSURLRequest *)urlRequest withSuccessBlock:(ExecutionBlock)successBlock FailureBlock:(ErrorBlock)failureBlock {
    
    AFHTTPRequestOperation *operation = [_client HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
        successBlock(responseObject);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    }];
    [_client enqueueHTTPRequestOperation:operation];
    
    return operation;
}

-(NSString *)imageHost {
    return @"http://airedancecompany.ro/SAF/";
}

-(NSString *)baseURL {
    return @"http://saf9.airedancecompany.ro/";
}

-(NSString *)defaultHeaderTitle {
    return nil;
}

-(NSString *)defaultHeaderValue {
    return nil;
}

@end
