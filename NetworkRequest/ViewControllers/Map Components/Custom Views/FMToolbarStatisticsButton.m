//
//  FMToolbarStatisticsButton.m
//  ForeverMapNGX
//
//  Created by Kerekes Jozsef-Marton on 8/27/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import "FMToolbarStatisticsButton.h"

@implementation FMToolbarStatisticsButton {
    
    UILabel *_secondLabel;
    UILabel *_thirdLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)addLabel {
    
    _label = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _imageView.frameMaxY, self.boundsWidth, self.boundsHeight - _imageView.frameMaxY)];
    _label.text = @"";
    _label.textAlignment = NSTextAlignmentCenter;
    _label.backgroundColor = [UIColor clearColor];
    _label.highlightedTextColor = [UIColor whiteColor];
    _label.font = [UIFont fontWithName:@"Avenir" size:16.0];
    _label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self addSubview:_label];
    [_label release];
    
//    _secondLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _imageView.frameMaxY, self.boundsWidth, self.boundsHeight - _imageView.frameMaxY)];
//    _secondLabel.text = @"measurement_units_text";
//    _secondLabel.textAlignment = NSTextAlignmentCenter;
//    _secondLabel.backgroundColor = [UIColor clearColor];
//    _secondLabel.highlightedTextColor = [UIColor whiteColor];
//    _secondLabel.font = [UIFont fontWithName:@"Avenir" size:16.0];
//    _secondLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [self addSubview:_secondLabel];
//    [_secondLabel release];
//    
//    _thirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, _imageView.frameMaxY, self.boundsWidth, self.boundsHeight - _imageView.frameMaxY)];
//    _thirdLabel.text = @"detail_text";
//    _thirdLabel.textAlignment = NSTextAlignmentCenter;
//    _thirdLabel.backgroundColor = [UIColor clearColor];
//    _thirdLabel.highlightedTextColor = [UIColor whiteColor];
//    _thirdLabel.font = [UIFont fontWithName:@"Avenir" size:16.0];
//    _thirdLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    [self addSubview:_thirdLabel];
//    [_thirdLabel release];
}

@end
