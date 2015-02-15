//
//  ArtistsDataManager.h
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/31/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "BaseDataManager.h"


@interface ArtistsDataManager : NSObject <BaseDataManager>

+(ArtistsDataManager *)sharedInstance;

@end
