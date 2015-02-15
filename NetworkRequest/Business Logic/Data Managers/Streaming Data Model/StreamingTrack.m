////
////  StreamingTrack.m
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/16/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "StreamingTrack.h"
//
//@implementation StreamingTrack
//
//@synthesize releaseName,favoritedByUser,name,duration,performer,identifier,url;
//
//+(StreamingTrack*)streamingTrackWithDictionary:(NSDictionary*)dictionary {
//    
//    NSString *releaseName = [dictionary objectForKey:@"release_name"];
//    NSString *fav = [dictionary objectForKey:@"faved_by_current_user"];
//    NSString *name = [dictionary objectForKey:@"name"];
//    NSString *duration = [dictionary objectForKey:@"play_duration"];
//    NSString *performer = [dictionary objectForKey:@"performer"];
//    NSString *identifier = [dictionary objectForKey:@"identifier"];
//    NSString *url = [dictionary objectForKey:@"url"];
//    
//    
//    StreamingTrack *track = [[self alloc] init];
//    track.releaseName = releaseName;
//    track.favoritedByUser = [NSNumber numberWithBool:[fav boolValue]];
//    track.name = name;
//    track.duration = [NSNumber numberWithInt:[duration intValue]];
//    track.performer = performer;
//    track.identifier = [NSNumber numberWithInt:[identifier intValue]];
//    track.url = url;
//    
//    return track;
//    
//}
//
//@end
