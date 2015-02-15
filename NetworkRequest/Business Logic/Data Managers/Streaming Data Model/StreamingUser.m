////
////  StreamingUser.m
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/16/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "StreamingUser.h"
//
//@implementation StreamingUser
//
//@synthesize identifier,login,slug,imgName,path,followedByCurrentUser,bioHTML,followsCount,subscribed;
//
///*
// @property (nonatomic, strong) NSNumber      *identifier;
// @property (nonatomic, strong) NSString      *login;
// @property (nonatomic, strong) NSString      *slug;//short name
// @property (nonatomic, strong) NSString      *path;
// @property (nonatomic, strong) NSString      *imgName;
// @property (nonatomic, strong) NSNumber      *followedByCurrentUser;
// 
// 
// @property (nonatomic, strong) NSString      *bioHTML;
// @property (nonatomic, strong) NSNumber      *followsCount;
// @property (nonatomic, strong) NSNumber      *subscribed;
// */
//
//+(StreamingUser *)userWithDictionary:(NSDictionary *)dictionary{
//    
//    StreamingUser *user = [[StreamingUser alloc] init];
//    
//    NSDictionary *avatars = [dictionary objectForKey:@"avatar_urls"];
//    user.imgName = [avatars objectForKey:@"max250w"]; 
//    
//    
//    user.identifier = [dictionary objectForKey:@"id"];
//    user.login = [dictionary objectForKey:@"login"];
//    user.slug = [dictionary objectForKey:@"slug"];
//    user.path = [dictionary objectForKey:@"path"];
//    user.followedByCurrentUser = [dictionary objectForKey:@"followed_by_current_user"];
//    
//    user.bioHTML = [dictionary objectForKey:@"bio_html"];
//    user.followsCount = [dictionary objectForKey:@"follows_count"];
//    user.subscribed = [dictionary objectForKey:@"subscribed"];
//    
//    return user;
//}
//
//@end
