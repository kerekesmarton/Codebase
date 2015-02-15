//
//  FMToolbarButton.h
//  ForeverMapNGX
//
//  Created by BogdanB on 7/9/13.
//  Copyright (c) 2013 Skobbler. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum FMToolbarButtonLayout {
    FMToolbarButtonLayoutCenteredTextAndImage,
    FMToolbarButtonLayoutBottomTextCenterImage
    
} FMToolbarButtonLayout;

@interface FMToolbarButton : UIControl {
    
    @protected
    
    UILabel         *_label;
    UIImageView     *_imageView;
}

@property (nonatomic, retain) UIImage   *image;
@property (nonatomic, retain) UIImage   *highlightedImage;
@property (nonatomic, retain) UIImage   *disabledImage;
@property (nonatomic, retain) NSString  *text;
@property (nonatomic, retain) UIColor   *textColor;
@property (nonatomic, retain) UIColor   *highlightedTextColor;
@property (nonatomic, retain) UIColor   *disabledTextColor;
@property (nonatomic, retain) UIFont    *textFont;
@property (nonatomic, retain) UIColor   *normalStateColor;
@property (nonatomic, retain) UIColor   *highlightedStateColor;
@property (nonatomic, retain) UIColor   *disabledColor;
@property (nonatomic, assign) FMToolbarButtonLayout layout;

- (id)initWithFrame:(CGRect)frame;

@end