//
//  MenuTableViewCell.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 9/10/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "MenuTableViewCell.h"
//#import <QuartzCore/QuartzCore.h>

@implementation MenuTableViewCell {
    UIImageView *topShadow;
    UIImageView *bottomShadow;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.textLabel.textColor = [UIColor whiteColor];
        self.indentationLevel = 1;
        self.backgroundColor = [UIColor clearColor];
        
//        topShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_details"]];
//        topShadow.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        topShadow.frame = CGRectMake(0.0, -14.0, 14, self.frameWidth);
////        topShadow.transform = CGAffineTransformMakeRotation(degreesToRadians(-90));
//        
//        bottomShadow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"shadow_details"]];
//        bottomShadow.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//        bottomShadow.frame = CGRectMake(0.0, self.frameHeight+14, 14,self.frameWidth);
////        bottomShadow.transform = CGAffineTransformMakeRotation(degreesToRadians(90));
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (selected) {
            self.imageView.transform = CGAffineTransformMakeTranslation(30, 0);
            self.textLabel.transform = CGAffineTransformMakeTranslation(30, 0);
        } else {
            self.textLabel.transform = CGAffineTransformIdentity;
            self.imageView.transform = CGAffineTransformIdentity;
        }
    } completion:^(BOOL finished) {
        
    }];
}

@end
