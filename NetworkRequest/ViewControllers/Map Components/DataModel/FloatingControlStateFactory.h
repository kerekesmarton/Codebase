//
//  FloatingControlStateFactory.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapDefines.h"


@interface FloatingControlDataModel : NSObject

@property (nonatomic, retain)   NSString    *title;
@property (nonatomic, retain)   NSString    *imageTitle;
@property (nonatomic, retain)   NSArray     *views;
@property (nonatomic, copy)     void        (^action)(int/*row*/,int/*index*/);

@end


@interface FloatingControlStateFactory : NSObject

+(FloatingControlDataModel *)dataSourceForState:(FLoatingControlState)state;

+(void)setStaticSearchObject:(SKSearchResult *)searchObject;

@end

