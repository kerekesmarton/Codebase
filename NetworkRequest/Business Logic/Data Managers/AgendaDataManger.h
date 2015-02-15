//
//  AgendaDataManger.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/1/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "BaseDataManager.h"

@interface AgendaDataManger : NSObject <BaseDataManager>

+(AgendaDataManger*)sharedInstance;

@end
