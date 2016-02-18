//
//  AgendaDataManger.h
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/1/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "DataManager.h"

@interface AgendaDataManger : DataManager <BaseDataManager>

+(AgendaDataManger*)sharedInstance;

@end
