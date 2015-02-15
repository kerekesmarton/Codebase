//
//  StreamingMix.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 10/16/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//
//
//#import "StreamingMix.h"
//#import "StreamingUser.h"
//
//@interface StreamingMix (Helpers)
//+(NSCharacterSet*)dateSeparatorSet;
//+(NSDate *)dateFromString:(NSString *)published;
//@end
//
//@implementation StreamingMix
//
//@synthesize covers,desc,duration,path,identifier,likedByUser,likes,name,playsCount,user,url,tags,published;
//
//+(StreamingMix *)mixWithData:(NSDictionary *)item {
//    
//    //read
//    NSDictionary *covers = [item objectForKey:@"cover_urls"];
//    NSString *description = [item objectForKey:@"description"];
//    NSString *duration = [item objectForKey:@"duration"];
//    NSString *published = [item objectForKey:@"first_published_at"];
//    NSString *identifier = [item objectForKey:@"id"];
//    NSString *likedByUser = [item objectForKey:@"liked_by_current_user"];
//    NSString *likes = [item objectForKey:@"likes_count"];
//    NSString *name = [item objectForKey:@"name"];
//    NSString *path = [item objectForKey:@"path"];
//    NSString *playsCount = [item objectForKey:@"playes_count"];
//    NSString *url = [item objectForKey:@"restful_url"];
//    NSString *tags = [item objectForKey:@"tag_list_cache"];
//    NSString *tracksCount = [item objectForKey:@"tracks_count"];
//    NSDictionary *userD = [item objectForKey:@"user"];
//    StreamingUser *user = [StreamingUser userWithDictionary:userD];
//    
//    //set
//    StreamingMix *mix = [[self alloc] init];
//    mix.covers = covers;
//    mix.desc = description;
//    mix.duration = [NSNumber numberWithInt:[duration intValue]];
//    mix.published = [self dateFromString:published];
//    mix.identifier = [NSNumber numberWithInt:[identifier intValue]];
//    mix.likedByUser = [NSNumber numberWithBool:[likedByUser intValue]];
//    mix.likes = [NSNumber numberWithInt:[likes intValue]];
//    mix.name = name;
//    mix.path = path;
//    mix.playsCount = [NSNumber numberWithInt:[playsCount intValue]];
//    mix.url = url;
//    mix.tags = [tags componentsSeparatedByString:@", "];
//    mix.tracksCounts = [NSNumber numberWithInt:[tracksCount intValue]];
//    mix.user = user;
//    
//    return mix;    
//}
//
//@end
//
//@implementation StreamingMix (Helpers)
//
//+(NSCharacterSet*)dateSeparatorSet {
//    static dispatch_once_t onceToken;
//    static NSCharacterSet *separatorSet;
//    dispatch_once(&onceToken, ^{
//        separatorSet = [NSCharacterSet characterSetWithCharactersInString:@"-TZ"];
//    });
//    return separatorSet;
//}
//
//+(NSDate *)dateFromString:(NSString *)published {
//    NSArray *componentsArray = [published componentsSeparatedByCharactersInSet:[self dateSeparatorSet]];
//    NSDateComponents *comps = [[NSDateComponents alloc] init];
//    if ([componentsArray objectAtIndex:3]) {
//        NSString *time = [componentsArray objectAtIndex:3];
//        NSArray *timeComponents = [time componentsSeparatedByString:@":"];
//        
//        if ([timeComponents count] > 2) {
//            NSNumber *seconds = [timeComponents objectAtIndex:2];
//            [comps setSecond:[seconds intValue]];
//        }
//        if ([timeComponents count] > 1) {
//            NSNumber *minutes = [timeComponents objectAtIndex:1];
//            [comps setMinute:[minutes intValue]];
//        }
//        if ([timeComponents count] > 0) {
//            NSNumber *hours = [timeComponents objectAtIndex:0];
//            [comps setHour:[hours intValue]];
//        }
//    }
//    if ([componentsArray count] > 2) {
//        NSNumber *dayN = [componentsArray objectAtIndex:2];
//        [comps setDay:[dayN intValue]];
//    }
//    if ([componentsArray count] > 1) {
//        NSNumber *monthN = [componentsArray objectAtIndex:1];
//        [comps setMonth:[monthN intValue]];
//    }
//    if ([componentsArray count] > 0) {
//        NSNumber *yearN = [componentsArray objectAtIndex:0];
//        [comps setYear:[yearN intValue]];
//    }
//    
//    NSCalendar *gregorian = [[NSCalendar alloc]
//                             initWithCalendarIdentifier:NSGregorianCalendar];
//    NSDate *date = [gregorian dateFromComponents:comps];
//    
//    return date;
//}
//
//@end