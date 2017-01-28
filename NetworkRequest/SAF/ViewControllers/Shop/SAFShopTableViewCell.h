//
//  SAFShopTableViewCell.h
//  NetworkRequest
//
//  Created by Marton Kerekes on 28/01/2017.
//  Copyright © 2017 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAFShopTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *currentPrice;
@property (strong, nonatomic) IBOutlet UILabel *previousPrice;
@property (strong, nonatomic) IBOutlet UILabel *details;

@end
