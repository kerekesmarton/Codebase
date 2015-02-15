////
////  StreamingDataManager.m
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/11/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "StreamingDataManager.h"
//#import "StreamingContentManager.h"
//#import "SBJSON.h"
//#import "StreamingUser.h"
//#import "StreamingMix.h"
//#import "SettingsManager.h"
//#import "StreamingTrack.h"
//#import "AVPlayerManager.h"
//
//@implementation StreamingDataManager
//
//@synthesize dataDelegate,userDelegate,playbackDelegate;
//
//+(StreamingDataManager *)sharedInstance {
//    static dispatch_once_t onceToken;
//    static StreamingDataManager *instance = nil;
//    dispatch_once(&onceToken, ^{
//        instance = [[self alloc] init];
//    });
//    return instance;
//}
//
//#pragma mark - play section
//
//-(void)play:(NSNumber *)identifier {
//    
//    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"streamingUserLoginToken"];
//    if (!token) {
//        if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(dataManagerRequiresAuthentication)]) {
//            [self.dataDelegate dataManagerRequiresAuthentication];
//        }
//        return;
//    }
//    
//    NSString *playToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"streamingPlaybackToken"];
//    if (playToken) {
//        [[StreamingContentManager sharedInstance] playMix:identifier withPlaybackToken:playToken userToken:token success:^(NSData *response) {
//            
//            [self playWithResponse:response];
//        } failure:^(NSError *error) {
//            //
//        }];
//    } else {
//        [[StreamingContentManager sharedInstance] askForPlaybackTokenWithUserToken:token success:^(NSData *response) {
//            //
//            if ([self savePlayTokenWithResponse:response]) {
//                [self play:identifier];
//            } else {
//                if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(dataManagerRequiresAuthentication)]) {
//                    [self.dataDelegate dataManagerRequiresAuthentication];
//                }
//                return;
//            }
//        } failure:^(NSError *error) {
//            //
//            [self authenticationFailed:error];
//        }];
//    }
//}
//
//-(void)next:(NSNumber *)identifier {
//    
//    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"streamingUserLoginToken"];
//    if (!token) {
//        if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(dataManagerRequiresAuthentication)]) {
//            [self.dataDelegate dataManagerRequiresAuthentication];
//        }
//        return;
//    }
//    
//    NSString *playToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"streamingPlaybackToken"];
//    if (playToken) {
//        [[StreamingContentManager sharedInstance] playMix:identifier withPlaybackToken:playToken userToken:token success:^(NSData *response) {
//            //
//            [self playWithResponse:response];
//        } failure:^(NSError *error) {
//            //
//        }];
//    } else {
//        [[StreamingContentManager sharedInstance] askForPlaybackTokenWithUserToken:token success:^(NSData *response) {
//            //
//            if ([self savePlayTokenWithResponse:response]) {
//                [self play:identifier];
//            }
//        } failure:^(NSError *error) {
//            //
//            [self authenticationFailed:error];
//        }];
//    }
//}
//
//-(void)skip:(NSNumber *)identifier {
//    
//    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"streamingUserLoginToken"];
//    if (!token) {
//        if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(dataManagerRequiresAuthentication)]) {
//            [self.dataDelegate dataManagerRequiresAuthentication];
//        }
//        return;
//    }
//    
//    NSString *playToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"streamingPlaybackToken"];
//    if (playToken) {
//        [[StreamingContentManager sharedInstance] playMix:identifier withPlaybackToken:playToken userToken:token success:^(NSData *response) {
//            //
//            [self playWithResponse:response];
//        } failure:^(NSError *error) {
//            //
//        }];
//    } else {
//        [[StreamingContentManager sharedInstance] askForPlaybackTokenWithUserToken:token success:^(NSData *response) {
//            //
//            if ([self savePlayTokenWithResponse:response]) {
//                [self play:identifier];
//            }
//        } failure:^(NSError *error) {
//            //
//            [self authenticationFailed:error];
//        }];
//    }
//}
//
//-(BOOL)playWithResponse:(NSData *)response {
//    
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSString *stringData = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//    NSDictionary *data = [parser objectWithString:stringData];
//    
//    NSString *status = [data objectForKey:@"status"];
//    NSString *notices = [data objectForKey:@"notices"];
//    NSString *loggedIn = [data objectForKey:@"logged_in"];
//    
//    if ([status hasPrefix:@"20"]) {
//        //successful login
//    } else {
//        //error
//        NSLog(@"Error, status %@\n notices %@",status,notices);
//        return NO;
//    }
//    
//    if ([loggedIn intValue] == 1) {
//        //session OK
//        NSLog(@"%@",notices);
//    } else {
//        NSLog(@"Session invalid");
//        return NO;
//    }
//    
//    NSDictionary *set = [data objectForKey:@"set"];
//    
//    /*
//     at-beginning: true if you are at the first track in the mix
//     at-last-track: true if you reached the final track in the mix.
//     at-end: true if you are past the final track.
//     skip-allowed: 
//     */
//    NSNumber *beginning = [set objectForKey:@"at_beginning"];
//    NSNumber *end = [set objectForKey:@"at_last_track"];
//    NSNumber *skipAllowed = [set objectForKey:@"skip_allowed"];
//    NSDictionary *trackData = [set objectForKey:@"track"];
//    StreamingTrack *track = [StreamingTrack streamingTrackWithDictionary:trackData];
//    
//    if (self.playbackDelegate && [self.playbackDelegate respondsToSelector:@selector(dataManagerReadyForPlaybackWithTrack:atBeginning:atEnd:skipAllowed:)]) {
//        [[self playbackDelegate] dataManagerReadyForPlaybackWithTrack:track atBeginning:beginning atEnd:end skipAllowed:skipAllowed];
//    }
//    
//    return YES;
//}
//
//-(BOOL)savePlayTokenWithResponse:(NSData *)response {
//    
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSString *stringData = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//    NSDictionary *data = [parser objectWithString:stringData];
//    
//    NSString *status = [data objectForKey:@"status"];
//    if (status && [status hasPrefix:@"20"]) {
//        //successful login
//    } else {
//        //error
//        NSLog(@"Error logging in, status %@",status);
//        return NO;
//    }
//    
//    NSString *token = [data objectForKey:@"play_token"];
//    NSString *notices = [data objectForKey:@"notices"];
//    NSString *loggedIn = [data objectForKey:@"logged_in"];
//    if (loggedIn == nil || [loggedIn intValue] == 1) {
//        //session OK
//        NSLog(@"%@",notices);
//    } else {
//        NSLog(@"Session invalid");
//        return NO;
//    }
//    
//    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"streamingPlaybackToken"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    return YES;
//}
//
//-(void)sendReportWithMix:(StreamingMix *)mix andTrack:(StreamingTrack *)track {
//    
//    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"streamingUserLoginToken"];
//    [[StreamingContentManager sharedInstance]reportMixID:mix.identifier andTrackID:track.identifier userToken:token];
//}
//
//#pragma mark - listing section
//
//-(void)fetchMixes {
//    
//    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"streamingUserLoginToken"];
//    if (token) {
//        [[StreamingContentManager sharedInstance] mixesWithToken:token tags:[SettingsManager sharedInstance].selectedTags.selectedValues success:^(NSData *response) {
//            //send list
//            SBJsonParser *parser = [[SBJsonParser alloc] init];
//            NSString *stringData = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
//            NSDictionary *data = [parser objectWithString:stringData];
//            
//            NSString *loggedIn = [data objectForKey:@"logged_in"];
//            if (![loggedIn boolValue]) {
//                //auth failed. token expired.
//                //TODO: alert
//                if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(dataManagerRequiresAuthentication)]) {
//                    [self.dataDelegate dataManagerRequiresAuthentication];
//                }
//            } else
//            if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(dataManager:didRetrieveResults:)]) {
//                
//                NSArray *mixes = [data objectForKey:@"mixes"];
//                [self.dataDelegate dataManager:self didRetrieveResults:[self mixesWithData:mixes]];
//            }
//            
//        } failure:^(NSError *error) {
//            //prompt user to authenticate or treat error otherwise
//            if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(dataManager:failedToRetrieveResultsWithError:)]) {
//                [self.dataDelegate dataManager:self failedToRetrieveResultsWithError:error];
//            }
//        }];
//    } else {
//        //prompt user to authenticate for the first time.
//        if (self.dataDelegate && [self.dataDelegate respondsToSelector:@selector(dataManagerRequiresAuthentication)]) {
//            [self.dataDelegate dataManagerRequiresAuthentication];
//        }
//    }
//}
//
//
//-(NSArray*)mixesWithData:(NSArray*)data {
//    
//    NSMutableArray *mixes = [NSMutableArray array];
//    
//    for (NSDictionary *item in data) {
//        StreamingMix *mix = [StreamingMix mixWithData:item];
//        [mixes addObject:mix];
//    }
//    
//    return [NSArray arrayWithArray:mixes];
//}
//
//
//#pragma mark - user auth section
//
//-(void)createUser:(NSString *)name password:(NSString*)password address:(NSString*)email didAgree:(BOOL)agreed {
//    
//    [[StreamingContentManager sharedInstance] createUser:name withCredentials:password email:email agreed:[NSNumber numberWithBool:agreed] success:^(NSData *response) {
//        [self authenticateSuccessful:response];
//    } failure:^(NSError *error) {
//        [self authenticationFailed:error];
//    }];
//}
//
//-(void)authenticateUser:(NSString*)user credentials:(NSString*)password {
//    
//    [[StreamingContentManager sharedInstance] verifyUser:user withCredentials:password success:^(NSData *response) {
//        [self authenticateSuccessful:response];
//    } failure:^(NSError *error) {
//        [self authenticationFailed:error];
//    }];
//}
//
//-(BOOL)authenticateSuccessful:(NSData*)data {
//    
//    SBJsonParser *parser = [[SBJsonParser alloc] init];
//    NSString *stringData = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    NSDictionary *object = [parser objectWithString:stringData];
//    
//    NSString *status = [object objectForKey:@"status"];
//    if ([status hasPrefix:@"20"]) {
//        //successful login
//    } else {
//        //error
//        NSLog(@"Error logging in, status %@",status);
//        return NO;
//    }
//    
//    NSString *token = [object objectForKey:@"user_token"];
//    NSDictionary *user = [object objectForKey:@"current_user"];
//    [StreamingUser userWithDictionary:user];
//    NSString *notices = [object objectForKey:@"notices"];
//    NSString *loggedIn = [object objectForKey:@"logged_in"];    
//    if ([loggedIn intValue] == 1) {
//        //session OK
//        NSLog(@"%@",notices);
//    } else {
//        NSLog(@"Session invalid");
//        return NO;
//    }
//    
//    
//    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"streamingUserLoginToken"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//    
//    if (self.userDelegate && [self.userDelegate respondsToSelector:@selector(dataManagerAuthenticationSuccessful:error:)]) {
//        [self.userDelegate dataManagerAuthenticationSuccessful:user error:nil];
//    }
//    
//    return YES;
//}
//
//-(void)authenticationFailed:(NSError*)error {
//    
//    if (self.userDelegate && [self.userDelegate respondsToSelector:@selector(dataManagerAuthenticationSuccessful:error:)]) {
//        [self.userDelegate dataManagerAuthenticationSuccessful:nil error:error];
//    }
//}
//
//@end
