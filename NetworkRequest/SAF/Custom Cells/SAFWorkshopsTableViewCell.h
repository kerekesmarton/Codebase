//
//  SAFWorkshopsTableViewCell.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/21/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SAFWorkshopsTableViewCell : UITableViewCell

@property (nonatomic, readonly) UILabel *instructor;
@property (nonatomic, readonly) UILabel *name;
@property (nonatomic, readonly) UILabel *diff;
@property (nonatomic, readonly) UILabel *date;
@property (nonatomic, assign)   BOOL    favorited;
@property (nonatomic, assign) NSInteger difficulty;
@end
