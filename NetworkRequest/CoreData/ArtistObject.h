//
//  ArtistObject.h
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 12/26/12.
//  Copyright (c) 2012 Jozsef-Marton Kerekes. All rights reserved.
//

#import "VIManagedObject.h"

#define kartistRURI          @"resourceURI"
#define kArtistNameKey       @"artistName"
#define kArtistLocKey        @"artistLoc"
#define kArtistTypeKey       @"artistType"
#define kArtistDesc1Key      @"artistDesc1"
#define kArtistDesc2Key      @"artistDesc2"
#define kArtistImgKey        @"artistImg"
#define kArtistIDKey         @"artistID"
#define kArtistSoloKey       @"artistSolo"
//#define kArtistImgDataKey    @"artistImgData"


@interface ArtistObject : VIManagedObject

@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *loc;
@property (nonatomic, retain) NSString *type;
@property (nonatomic, retain) NSString *desc1;
@property (nonatomic, retain) NSString *desc2;
@property (nonatomic, retain) NSString *img;
@property (nonatomic, retain) NSNumber *solo;

+(NSArray*)fetchArtists;
+(NSArray*)fetchNonSoloArtists;
+(ArtistObject*)artistForSolo:(NSNumber*)solo;
+(NSArray*)solosForArtist:(NSNumber*)artistID;
+(NSArray*)artistsOfType:(NSArray*)type;
+(ArtistObject*)artistForId:(NSNumber*)idNum;
+(NSArray *)fetchArtistsForCurrentSettingsType;
@end
