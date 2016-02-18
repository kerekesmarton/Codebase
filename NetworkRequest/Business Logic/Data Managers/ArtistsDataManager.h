//
//  ArtistsDataManager.h
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/31/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "DataManager.h"


@interface ArtistsDataManager : DataManager <BaseDataManager>

+(ArtistsDataManager *)sharedInstance;

@end
