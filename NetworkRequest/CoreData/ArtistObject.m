//
//  ArtistObject.m
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 12/26/12.
//  Copyright (c) 2012 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ArtistObject.h"
#import "SettingsManager.h"

@implementation ArtistObject

@dynamic name;
@dynamic loc;
@dynamic type;
@dynamic desc1;
@dynamic desc2;
@dynamic img;
@dynamic id_num;
@dynamic solo;


+ (id)addWithParams:(NSDictionary *)params forManagedObjectContext:(NSManagedObjectContext *)context
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_num == %@", [params objectForKey:kArtistIDKey]];
    
    NSArray *items = [[VICoreDataManager getInstance] arrayForModel:@"ArtistObject" withPredicate:predicate forContext:context];
    
    ArtistObject *item = (ArtistObject *)[items lastObject];
    
    if (item != nil) {
        return [self editWithParams:params forObject:item];
    } else {
        return [self syncWithParams:params forManagedObjectContext:context];
    }
}

+ (id)setInformationFromDictionary:(NSDictionary *)params forObject:(NSManagedObject *)object
{
    ArtistObject *item = (ArtistObject *)object;
    
    item.name = [[params objectForKey:kArtistNameKey]    isKindOfClass:[NSNull class]] ? item.name  : [params objectForKey:kArtistNameKey];
    item.loc  = [[params objectForKey:kArtistLocKey]     isKindOfClass:[NSNull class]] ? item.loc   : [params objectForKey:kArtistLocKey];
    item.type  = [[params objectForKey:kArtistTypeKey]   isKindOfClass:[NSNull class]] ? item.type  : [params objectForKey:kArtistTypeKey];
    item.desc1  = [[params objectForKey:kArtistDesc1Key] isKindOfClass:[NSNull class]] ? item.desc1 : [params objectForKey:kArtistDesc1Key];
    item.desc2  = [[params objectForKey:kArtistDesc2Key] isKindOfClass:[NSNull class]] ? item.desc2 : [params objectForKey:kArtistDesc2Key];
    item.img = [[params objectForKey:kArtistImgKey] isKindOfClass:[NSNull class]] ? item.img : [params objectForKey:kArtistImgKey];
//    item.imgData = [[params objectForKey:kArtistImgDataKey] isKindOfClass:[NSNull class]] ? item.imgData : [params objectForKey:kArtistImgDataKey];
    item.id_num = [[params objectForKey:kArtistIDKey] isKindOfClass:[NSNull class]] ? item.id_num : [params objectForKey:kArtistIDKey];
    item.solo = [[params objectForKey:kArtistSoloKey] isKindOfClass:[NSNull class]] ? item.solo : [params objectForKey:kArtistSoloKey];
    
    return item;
}

+(NSArray*)fetchArtists {
    
    return [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class])];
}

+(NSArray*)fetchNonSoloArtists {
    
    return [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([self class]) withPredicate:[NSPredicate predicateWithFormat:@"solo == null"] forContext:[VICoreDataManager getInstance].managedObjectContext];
}

+(ArtistObject*)artistForSolo:(NSNumber*)solo {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_num == %@", solo];
    
    NSArray *items = [[VICoreDataManager getInstance] arrayForModel:@"ArtistObject" withPredicate:predicate forContext:[[VICoreDataManager getInstance] managedObjectContext]];
    
    ArtistObject *item = (ArtistObject *)[items lastObject];
    
    return item;
}

+(NSArray*)solosForArtist:(NSNumber*)artistID {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"solo == %@", artistID];
    
    NSArray *items = [[VICoreDataManager getInstance] arrayForModel:@"ArtistObject" withPredicate:predicate forContext:[[VICoreDataManager getInstance] managedObjectContext]];
    
    return [NSArray arrayWithArray:items];
}

+(NSArray *)fetchArtistsForCurrentSettingsType {
    
    return [ArtistObject artistsOfType:[SettingsManager sharedInstance].artistsFilter.selectedValues];
}

+(NSArray *)artistsOfType:(NSArray *)type {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"type == %@", [type lastObject]];
    
    NSArray *items = [[VICoreDataManager getInstance] arrayForModel:@"ArtistObject" withPredicate:predicate forContext:[[VICoreDataManager getInstance] managedObjectContext]];
    
    return [items sortedArrayUsingComparator:^NSComparisonResult(ArtistObject *obj1, ArtistObject *obj2) {
        return [[obj1 name] compare:[obj2 name]];
    }];
}

+(ArtistObject*)artistForId:(NSNumber*)idNum {
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"id_num == %@", idNum];
    
    NSArray *items = [[VICoreDataManager getInstance] arrayForModel:@"ArtistObject" withPredicate:predicate forContext:[VICoreDataManager getInstance].managedObjectContext];
    
    ArtistObject *item = (ArtistObject *)[items lastObject];
    
    return item;
}
@end
