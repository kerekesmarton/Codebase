//
//  SAFArtistsTableViewCell.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/22/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFArtistsTableViewCell.h"

@implementation SAFArtistsTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = [UIColor whiteColor];
        self.textLabel.font = [UIFont fontWithName:futuraCondendsedBold size:20];
        self.textLabel.numberOfLines = 2;
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.font = [UIFont fontWithName:futuraCondendsedBold size:15];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textAlignment = NSTextAlignmentCenter;
        self.detailTextLabel.textAlignment = NSTextAlignmentCenter;
        
        self.backgroundView = [[UIView alloc] initWithFrame:[UIDevice isiPad]?CGRectMake(0, 0, 768, 80):CGRectMake(0, 0, self.boundsWidth, 80)];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        CGSize size = [UIScreen mainScreen].bounds.size;
        gradientLayer.frame = CGRectMake(0, 0, size.width, 90);
        [gradientLayer setMasksToBounds:YES];
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x3c3c3c] CGColor],(id)[[UIColor colorWithHex:0x323232] CGColor], nil]];
        
        [self.backgroundView.layer addSublayer:gradientLayer];

    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
