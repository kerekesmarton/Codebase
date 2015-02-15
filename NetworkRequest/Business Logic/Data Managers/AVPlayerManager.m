////
////  AVPlayerManager.m
////  NetworkRequest
////
////  Created by Jozsef-Marton Kerekes on 10/16/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "AVPlayerManager.h"
//#import <AVFoundation/AVFoundation.h>
//
//#import "StreamingMix.h"
//#import "StreamingTrack.h"
//#import "StreamingDataManager.h"
//
//@interface AVPlayerManager () <StreamingPlaybackManagerProtocol>
//
//@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
//@property (nonatomic, strong) StreamingTrack *currentTrack;
//
//@end
//
//@implementation AVPlayerManager
//
//@synthesize mix,delegate,currentTrack;
//
//+(AVPlayerManager *)sharedInstance {
//    
//    static dispatch_once_t onceToken;
//    static AVPlayerManager *staticInstace = nil;
//    dispatch_once(&onceToken, ^{
//        staticInstace = [[self alloc] init];
//    });
//    return staticInstace;
//}
//
//-(BOOL)play {
//    
//    if (!self.mix) {
//        //nothing to interrupt
//        return NO;
//    }
//    
//    if ([self.audioPlayer isPlaying]) {
//        //don't interrupt
//        return NO;
//    }
//    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    
//    [StreamingDataManager sharedInstance].playbackDelegate = self;
//    [[StreamingDataManager sharedInstance] play:self.mix.identifier];
//    
//    return YES;
//}
//
//-(BOOL)stop {
//    
//    [NSObject cancelPreviousPerformRequestsWithTarget:self];
//    [self.audioPlayer stop];
//    
//    return YES;
//}
//
//-(BOOL)togglePaused {
//    
//    if (!self.audioPlayer) {
//        return NO;
//    }
//    
//    if ([self.audioPlayer isPlaying]) {
//        [NSObject cancelPreviousPerformRequestsWithTarget:self];
//        [self.audioPlayer pause];
//        return YES;
//    } else {
//        int interval = 30 - self.audioPlayer.duration;
//        if (interval > 0) {
//            [self performSelector:@selector(sendReport) withObject:self.currentTrack afterDelay:interval];
//        }
//        [self.audioPlayer play];
//        return YES;    
//    }
//    return NO;
//}
//
//-(void)dataManagerReadyForPlaybackWithTrack:(StreamingTrack *)track atBeginning:(NSNumber *)beginning atEnd:(NSNumber *)end skipAllowed:(NSNumber *)canSkip {
//    self.currentTrack = track;
//    
//    NSString* resourcePath = track.url;
//    NSData *_objectData = [NSData dataWithContentsOfURL:[NSURL URLWithString:resourcePath]];
//    NSError *error;
//    
//    self.audioPlayer = [[AVAudioPlayer alloc] initWithData:_objectData error:&error];
//    self.audioPlayer.numberOfLoops = 0;
//    self.audioPlayer.volume = 1.0f;
//    [self.audioPlayer prepareToPlay];
//    
//    if (self.audioPlayer == nil) {
//        NSLog(@"%@", [error description]);
//    }
//    else {
//        if ([[self delegate] respondsToSelector:@selector(playbackStarting)]) {
//            [[self delegate] playbackStarting];
//        }
//        [self.audioPlayer play];
//        
//        [self performSelector:@selector(sendReport) withObject:self.currentTrack afterDelay:30];
//    }
//    
//    if ([beginning boolValue] && [[self delegate] respondsToSelector:@selector(playerAtFirstTrack)]) {
//        [[self delegate] playerAtFirstTrack];
//    }
//    if ([end boolValue] && [[self delegate] respondsToSelector:@selector(playerAtLastTrack)]) {
//        [[self delegate] playerAtLastTrack];
//    }
//    if ([canSkip boolValue] && [[self delegate] respondsToSelector:@selector(playerCanSkip)]) {
//        [[self delegate] playerCanSkip];
//    }
//}
//
//-(void)sendReport:(StreamingTrack *)track {
//    
//    if ([self.audioPlayer duration] < 30) {
//        return;
//    }
//    
//    
//}
//
//@end
