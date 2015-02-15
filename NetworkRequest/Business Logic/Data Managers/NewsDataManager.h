//
//  NewsDataManager.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "BaseDataManager.h"

@interface NewsDataManager : NSObject <BaseDataManager>

+(NewsDataManager *)sharedInstance;

-(void)setupRefreshRate;

@end
