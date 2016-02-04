//
//  SAFStartupManager.h
//  NetworkRequest
//
//  Created by Kerekes, Marton on 28/01/15.
//  Copyright (c) 2015 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAFStartupManager : NSObject

+ (instancetype)sharedInstance;

-(void)startNewsRequestWithButtons:(NSArray *)buttons activityIndicators:(NSArray *)activityIndicators;
-(void)startWorshopssRequestWithButtons:(NSArray *)buttons activityIndicators:(NSArray *)activityIndicators completion:(void (^)(void))completion;
-(void)startArtistsWithButtons:(NSArray *)buttons activityIndicators:(NSArray *)activityIndicators;
-(void)startAgendaRequestWithButtons:(NSArray *)buttons activityIndicators:(NSArray *)activityIndicators;

@end
