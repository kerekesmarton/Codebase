//
//  SlideViewControllerPhone.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/9/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SlideViewController.h"

@interface SlideViewControllerPhone : SlideViewController <UIGestureRecognizerDelegate>

- (void)slideOutSlideNavigationControllerViewDirection:(FMSlideMenuSide)direction;
- (void)slideInSlideNavigationControllerView;
- (void)menuBarButtonItemClicked;
@end
