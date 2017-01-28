//
//  RootViewController.h
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/19/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>


#define kDeviceIsIpad                        ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad)

#define kMenuRowHeight                       (100+kDeviceIsIpad*94)//81
#define kMenuRowRelativeLabelY               (30+kDeviceIsIpad*25)//20

#define kMenuRowSecondPosX                   self.view.frame.size.width/2//160
#define kMenuRowThirdPosX                    self.view.frame.size.width/2//160

#define kMenuLabelRelativeY                  (kMenuRowHeight / 3)
#define kMenuLabelHeight                     (22+20*kDeviceIsIpad)
#define kMenuElementBorder                   6
#define kMenuElementBorderColor              [UIColor colorWithHex:0x3b3938]
#define kMenuElementButtonColor              [UIColor colorWithWhite:0.7 alpha:1]


#define btnFontSize                          (20+18*kDeviceIsIpad)


typedef enum RootFunctions{
    
    RootFunctionNews = 1,
    RootFunctionWorkshops,
    RootFunctionSchedule,
    RootFunctionMap,
    RootFunctionShop,
    RootFunctionArtists,
    RootFunctionMyAgenda,
    RootFunctionShare,
    RootFunctionCredits,
    RootFunctionsCount
    
} RootFunctions;

typedef void (^viewDidLoadBlock)(id param);


@interface RootViewController : UIViewController

@property (nonatomic, strong) UIScrollView *contents;

@property (nonatomic, weak) UIButton *newsButton;
@property (nonatomic, weak) UIButton *workshopsButton;
@property (nonatomic, weak) UIButton *myAgendaButton;
@property (nonatomic, weak) UIButton *artistsButton;
@property (nonatomic, weak) UIButton *scheduleButton;

@property (nonatomic, weak) UIActivityIndicatorView *newsAI;
@property (nonatomic, weak) UIActivityIndicatorView *workshopsAI;
@property (nonatomic, weak) UIActivityIndicatorView *myAgendaAI;
@property (nonatomic, weak) UIActivityIndicatorView *artistsAI;
@property (nonatomic, weak) UIActivityIndicatorView *scheduleAI;

+ (UINavigationController *)navWithSuccess:(viewDidLoadBlock)viewDidLoadBlock;

- (void)openFunction:(NSInteger)functionNumber sender:(id)sender;

@end
