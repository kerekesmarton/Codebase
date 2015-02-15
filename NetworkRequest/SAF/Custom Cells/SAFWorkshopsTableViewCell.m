//
//  SAFWorkshopsTableViewCell.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/21/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFWorkshopsTableViewCell.h"
#import <QuartzCore/QuartzCore.h>
#import "SAFDefines.h"

@implementation SAFWorkshopsTableViewCell {
    UILabel *_instructor;
    UILabel *_name;
    UILabel *_diff;
    UILabel *_date;
}

-(UILabel *)instructor {
    
    return _instructor;
}

-(UILabel *)name {
    
    return _name;
}

-(UILabel *)diff {
    
    return _diff;
}

-(UILabel *)date {
    
    return _date;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.contentView.clipsToBounds = YES;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        CAGradientLayer *gradientLayer = [CAGradientLayer layer];
        
        CGSize size = [UIScreen mainScreen].bounds.size;
        gradientLayer.frame = CGRectMake(0, 0, size.width, 90);
        [gradientLayer setMasksToBounds:YES];
        [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x3c3c3c] CGColor],(id)[[UIColor colorWithHex:0x323232] CGColor], nil]];
        [self.contentView.layer insertSublayer:gradientLayer atIndex:0];
        
        _instructor = [[UILabel alloc] initWithFrame:CGRectMake(90, 10, self.frameWidth-110, 24)];
        _instructor.numberOfLines = 1;
        _instructor.font = [UIFont fontWithName:@"edo" size:18];
        _instructor.textColor = [UIColor whiteColor];
        _instructor.backgroundColor = [UIColor clearColor];
        _instructor.textAlignment = NSTextAlignmentCenter;
        _instructor.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_instructor];
        
        _name = [[UILabel alloc] initWithFrame:CGRectMake(90, CGRectGetMaxY(_instructor.frame), self.frameWidth-110, 20)];
        _name.numberOfLines = 1;
        _name.font = [UIFont fontWithName:myriadFontB size:16];
        _name.textColor = [UIColor whiteColor];
        _name.backgroundColor = [UIColor clearColor];
        _name.textAlignment = NSTextAlignmentCenter;
        _name.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_name];
        
        _diff = [[UILabel alloc] initWithFrame:CGRectMake(90, CGRectGetMaxY(_name.frame), self.frameWidth-110, 20)];
        _diff.numberOfLines = 1;
        _diff.font = [UIFont fontWithName:myriadFontI size:16];
        _diff.textColor = [UIColor whiteColor];
        _diff.backgroundColor = [UIColor clearColor];
        _diff.textAlignment = NSTextAlignmentCenter;
        _diff.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:_diff];
        
        _date = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 70, 80)];
        [_date setTextColor:[UIColor whiteColor]];
        [_date setFont:[UIFont fontWithName:myriadFontR size:20]];
        _date.backgroundColor = [UIColor clearColor];
        _date.textAlignment = NSTextAlignmentCenter;
        _date.numberOfLines = 3;
        [self.contentView addSubview:_date];
        
    }
    return self;
}

- (void)setFavorited:(BOOL)value {
    
    
    if (value) {
        CGSize newSize= [UIImage imageNamed:@"favorite"].size;
        self.accessoryView = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"favorite"] scaleToSize:CGSizeMake(newSize.width*0.9, newSize.height*0.9)]];
    } else {
        self.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sageata"]];
    }
}

-(void)setDifficulty:(NSInteger)difficulty {
    
    switch (difficulty) {
        case 1:
            self.diff.text = DIFFICULTY_LEVEL_1;
            break;
        case 2:
            self.diff.text = DIFFICULTY_LEVEL_2;
            break;
        case 3:
            self.diff.text = DIFFICULTY_LEVEL_3;
            break;
        case 4:
            self.diff.text = DIFFICULTY_LEVEL_4;
            break;
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
