//
//  SAFNewsTableViewCell.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/20/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFNewsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>

NSInteger kSAFNewsCellHeight = 100;

@interface SAFNewsTableViewCell ()

@property (nonatomic, readwrite) CAGradientLayer *gradientLayer;
@end

@implementation SAFNewsTableViewCell

-(void)setRead:(BOOL)read {
    _gradientLayer.frame = CGRectMake(0, 0, self.frameWidth, kSAFNewsCellHeight);
    if (read == YES){
        self.textLabel.textColor = [UIColor whiteColor];
        self.detailTextLabel.textColor = [UIColor colorWithHex:0x9e9e9e];
        self.gradientLayer.colors = [self readColors];
        self.imageView.alpha = 0.5;
        self.accessoryView.alpha = 0.5;
    } else {
        self.textLabel.textColor = [UIColor redColor];
        self.detailTextLabel.textColor = [UIColor colorWithHex:0x9e9e9e];
        self.gradientLayer.colors = [self unreadColors];
        self.imageView.alpha = 1;
        self.accessoryView.alpha = 1;
    }
}

- (NSArray <UIColor *> *)readColors {
    return @[(id)[[UIColor colorWithHex:0x3c3c3c] CGColor],(id)[[UIColor colorWithHex:0x323232] CGColor]];
}

- (NSArray <UIColor *> *)unreadColors {
    return @[(id)[[UIColor colorWithHex:0x2d2d2d] CGColor],(id)[[UIColor colorWithHex:0x232323] CGColor]];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
            // Initialization code
        self.backgroundView = [[UIView alloc] initWithFrame:[UIDevice isiPad]?CGRectMake(0, 0, 768, kSAFNewsCellHeight):CGRectMake(0, 0, self.boundsWidth, kSAFNewsCellHeight)];
        self.backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.gradientLayer = [CAGradientLayer layer];
        CGSize size = [UIScreen mainScreen].bounds.size;
        self.gradientLayer.frame = CGRectMake(0, 0, size.width, kSAFNewsCellHeight);
        self.gradientLayer.masksToBounds = YES;
        self.gradientLayer.colors = [self readColors];
        [self.contentView.layer insertSublayer:_gradientLayer atIndex:0];
        
        self.textLabel.font = [UIFont fontWithName:futuraCondendsedBold size:20];
        self.detailTextLabel.font = [UIFont fontWithName:@"MyriadPro-It" size:15];
        self.detailTextLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.backgroundColor = [UIColor clearColor];
        
        self.imageView.image = [UIImage imageNamed:@"news_icon"];
        
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sageata"]];
        
        UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, kSAFNewsCellHeight-1, self.frameWidth, 1)];
        border.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        border.backgroundColor = [UIColor colorWithHex:0x5d5d5d];
        [self addSubview:border];
    }
    
    return self;
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
}

@end
