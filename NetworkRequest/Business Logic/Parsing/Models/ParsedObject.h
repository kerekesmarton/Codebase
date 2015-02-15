//
//  ParsedObject.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 26/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParsedObject : NSObject

@property (nonatomic, strong) NSNumber *identifier;
@property (nonatomic, strong) NSString *resourceUri;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *name;

- (NSDictionary *)dictionaryRepresentation;

@end
