////
////  StreamingDataManager.h
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/11/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//
//@class StreamingDataManager;
//@class StreamingTrack;
//@class StreamingMix;
//
//@protocol StreamingDataManagerProtocol <NSObject>
//-(void)dataManager:(StreamingDataManager *)manager didRetrieveResults:(NSArray*)results;
//-(void)dataManager:(StreamingDataManager *)manager failedToRetrieveResultsWithError:(NSError*)error;
//-(void)dataManagerRequiresAuthentication;
//-(void)dataManagerRequiresSignUp;
//@end
//
//@protocol StreamingUserManagerProtocol <NSObject>
//-(void)dataManagerAuthenticationSuccessful:(id)userData error:(NSError*)error;
//@end
//
//@protocol StreamingPlaybackManagerProtocol <NSObject>
//
//-(void)dataManagerReadyForPlaybackWithTrack:(StreamingTrack*)track atBeginning:(NSNumber*)beginning atEnd:(NSNumber*)end skipAllowed:(NSNumber*)canSkip;
//@end
//
//
//
//
//@interface StreamingDataManager : NSObject
//
//+(StreamingDataManager *)sharedInstance;
//
//@property (nonatomic, assign) id <StreamingDataManagerProtocol> dataDelegate;
//@property (nonatomic, assign) id <StreamingUserManagerProtocol> userDelegate;
//@property (nonatomic, assign) id <StreamingPlaybackManagerProtocol> playbackDelegate;
//
////requires user protocol
//-(void)createUser:(NSString *)name password:(NSString*)password address:(NSString*)email didAgree:(BOOL)agreed;
//-(void)authenticateUser:(NSString*)user credentials:(NSString*)password;
//
////requires data protocol
//-(void)fetchMixes;
//
////required playback protocol
//-(void)play:(NSNumber*)identifier;
//-(void)next:(NSNumber *)identifier;
//-(void)skip:(NSNumber *)identifier;
//-(void)sendReportWithMix:(StreamingMix *)mix andTrack:(StreamingTrack *)track;
//@end
//
//
