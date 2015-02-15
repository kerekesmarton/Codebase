//
//  ArtistImageDataSource.h
//  SAFapp
//
//  Created by Kerekes Marton on 2/20/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DownloadManager.h"

typedef void (^ DownloadBlock)(NSData*);

@interface ArtistImageDataManager : NSObject

+ (ArtistImageDataManager *)sharedInstance;

-(void)setObject:(id)object forKey:(NSString *)key;
-(NSData*)objectForKey:(NSString*)key;
-(void)save;

-(void)imageForString:(NSString*)string completionBlock:(DownloadBlock)successBlock failureBlock:(ErrorBlock)failureBlock;

@end
