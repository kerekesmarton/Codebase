//
//  CustomSlideMenuDataModel.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/8/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomSlideMenuDataModel : NSObject

@property (nonatomic, retain)   NSString    *title;
@property (nonatomic, retain)   NSString    *iconName;
@property (nonatomic, retain)   Class       functionsViewControllerClass;
@property (nonatomic, retain)   NSString    *nibName;
@property (nonatomic, copy)     void        (^completionBlock)(void);
@property (nonatomic, assign)   BOOL        requiresNib;
@property (nonatomic, assign)   BOOL        requiresTransparentNavigationBar;
@property (nonatomic, assign)   BOOL        enabled;

+(CustomSlideMenuDataModel *)emptyDataModel;



+(CustomSlideMenuDataModel *)news;
+(CustomSlideMenuDataModel *)artist;
+(CustomSlideMenuDataModel *)workshops;
+(CustomSlideMenuDataModel *)agenda;
+(CustomSlideMenuDataModel *)calendar;
+(CustomSlideMenuDataModel *)map;
+(CustomSlideMenuDataModel *)radio;

@end
