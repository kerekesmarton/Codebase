//
//  WorkshopDetailsViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/30/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "WorkshopObject.h"

@interface WorkshopDetailsViewController : UIViewController

@property IBOutlet UILabel      *wsTitle;
@property IBOutlet UITextView   *wsDescription;

@property (nonatomic, retain) WorkshopObject *item;

@end
