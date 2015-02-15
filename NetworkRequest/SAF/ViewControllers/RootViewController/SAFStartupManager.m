//
//  SAFStartupManager.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 28/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFStartupManager.h"

#import "ArtistsDataManager.h"
#import "WorkshopsDataManager.h"
#import "NewsDataManager.h"
#import "AgendaDataManger.h"

#import "VICoreDataManager.h"

#import "SettingsManager.h"

@implementation SAFStartupManager

+ (instancetype)sharedInstance {
    
    static id startupManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        startupManager = [[SAFStartupManager alloc] init];
    });
    return startupManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        NSString *savedBundleVersion = @"savedVersion";
        
        
        id savedVersion = [[NSUserDefaults standardUserDefaults] objectForKey:savedBundleVersion];
        id bundleVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleVersionKey];
        if (!savedVersion ||
            [savedVersion compare:bundleVersion options:NSCaseInsensitiveSearch] == NSOrderedAscending) {
            
            [[SettingsManager sharedInstance].selectedDay reset];
            
            
            [[NSUserDefaults standardUserDefaults] setObject:bundleVersion forKey:savedBundleVersion];
            [[NSUserDefaults standardUserDefaults] synchronize];            
        }
    }
    return self;
}

-(void)startNewsRequestWithButtons:(NSArray *)buttons activityIndicators:(NSArray *)activityIndicators {

    [self enableButtons:buttons value:NO];
    [self toggleSpinners:activityIndicators value:YES];
    
    [[NewsDataManager sharedInstance] requestDataWitchSuccess:^(id data) {
        [self enableButtons:buttons value:YES];
        [self toggleSpinners:activityIndicators value:NO];
    } failBlock:^(id data) {
        [self toggleSpinners:activityIndicators value:NO];
    }];
}

-(void)startWorshopssRequestWithButtons:(NSArray *)buttons activityIndicators:(NSArray *)activityIndicators {
    
    [self enableButtons:buttons value:NO];
    [self toggleSpinners:activityIndicators value:YES];
    
    [[WorkshopsDataManager sharedInstance] requestDataWitchSuccess:^(id data) {
        [self enableButtons:buttons value:YES];
        [self toggleSpinners:activityIndicators value:NO];
    } failBlock:^(id data) {
        [self toggleSpinners:activityIndicators value:NO];
    }];
}

-(void)startArtistsWithButtons:(NSArray *)buttons activityIndicators:(NSArray *)activityIndicators {
    
    [self enableButtons:buttons value:NO];
    [self toggleSpinners:activityIndicators value:YES];
    
    [[ArtistsDataManager sharedInstance] requestDataWitchSuccess:^(id data) {
        [self enableButtons:buttons value:YES];
        [self toggleSpinners:activityIndicators value:NO];
    } failBlock:^(id data) {
        [self toggleSpinners:activityIndicators value:NO];
    }];
}

-(void)startAgendaRequestWithButtons:(NSArray *)buttons activityIndicators:(NSArray *)activityIndicators {
    
    [self enableButtons:buttons value:NO];
    [self toggleSpinners:activityIndicators value:YES];
    
    [[AgendaDataManger sharedInstance]  requestDataWitchSuccess:^(id data) {
        [self enableButtons:buttons value:YES];
        [self toggleSpinners:activityIndicators value:NO];
    } failBlock:^(id data) {
        [self toggleSpinners:activityIndicators value:NO];
    }];
}




-(void)enableButtons:(NSArray *)buttons value:(BOOL)value {
    for (UIButton *b in buttons) {
        [b setEnabled:value];
    }
}

- (void)toggleSpinners:(NSArray *)spinners value:(BOOL)value {
    for (UIActivityIndicatorView *ai in spinners) {
        
        if (value) {
//            show and start
            ai.hidden = NO;
            [ai startAnimating];
        } else {
            ai.hidden = YES;
            [ai stopAnimating];
        }
    }
}
@end
