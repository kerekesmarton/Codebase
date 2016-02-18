//
//  NewsDataManager.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "DataManager.h"

@interface NewsDataManager : DataManager <BaseDataManager>

+ (NewsDataManager *)sharedInstance;

- (void)setupRefreshRate;

@end
