//
//  ParsedNews.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedObject.h"

@interface ParsedNews : ParsedObject

@property (nonatomic, strong) NSString *pubDate;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong, getter = isRead) NSNumber *read;
@property (nonatomic, strong, getter = isDeleted) NSNumber *deleted;

@end
