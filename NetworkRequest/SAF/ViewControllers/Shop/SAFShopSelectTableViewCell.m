//
//  SAFShopTableViewCell.m
//  NetworkRequest
//
//  Created by Marton Kerekes on 28/01/2017.
//  Copyright © 2017 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFShopSelectTableViewCell.h"

@implementation SAFShopSelectTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    
    [self.title setTextColor:[UIColor whiteColor]];
    [self.title setFont:[UIFont fontWithName:futuraCondendsedBold size:20]];
    self.title.textAlignment = NSTextAlignmentCenter;
    
    [self.currentPrice setTextColor:[UIColor whiteColor]];
    [self.currentPrice setFont:[UIFont fontWithName:futuraCondendsedBold size:20]];
    self.currentPrice.textAlignment = NSTextAlignmentCenter;
    
    [self.previousPrice setTextColor:[UIColor whiteColor]];
    [self.previousPrice setFont:[UIFont fontWithName:futuraCondendsedBold size:20]];
    self.previousPrice.textAlignment = NSTextAlignmentCenter;
    
    [self.details setTextColor:[UIColor whiteColor]];
    [self.details setFont:[UIFont fontWithName:futuraCondendsedBold size:20]];
    self.details.textAlignment = NSTextAlignmentLeft;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
