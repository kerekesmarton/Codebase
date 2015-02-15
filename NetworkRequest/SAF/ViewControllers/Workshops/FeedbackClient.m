//
//  FeedbackClient.m
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 1/28/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "FeedbackClient.h"
#import "AFNetworking.h"
#import "WorkshopObject.h"
#import "ArtistObject.h"

@interface FeedbackClient ()

@property (atomic, assign) BOOL sending;
@property (atomic, strong) NSMutableArray *parsedItems;
@property (atomic, strong) NSOperationQueue *requestQueue;
@end


@implementation FeedbackClient

static NSString * const kRequestURL = @"http://saf8.airedancecompany.ro/";

+ (FeedbackClient *)sharedClient {
    static FeedbackClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FeedbackClient alloc] initWithBaseURL:[NSURL URLWithString:kRequestURL]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.sending = NO;
    
    self.parsedItems = [[NSMutableArray alloc] init];
    self.requestQueue = [[NSOperationQueue alloc] init];
   
    return self;
}

- (void)dealloc
{
    [_requestQueue cancelAllOperations];
}

-(void)sendAllFeedback {
    
    
    if (self.sending) {
        return;
    }
    self.sending = true;
    
    __block NSString *deviceID = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        
        
        NSURL *url = [NSURL URLWithString:kRequestURL];
        AFHTTPClient *helper = [[AFHTTPClient alloc] initWithBaseURL:url];
        
        NSManagedObjectContext *tmp = [[VICoreDataManager getInstance] startTransaction];
        
        NSArray *allItems = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([WorkshopObject class]) forContext:tmp];
        
        [self.parsedItems removeAllObjects];
        
        for (WorkshopObject *item in allItems) {
            if (item.feedbackSent!=nil && !item.feedbackSent.boolValue) {
                [self.parsedItems addObject:item];
            }
        }
        
        NSString *email = [[NSUserDefaults standardUserDefaults] valueForKey:@"feedbackEmail"];
        if ([email length] == 0) {
            return;
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
        [dateFormatter setDateFormat:@"s"];
        
        for (WorkshopObject *item in self.parsedItems) {
            
            NSDate *date = [NSDate date];
            int interval = [date timeIntervalSince1970];
            NSString *stamp = [NSString stringWithFormat:@"%d",interval];
            NSString *feedback = [item.feedbackComment length]?item.feedbackComment:@" ";
            NSDictionary *params = [NSDictionary dictionaryWithObjects:
                                    //objects
                                    @[item.uID,item.name,item.instructor,stamp,item.feedbackRating,item.feedbackUseful, feedback,deviceID,email]
                                    //keys
                                                               forKeys:
                                    @[@"workshopID", @"workshopName", @"instructor", @"date", @"rank", @"expectation", @"comments", @"macAddress", @"emailAddress"]];
            
            helper.parameterEncoding = AFJSONParameterEncoding;
            NSMutableURLRequest *urlRequest = [helper requestWithMethod:@"POST" path:@"api/saf/feedbackitem/" parameters:params];
            
            AFHTTPRequestOperation *sendRequest = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
            [sendRequest setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
                [self requestSuccessful:operation responseObject:responseObject];
            } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                [self requestFailed:operation error:error];
            }];
            
            [_requestQueue addOperation:sendRequest];
        }
        
        [[VICoreDataManager getInstance] endTransactionForContext:tmp];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotifSending object:nil]];
        });
    });

    
}

-(void)requestSuccessful:(AFHTTPRequestOperation*)operation responseObject:(id)responseObject {
    
    NSManagedObjectContext *tmp = [[VICoreDataManager getInstance] startTransaction];
    NSArray *allItems = [[VICoreDataManager getInstance] arrayForModel:NSStringFromClass([WorkshopObject class]) forContext:tmp];
    
    for (WorkshopObject *item in allItems) {
        if (item.feedbackSent!=nil && !item.feedbackSent.boolValue) {
            item.feedbackSent = @YES;
        }
    }
    [[VICoreDataManager getInstance] endTransactionForContext:tmp];
    self.sending = false;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotifSentOK object:nil]];
    });
}

- (void)requestFailed:(AFHTTPRequestOperation *)operation error:(NSError*)error {
    
    self.sending = false;
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:kNotifSentErr object:nil]];
    });
}

@end


