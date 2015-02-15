//
//  WSFeedbackViewController.h
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 1/7/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WSFeedbackViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate,UIScrollViewDelegate,UIAlertViewDelegate>

- (id)initWithUID:(NSNumber*)uid;

@end
