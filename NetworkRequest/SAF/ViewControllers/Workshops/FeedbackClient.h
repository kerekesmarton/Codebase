//
//  FeedbackClient.h
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 1/28/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "AFHTTPClient.h"

#define kNotifSending       @"WSfeedbackSending"
#define kNotifSentOK        @"WSfeedbackSentOK"
#define kNotifSentErr       @"WSFeedbackSentErr"

@interface FeedbackClient : NSObject

+(FeedbackClient *)sharedClient;

- (void)sendAllFeedback;
- (void)sendFeedbackForID:(id)identifier;

@end
