//
//  SAFPOIsListCell.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 11/14/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFPOIsListCell.h"
#import "SAFDefines.h"

@implementation SAFPOIsListCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.textLabel.textColor = [UIColor orangeColor];
        self.textLabel.font = [UIFont fontWithName:@"edo" size:20];
        self.detailTextLabel.textColor = [UIColor lightGrayColor];
        self.detailTextLabel.font = [UIFont fontWithName:myriadFontR size:18];
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        
        self.detailTextLabel.numberOfLines = 4;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        CGSize size = [UIScreen mainScreen].bounds.size;
        gradientLayer.frame = CGRectMake(0, 0, size.width, 120);
        [gradientLayer setMasksToBounds:YES];
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x2d2d2d] CGColor],(id)[[UIColor colorWithHex:0x232323] CGColor], nil]];
        [self.layer insertSublayer:gradientLayer atIndex:0];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sageata"]];
        
        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 119, size.width, 1)];
        border.backgroundColor = [UIColor colorWithHex:0x5d5d5d];
        [self.contentView addSubview:border];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
