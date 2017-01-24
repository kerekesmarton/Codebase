//
//  CustomSlideMenuDataModel.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/8/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "CustomSlideMenuDataModel.h"

#import "NewsViewController.h"
#import "ArtistsViewController.h"
#import "WorkshopsViewController.h"
#import "AgendaViewController.h"
#import "MapViewController.h"


@implementation CustomSlideMenuDataModel

+(CustomSlideMenuDataModel *)emptyDataModel {
    
    CustomSlideMenuDataModel *object = [[self alloc] init];
    
    object.title = @"";
    object.iconName = @"";
    object.functionsViewControllerClass = NSClassFromString(@"NSObject");
    object.completionBlock = ^(){};
    object.requiresNib = YES;
    object.nibName = @"";
    object.requiresTransparentNavigationBar = NO;
    object.enabled = YES;
    
    return object;
}

+(CustomSlideMenuDataModel *)news {
    
    CustomSlideMenuDataModel *object = [self emptyDataModel];
    object.title = @"News";
    object.functionsViewControllerClass = NSClassFromString(@"NewsViewController");
    object.iconName = @"comments";
    object.nibName = NSStringFromClass(object.functionsViewControllerClass);
    
    return object;
}
+(CustomSlideMenuDataModel *)artist {
    
    CustomSlideMenuDataModel *object = [self emptyDataModel];
    object.title = @"Artists";
    object.iconName = @"users";
    object.functionsViewControllerClass = NSClassFromString(@"ArtistsViewController");
    object.nibName = NSStringFromClass(object.functionsViewControllerClass);
    
    return object;
}
+(CustomSlideMenuDataModel *)workshops {
    
    CustomSlideMenuDataModel *object = [self emptyDataModel];
    object.title = @"Workshops";
    object.iconName = @"clock";
    object.functionsViewControllerClass = NSClassFromString(@"WorkshopsViewController");
    object.nibName = NSStringFromClass(object.functionsViewControllerClass);
    
    return object;
}
+(CustomSlideMenuDataModel *)agenda {
    
    CustomSlideMenuDataModel *object = [self emptyDataModel];
    object.title = @"Agenda";
    object.iconName = @"page_full";
    object.functionsViewControllerClass = NSClassFromString(@"AgendaViewController");
    object.nibName = NSStringFromClass(object.functionsViewControllerClass);
    
    return object;
}
+(CustomSlideMenuDataModel *)calendar {
    
    CustomSlideMenuDataModel *object = [self emptyDataModel];
    object.title = @"Calendar";
    object.iconName = @"calendar";
    object.functionsViewControllerClass = NSClassFromString(@"CalendarMonthViewController");
    object.requiresNib = NO;
    
    return object;
}
+(CustomSlideMenuDataModel *)map {
    
    CustomSlideMenuDataModel *object = [self emptyDataModel];
    object.title = @"Map";
    object.iconName = @"world";
    object.functionsViewControllerClass = NSClassFromString(@"MapViewController");
    object.nibName = NSStringFromClass(object.functionsViewControllerClass);
    object.requiresTransparentNavigationBar = NO;
    object.enabled = YES;
        
    return object;
}

+(CustomSlideMenuDataModel *)radio {
    
    CustomSlideMenuDataModel *object = [self emptyDataModel];
    object.title = @"Radio";
    object.iconName = @"radio";
    object.functionsViewControllerClass = NSClassFromString(@"RadioViewController");
    object.nibName = NSStringFromClass(object.functionsViewControllerClass);
    
    return object;
}

-(void)enableOnNotification:(NSNotification *)notification {
    
//    if ([self.title isEqualToString: @"Map"] && [notification.name isEqualToString:kSKMapsLibraryInitialisedNotification]) {
//        self.enabled = YES;
//        [[NSNotificationCenter defaultCenter] removeObserver:self];
//    }
}
@end
