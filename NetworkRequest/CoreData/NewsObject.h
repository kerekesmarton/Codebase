//
//  NewsObject.h
//  Festival
//
//  Created by Jozsef-Marton Kerekes on 3/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "VIManagedObject.h"

#define newsRURI                @"resourceURI"
#define newsTitleKey            @"title"
#define newsLinkKey             @"link"
#define newsDescriptionKey      @"desc"
#define newsDeleted             @"del"
#define newsRead                @"read"
#define newsTimeStamp           @"timeStamp"
#define newsIdentifier          @"id"



@interface NewsObject : VIManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSNumber * del;
@property (nonatomic, retain) NSNumber * read;
@property (nonatomic, retain) NSDate   * timeStamp;

+(NSArray *)fetchUndeletedNews;
+(NSArray *)fetchNews;
-(void)markAsDeleted;
@end
