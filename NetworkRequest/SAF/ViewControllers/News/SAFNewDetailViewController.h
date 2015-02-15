//
//  SAFNewDetailViewController.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/20/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "DetailsViewController.h"

@interface SAFNewDetailViewController : DetailsViewController

@property (nonatomic, assign) IBOutlet UIView       *gradient;
@property (nonatomic, assign) IBOutlet UILabel      *titleLbl;
@property (nonatomic, assign) IBOutlet UILabel      *detailsLbl;
@property (nonatomic, assign) IBOutlet UITextView   *detailsText;
@property (nonatomic, assign) IBOutlet UIButton     *share;

@end
