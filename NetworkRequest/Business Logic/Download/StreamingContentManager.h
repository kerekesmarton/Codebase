////
////  StreamingContentManager.h
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/11/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "DownloadManager.h"
//
//@interface StreamingContentManager : NSObject
//
//+(StreamingContentManager *)sharedInstance;
//
////auth
//-(void)createUser:(NSString*)username withCredentials:(NSString*)password email:(NSString*)email agreed:(NSNumber*)didAgree success:(ExecutionBlock)success failure:(ExecutionBlock)failure;
//-(void)verifyUser:(NSString*)username withCredentials:(NSString*)password success:(ExecutionBlock)success failure:(ExecutionBlock)failure;
//
////listing
//-(void)mixesWithToken:(NSString*)token tags:(NSArray *)tags success:(ExecutionBlock)success failure:(ExecutionBlock)failure;
//
////playback
//-(void)askForPlaybackTokenWithUserToken:(NSString *)userToken success:(ExecutionBlock)success failure:(ExecutionBlock)failure;
//-(void)playMix:(NSNumber *)identifier withPlaybackToken:playToken userToken:token success:(ExecutionBlock)success failure:(ExecutionBlock)failure;
//-(void)nextMix:(NSNumber *)identifier withPlaybackToken:(id)playToken userToken:(id)token success:(ExecutionBlock)success failure:(ExecutionBlock)failure;
//-(void)skipMix:(NSNumber *)identifier withPlaybackToken:(id)playToken userToken:(id)token success:(ExecutionBlock)success failure:(ExecutionBlock)failure;
//-(void)reportMixID:(NSNumber *)mixID andTrackID:(NSNumber *)trackID userToken:(NSString *)token;
//@end
