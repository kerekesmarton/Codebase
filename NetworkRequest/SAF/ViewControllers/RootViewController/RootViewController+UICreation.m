//
//  RootViewController+UICreation.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 28/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "RootViewController.h"

@implementation RootViewController (UICreation)

- (void)createUI {
    
    self.view.frame = [UIScreen mainScreen].bounds;
    self.view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    
    self.contents = [[UIScrollView alloc] initWithFrame:self.view.frame];
    self.contents.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.contents];
    
    [self generateNewsButton];
    [self generateWorkshop];
    [self generateScheduleButton];
    [self generateMapButton];
    [self generateShopButton];
    [self generateArtistsButton];
    [self generateMyAgenda];
    [self generateShare];
    [self generateCredits];
    
    self.contents.delaysContentTouches = YES;
    self.contents.contentSize = CGSizeMake(self.view.frame.size.width, kMenuRowHeight*6);
}

-(void) generateNewsButton {
    
    UIView *button = [self generateButton:CGRectMake(0, 0, self.view.frame.size.width, kMenuRowHeight)
                                withTag:RootFunctionNews
                                  title:@"News & Social"
                               andImage:[UIImage imageNamed:@"[news]"]];
    
    [self.contents addSubview:button];
    
    self.newsButton = (UIButton *)[button viewWithTag:RootFunctionNews];
    self.newsAI = (UIActivityIndicatorView *)[button viewWithTag:RootFunctionNews*RootFunctionsCount];
}

- (void)generateWorkshop {
    UIView *button = [self generateButton:CGRectMake(kMenuRowSecondPosX, kMenuRowHeight*1, self.view.frame.size.width-kMenuRowSecondPosX, kMenuRowHeight)
                             withTag:RootFunctionWorkshops
                                title:@"Workshops" andImage:[UIImage imageNamed:@"[workshops]"]];
    [self.contents addSubview:button];
    
    self.workshopsButton = (UIButton *)[button viewWithTag:RootFunctionWorkshops];;
    self.workshopsAI = (UIActivityIndicatorView *)[button viewWithTag:RootFunctionWorkshops*RootFunctionsCount];
}

- (void) generateScheduleButton {
    UIView *button = [self generateButton:CGRectMake(0, kMenuRowHeight*1, kMenuRowSecondPosX, kMenuRowHeight)
                                  withTag:RootFunctionSchedule
                                    title:@"Schedule" andImage:[UIImage imageNamed:@"[schedule]"]];
    [self.contents addSubview:button];
    self.scheduleButton = (UIButton *)[button viewWithTag:RootFunctionSchedule];
    self.scheduleAI = (UIActivityIndicatorView *)[button viewWithTag:RootFunctionSchedule*RootFunctionsCount];
}

- (void)generateMapButton {
    [self.contents addSubview:[self generateButton:CGRectMake(0, kMenuRowHeight*2, self.view.frame.size.width, kMenuRowHeight)
                                           withTag:RootFunctionMap
                                             title:@"Locations & Hotels" andImage:[UIImage imageNamed:@"[location]"]]];
}

- (void)generateShopButton {
    [self.contents addSubview:[self generateButton:CGRectMake(0, kMenuRowHeight*3, self.view.frame.size.width, kMenuRowHeight)
                                           withTag:RootFunctionShop
                                             title:@"Buy your ticket" andImage:[UIImage imageNamed:@"[location]"]]];
}

- (void)generateArtistsButton {
    
    UIView *button = [self generateButton:CGRectMake(0, kMenuRowHeight*4, kMenuRowThirdPosX, kMenuRowHeight)
                                   withTag:RootFunctionArtists
                                     title:@"Artists" andImage:[UIImage imageNamed:@"[artists]"]];
    [self.contents addSubview:button];
    self.artistsButton = (UIButton *)[button viewWithTag:RootFunctionArtists];
    self.artistsAI = (UIActivityIndicatorView *)[button viewWithTag:RootFunctionArtists*RootFunctionsCount];
}

- (void)generateMyAgenda{
    UIView *button = [self generateButton:CGRectMake(kMenuRowThirdPosX, kMenuRowHeight*4, self.view.frame.size.width-kMenuRowThirdPosX, kMenuRowHeight)
                                           withTag:RootFunctionMyAgenda
                                             title:@"My Agenda" andImage:[UIImage imageNamed:@"[agenda]"]];
    [self.contents addSubview:button];
    self.myAgendaButton = (UIButton *)[button viewWithTag:RootFunctionMyAgenda];
    self.myAgendaAI = (UIActivityIndicatorView *)[button viewWithTag:RootFunctionMyAgenda*RootFunctionsCount];
}


- (void)generateShare {
    [self.contents addSubview:[self generateButton:CGRectMake(0, kMenuRowHeight*5, self.view.frame.size.width, kMenuRowHeight)
                                           withTag:RootFunctionShare
                                             title:@"Share"
                                          andImage:[UIImage imageNamed:@"[share]"]]];
}

-(void)generateCredits {
    [self.contents addSubview:[self generateButton:CGRectMake(0, kMenuRowHeight*6, self.view.frame.size.width, kMenuRowHeight)
                                           withTag:RootFunctionCredits
                                             title:@"Credits"
                                          andImage:[UIImage imageNamed:@"[credits]"]]];
}



-(UIView*)generateButton:(CGRect)rect withTag:(int)tagCounter title:(NSString*)title andImage:(UIImage*)image{
    
    UIView *view = [[UIView alloc] initWithFrame:rect];
    view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    
    //button with image
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(kMenuElementBorder, kMenuElementBorder
                              , rect.size.width-2*kMenuElementBorder, rect.size.height-2*kMenuElementBorder);
    button.titleLabel.font = [UIFont fontWithName:futuraCondendsedBold size:btnFontSize];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    button.titleEdgeInsets = UIEdgeInsetsMake(0, kMenuElementBorder, 0, 0);
    [button setBackgroundImage:image forState:UIControlStateNormal];
    
    
    UIImage *originalImage = image;
    
    
    // set B&W image for active
    CGColorSpaceRef colorSapce = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, originalImage.size.width, originalImage.size.height, 8, originalImage.size.width, colorSapce, kCGImageAlphaNone);
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGContextSetShouldAntialias(context, NO);
    CGContextDrawImage(context, CGRectMake(0, 0, originalImage.size.width, originalImage.size.height), [originalImage CGImage]);
    
    CGImageRef bwImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSapce);
    
    UIImage *resultImage = [UIImage imageWithCGImage:bwImage]; // This is result B&W image.
    CGImageRelease(bwImage);
    
    [button setBackgroundImage:resultImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:resultImage forState:UIControlStateDisabled];
    
    
    //Add target to button
    button.tag = tagCounter;
    [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    
    
    UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    activityIndicator.hidden = YES;
    activityIndicator.tag = tagCounter * RootFunctionsCount;
    activityIndicator.frame = button.frame;
    [view addSubview:activityIndicator];
    
    //apply gradient label around it
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.frame = CGRectMake(0, kMenuLabelRelativeY, button.frame.size.width, kMenuLabelHeight);
    [gradientLayer setMasksToBounds:YES];
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithWhite:0.01 alpha:0.8] CGColor],(id)[[UIColor colorWithWhite:0.01 alpha:0.8] CGColor], (id)[[UIColor clearColor] CGColor], nil]];
    
    [button.layer insertSublayer:gradientLayer atIndex:0];
    
    return view;
}

@end
