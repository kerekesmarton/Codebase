//
//  DetailsViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "NewsObject.h"

@interface DetailsViewController : UIViewController

@property (nonatomic, assign) IBOutlet  UITextView  *textView;
@property (nonatomic, strong) NewsObject  *item;
@end
