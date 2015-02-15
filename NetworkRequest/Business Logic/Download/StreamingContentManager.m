////
////  StreamingContentManager.m
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/11/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "StreamingContentManager.h"
//#import "SBJSON.h"
//#import "AFHTTPClient.h"
//#import "AFHTTPRequestOperation.h"
//
//#define devAPIString_8Tracks        @"b9aa449d18fdb7578ff5f88185b7cbd85088737f"
//
//@interface StreamingContentManager (Private)
//- (void)performRequest:(NSURLRequest *)urlRequest withSuccessBlock:(ExecutionBlock)successBlock FailureBlock:(ErrorBlock)failureBlock;
//-(NSString *)baseURL;
//-(NSString *)secureBaseURL;
//-(NSString *)defaultHeaderTitle;
//-(NSString *)defaultHeaderValue;
//@end
//
//@implementation StreamingContentManager {
//    
//    AFHTTPClient *client;
//}
//
//+(StreamingContentManager *)sharedInstance {
//    static dispatch_once_t onceToken;
//    static StreamingContentManager *instance = nil;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc] init];
//    });
//    
//    return instance;
//}
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        client = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:[self baseURL]]];
//    }
//    return self;
//}
//
//-(void)askForPlaybackTokenWithUserToken:(NSString *)userToken success:(ExecutionBlock)success failure:(ExecutionBlock)failure {
//    
//    NSString *path = [NSString stringWithFormat:@"sets/new?format=json"];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:5];
//    
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    //add API key
//    [mutableRequest addValue:[self defaultHeaderValue] forHTTPHeaderField:[self defaultHeaderTitle]];
//    
//    //add user session token
//    [mutableRequest addValue:userToken forHTTPHeaderField:@"X-User-Token"];
//    
//    request = [mutableRequest copy];
//    [self performRequest:request withSuccessBlock:success FailureBlock:failure];
//}
//
//-(void)playMix:(NSNumber *)identifier withPlaybackToken:(id)playToken userToken:(id)token success:(ExecutionBlock)success failure:(ExecutionBlock)failure {
//    
//    NSString *path = [NSString stringWithFormat:@"play?format=json"];
//    path = [path stringByAppendingFormat:@"&mix_id=%@",identifier];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:5];
//    
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    //add API key
//    [mutableRequest addValue:[self defaultHeaderValue] forHTTPHeaderField:[self defaultHeaderTitle]];
//    
//    //add user session token
//    [mutableRequest addValue:token forHTTPHeaderField:@"X-User-Token"];
//    
//    request = [mutableRequest copy];
//    [self performRequest:request withSuccessBlock:success FailureBlock:failure];
//}
//
//-(void)nextMix:(NSNumber *)identifier withPlaybackToken:(id)playToken userToken:(id)token success:(ExecutionBlock)success failure:(ExecutionBlock)failure {
//    
//    NSString *path = [NSString stringWithFormat:@"next?format=json"];
//    path = [path stringByAppendingFormat:@"&mix_id=%@",identifier];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:5];
//    
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    //add API key
//    [mutableRequest addValue:[self defaultHeaderValue] forHTTPHeaderField:[self defaultHeaderTitle]];
//    
//    //add user session token
//    [mutableRequest addValue:token forHTTPHeaderField:@"X-User-Token"];
//    
//    request = [mutableRequest copy];
//    [self performRequest:request withSuccessBlock:success FailureBlock:failure];
//}
//
//-(void)skipMix:(NSNumber *)identifier withPlaybackToken:(id)playToken userToken:(id)token success:(ExecutionBlock)success failure:(ExecutionBlock)failure {
//    
//    NSString *path = [NSString stringWithFormat:@"skip?format=json"];
//    path = [path stringByAppendingFormat:@"&mix_id=%@",identifier];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:5];
//    
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    //add API key
//    [mutableRequest addValue:[self defaultHeaderValue] forHTTPHeaderField:[self defaultHeaderTitle]];
//    
//    //add user session token
//    [mutableRequest addValue:token forHTTPHeaderField:@"X-User-Token"];
//    
//    request = [mutableRequest copy];
//    [self performRequest:request withSuccessBlock:success FailureBlock:failure];
//}
//
//-(void)reportMixID:(NSNumber *)mixID andTrackID:(NSNumber *)trackID userToken:(NSString *)token{
//    /*
//     http://8tracks.com/sets/874076615/report.xml?track_id=[track_id]&mix_id=[mix_id]
//     */
//
//    NSString *path = [NSString stringWithFormat:@"report?format=json"];
//    path = [path stringByAppendingFormat:@"&track_id=%d&mix_id=%d",[trackID intValue],[mixID intValue]];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:5];
//    
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    //add API key
//    [mutableRequest addValue:[self defaultHeaderValue] forHTTPHeaderField:[self defaultHeaderTitle]];
//    
//    //add user session token
//    [mutableRequest addValue:token forHTTPHeaderField:@"X-User-Token"];
//    
//    request = [mutableRequest copy];
//    [self performRequest:request withSuccessBlock:^(id data) {
//        NSLog(@"reported sond successfuly");
//    } FailureBlock:^(NSError *error) {
//        NSLog(@"%@",error.userInfo);
//    }];
//
//}
//
//-(void)createUser:(NSString*)username withCredentials:(NSString*)password email:(NSString*)email agreed:(NSNumber*)didAgree success:(ExecutionBlock)success failure:(ExecutionBlock)failure {
//    
//    NSString *path = [NSString stringWithFormat:@"sessions?format=json"];
//    
//    //curl --header 'X-Api-Key: xxxxxx' --request POST -d "user[login]=remi&user[password]=password&user[email]=remi@8tracks.com&user[agree_to_terms]=1" https://8tracks.com/users.xml
//
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:10];
//    
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    //add API key
//    [mutableRequest addValue:[self defaultHeaderValue] forHTTPHeaderField:[self defaultHeaderTitle]];
//    
//    //setup credentials
//    [mutableRequest setHTTPMethod:@"POST"];
//    NSString *authStr = [NSString stringWithFormat:@"user[login]=%@&user[password]=%@&user[email]=%@&user[agree_to_terms]=%d", username, password,email,[didAgree boolValue]];
//    NSData *authData = [NSData dataWithBytes:[authStr UTF8String] length:[authStr length]];
//    [mutableRequest setHTTPBody:authData];
//    
//    request = [mutableRequest copy];
//    [self performRequest:request withSuccessBlock:success FailureBlock:failure];
//}
//
//-(void)verifyUser:(NSString*)username withCredentials:(NSString*)password success:(ExecutionBlock)success failure:(ExecutionBlock)failure {
//    
//    //curl --request POST -d "login=remitest&password=password" https://8tracks.com/sessions.xml
//    
//    NSString *path = [NSString stringWithFormat:@"sessions?format=json"];
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:10];
//    
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    //add API key
//    [mutableRequest addValue:[self defaultHeaderValue] forHTTPHeaderField:[self defaultHeaderTitle]];
//    
//    //setup credentials
//    [mutableRequest setHTTPMethod:@"POST"];
//    NSString *authStr = [NSString stringWithFormat:@"login=%@&password=%@", username, password];
//    NSData *authData = [NSData dataWithBytes:[authStr UTF8String] length:[authStr length]];
//    [mutableRequest setHTTPBody:authData];
//    
//    request = [mutableRequest copy];    
//    [self performRequest:request withSuccessBlock:success FailureBlock:failure];
//}
//
//-(void)mixesWithToken:(NSString*)token tags:(NSArray *)tags success:(ExecutionBlock)success failure:(ExecutionBlock)failure {
//    
//    //curl  --header "X-User-Token: 1;123456789" --request POST -d "" http://8tracks.com/mixes.xml
//    
//    NSString *path = [NSString stringWithFormat:@"mixes?format=json"];
//    
//    if (tags.count > 0) {
//        path = [path stringByAppendingString:@"&tags="];
//    }
//    
//    for (NSString *tag in tags) {
//        path = [path stringByAppendingFormat:@"%@",tag];
//        if (![tag isEqual:[tags lastObject]]) {
//            path = [path stringByAppendingString:@"%%2B"];
//        }
//    }
//    
//    
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[[self baseURL] stringByAppendingPathComponent:path]] cachePolicy:NSURLCacheStorageAllowed timeoutInterval:5];
//    
//    NSMutableURLRequest *mutableRequest = [request mutableCopy];
//    
//    //add API key
//    [mutableRequest addValue:[self defaultHeaderValue] forHTTPHeaderField:[self defaultHeaderTitle]];
//    
//    //add user session token
//    [mutableRequest addValue:token forHTTPHeaderField:@"X-User-Token"];
//    
//    request = [mutableRequest copy];
//    [self performRequest:request withSuccessBlock:success FailureBlock:failure];
//}
//
//@end
//
//@implementation StreamingContentManager (Private)
//
//- (void)performRequest:(NSURLRequest *)urlRequest withSuccessBlock:(ExecutionBlock)successBlock FailureBlock:(ErrorBlock)failureBlock {
//    
//    AFHTTPRequestOperation *operation = [client HTTPRequestOperationWithRequest:urlRequest success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        successBlock(responseObject);
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        failureBlock(error);
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
//    }];
//    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
//        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    }];
//    [client enqueueHTTPRequestOperation:operation];
//}
//
//-(NSString *)baseURL {
//    return @"http://8tracks.com/";
//}
//-(NSString *)secureBaseURL {
//    return @"https://8tracks.com/";
//}
//-(NSString *)defaultHeaderTitle {
//    return @"X-Api-Key";
//}
//-(NSString *)defaultHeaderValue {
//    return devAPIString_8Tracks;
//}
//
//@end
