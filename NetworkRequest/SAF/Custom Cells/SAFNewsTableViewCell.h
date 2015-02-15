//
//  SAFNewsTableViewCell.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/20/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSInteger kSAFNewsCellHeight;

@interface SAFNewsTableViewCell : UITableViewCell

@property (nonatomic, readonly) CAGradientLayer *gradientLayer;
@property (nonatomic) BOOL read;

@end
