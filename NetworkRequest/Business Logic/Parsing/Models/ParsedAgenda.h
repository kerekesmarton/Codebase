//
//  ParsedAgenda.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedObject.h"

@interface ParsedAgenda : ParsedObject

@property (nonatomic, strong) NSNumber  *isoWeekday;
@property (nonatomic, strong) NSNumber  *type;
@property (nonatomic, strong) NSString  *loc;
@property (nonatomic, strong) NSString  *details;
@property (nonatomic, strong) NSDate    *time;
@property (nonatomic, strong) NSDate    *endTime;
@end
