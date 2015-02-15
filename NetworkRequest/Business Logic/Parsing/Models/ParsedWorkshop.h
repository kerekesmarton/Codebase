//
//  WorkshopObject.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 26/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedObject.h"

@interface ParsedWorkshop : ParsedObject

@property (nonatomic, strong) NSNumber  *difficulty;
@property (nonatomic, strong) NSNumber  *instructor;
@property (nonatomic, strong) NSNumber  *isoWeekday;
@property (nonatomic, strong) NSString  *loc;
@property (nonatomic, strong) NSDate    *time;
@property (nonatomic, strong) NSDate    *endTime;

@end
