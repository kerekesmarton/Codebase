//
//  SAFMyAgendaTableViewCell.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 8/14/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFMyAgendaTableViewCell.h"
#import "SAFDefines.h"

@implementation SAFMyAgendaTableViewCell {
    
    NSMutableArray *rows;
    UILabel *date;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.backgroundColor = [UIColor colorWithHex:0x2d2d2d];
        
        date = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 65, self.frameHeight)];
        [date setFont:[UIFont fontWithName:myriadFontR size:20]];
        date.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        date.backgroundColor = [UIColor clearColor];
        date.textAlignment = NSTextAlignmentCenter;
        [date setTextColor:[UIColor redColor]];
        date.numberOfLines = 0;
        [self.contentView addSubview:date];
        
        
        rows = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)configureTimeText:(NSString *)timeText {
    
    date.text = timeText;
}

-(void)clearRows{
    
    [rows enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL *stop) {
        [obj removeFromSuperview];
    }];
    [rows removeAllObjects];
}

-(UIButton *)configureRows:(NSInteger)counter artist:(NSString*)artist workshop:(NSString*)workshop level:(NSString*)level room:(NSString *)room{
    
    UIButton *wsButton = [self createButtonForDetails:artist workshop:workshop level:level room:room];
    CGSize size = [UIScreen mainScreen].bounds.size;
    wsButton.frame = CGRectMake(kTableViewCellOffset, 10 + counter*(kTableViewCellHeight), size.width-kTableViewCellOffset, kTableViewCellHeight);
    [self.contentView addSubview:wsButton];
    [rows addObject:wsButton];
    
    return wsButton;
}

-(UIButton*)createButtonForDetails:(NSString*)artist workshop:(NSString*)workshop level:(NSString*)level room:(NSString *)room{
    
    UIImage *img = [[UIImage imageNamed:@"agendaBtnBG"] resizableImageWithCapInsets:UIEdgeInsetsMake(8, 8, 8, 8)];
    
    UIButton *wsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    
    CGSize size = [UIScreen mainScreen].bounds.size;
    
    wsButton.frame = CGRectMake(kTableViewCellOffset, 0, size.width-kTableViewCellOffset, kTableViewCellHeight);
    [wsButton setBackgroundImage:img forState:UIControlStateNormal];
    wsButton.backgroundColor = [UIColor clearColor];
    
    UILabel *instructor = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, size.width-kTableViewCellOffset, 24)];
    instructor.numberOfLines = 1;
    instructor.font = [UIFont fontWithName:futuraCondendsedBold size:18];
    instructor.textColor = [UIColor whiteColor];
    instructor.backgroundColor = [UIColor clearColor];
    instructor.text = artist;
    instructor.textAlignment = NSTextAlignmentCenter;
    [wsButton addSubview:instructor];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(instructor.frame), size.width-kTableViewCellOffset, 20)];
    name.numberOfLines = 1;
    name.font = [UIFont fontWithName:myriadFontB size:16];
    name.textColor = [UIColor whiteColor];
    name.backgroundColor = [UIColor clearColor];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = workshop;
    [wsButton addSubview:name];
    
    UILabel *diff = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame), size.width-kTableViewCellOffset, 20)];
    diff.numberOfLines = 1;
    diff.font = [UIFont fontWithName:myriadFontI size:16];
    diff.textColor = [UIColor whiteColor];
    diff.backgroundColor = [UIColor clearColor];
    diff.textAlignment = NSTextAlignmentCenter;
    [wsButton addSubview:diff];
    diff.text = [NSString stringWithFormat:@"%@, %@", level, room];
    
    return wsButton;
}

@end
