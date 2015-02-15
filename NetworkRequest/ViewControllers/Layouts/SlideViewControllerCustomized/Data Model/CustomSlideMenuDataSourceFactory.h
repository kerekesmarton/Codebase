//
//  CustomSlideMenuDataSourceFactory.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/8/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CustomSlideMenuDataModel.h"

@interface CustomSlideMenuDataSourceFactory : NSObject

@property (nonatomic, strong) NSString  *title;
@property (nonatomic, strong) NSArray   *objects;

+(CustomSlideMenuDataSourceFactory *)mainMenuData;

@end
