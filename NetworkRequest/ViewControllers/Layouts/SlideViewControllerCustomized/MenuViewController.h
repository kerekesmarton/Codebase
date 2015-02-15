//
//  MenuViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/9/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CustomSlideMenuDataSourceFactory;
@class CustomSlideMenuDataModel;

@protocol MenuDataDelegate <NSObject>

@required
@property (nonatomic, readonly) CustomSlideMenuDataSourceFactory *dataModel;

-(void)selectItem:(CustomSlideMenuDataModel *)item;

@end

@interface MenuViewController : UITableViewController

@property (nonatomic, assign) id <MenuDataDelegate> delegate;

@end
