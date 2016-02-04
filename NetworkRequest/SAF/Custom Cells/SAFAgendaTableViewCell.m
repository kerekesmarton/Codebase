//
//  SAFAgendaTableViewCell.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/29/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFAgendaTableViewCell.h"
#import "SAFDefines.h"

@implementation SAFAgendaTableViewCell {
    
    UILabel *info;
    UILabel *date;
    UIView *border;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
        self.contentView.clipsToBounds = YES;
        self.contentMode = UIViewContentModeRedraw;
        self.contentView.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
        self.selectionStyle = UITableViewCellSeparatorStyleNone;
        
        info = [[UILabel alloc] initWithFrame:CGRectNull];
        info.numberOfLines = 0;
        info.font = [UIFont fontWithName:myriadFontI size:16];
        info.textColor = [UIColor whiteColor];
        info.backgroundColor = [UIColor clearColor];
        info.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        info.lineBreakMode = NSLineBreakByWordWrapping;
        [self.contentView addSubview:info];
        
        date = [[UILabel alloc] initWithFrame:CGRectNull];
        [date setTextColor:[UIColor whiteColor]];
        [date setFont:[UIFont fontWithName:futuraCondendsedBold size:20]];
        date.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
        date.textAlignment = NSTextAlignmentCenter;
        [date setTextColor:[UIColor redColor]];
        date.numberOfLines = 0;
        [self.contentView addSubview:date];
        
        border = [[UIView alloc] initWithFrame:CGRectNull];
        border.backgroundColor = [UIColor colorWithHex:0x5d5d5d];
        border.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:border];
    }
    return self;
}

-(void)setInfo:(NSString *)infoString andDate:(NSString *)dateString {
    
    CGSize constraint = CGSizeMake([UIDevice isiPad]?658:210, 999);
    CGSize size = [infoString sizeWithFont:[UIFont fontWithName:myriadFontB size:16] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    info.frame = CGRectMake(90, 10, [UIDevice isiPad]?658:210, size.height*1.2);
    info.text = infoString;
    
    date.frame = CGRectMake(10, 0, 70, MAX(size.height*1.2 + 10, 80));
    [date setText:dateString];
    
    border.frame = CGRectMake(0, MAX(size.height*1.2 + 9, 79), [UIDevice isiPad]?768:320, 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
