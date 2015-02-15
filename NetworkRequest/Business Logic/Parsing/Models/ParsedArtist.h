//
//  ParsedArtist.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 27/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ParsedObject.h"

@interface ParsedArtist : ParsedObject

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSString *desc1;
@property (nonatomic, strong) NSString *desc2;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *loc;

@end
