//
//  WorkshopsDataManager.h
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/27/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "BaseDataManager.h"

@interface WorkshopsDataManager : NSObject <BaseDataManager>

+(WorkshopsDataManager *)sharedInstance;

-(NSArray *)fetchDataForDay:(NSDate *)day;

@end
