//
//  SAFMyAgendaTableViewCell.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 8/14/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTableViewCellHeight            90
#define kTableViewCellOffset            75


@interface SAFMyAgendaTableViewCell : UITableViewCell

-(void)clearRows;
-(UIButton *)configureRows:(int)counter artist:(NSString*)artist workshop:(NSString*)workshop level:(NSString*)level;
-(void)configureTimeText:(NSString *)timeText;

@end
