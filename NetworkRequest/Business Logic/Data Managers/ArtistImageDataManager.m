//
//  ArtistImageDataSource.m
//  SAFapp
//
//  Created by Kerekes Marton on 2/20/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ArtistImageDataManager.h"
#import "DownloadManager.h"
#import "VICoreDataManager.h"

@implementation ArtistImageDataManager {
    
    NSMutableDictionary *imageDataDictionary;
}

+ (ArtistImageDataManager *)sharedInstance {
    static ArtistImageDataManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ArtistImageDataManager alloc] init];
    });
    
    return _sharedClient;
}

-(id)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    NSURL *documentsURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"images"];
    NSString *filename = [documentsURL relativePath];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:filename]) {
        [[NSFileManager defaultManager] createFileAtPath:filename contents:nil attributes:nil];
    }
    
    imageDataDictionary = [[NSMutableDictionary alloc] initWithDictionary:[NSKeyedUnarchiver unarchiveObjectWithFile:filename]];
    
    return self;
}

-(void)save{
    
    NSURL *documentsURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"images"];
    NSString *filename = [documentsURL relativePath];
    
    [NSKeyedArchiver archiveRootObject:imageDataDictionary toFile:filename];
}

-(void)setObject:(id)object forKey:(NSString *)key{
    
    [imageDataDictionary setObject:object forKey:key];
}
-(NSData*)objectForKey:(NSString*)key {
    
    return [imageDataDictionary objectForKey:key];
}

-(void)imageForString:(NSString*)string completionBlock:(DownloadBlock)successBlock failureBlock:(ErrorBlock)failureBlock {
    
    NSString *name = [[string lastPathComponent] stringByDeletingPathExtension];
    NSString *file = [[NSBundle mainBundle] pathForResource:name ofType:@"jpg"];
    NSData *imgData = [NSData dataWithContentsOfFile:file];
    if (!imgData) {
        imgData = [self objectForKey:[NSString stringWithFormat:@"%@",string]];
    }
    
    if (imgData) {
        
        successBlock(imgData);
    } else {
        
        [[DownloadManager sharedInstance] requestFileForPath:[NSString stringWithFormat:@"%@",string] withSuccessBlock:^(id responseObject) {
            
            if (responseObject) {
                [[ArtistImageDataManager sharedInstance] setObject:responseObject forKey:[NSString stringWithFormat:@"%@",string]];
                [[ArtistImageDataManager sharedInstance] save];
                if (successBlock) {
                    successBlock(responseObject);
                }
                
            } else {
                
                if (successBlock) {
                    successBlock(nil);
                }
            }
            
        } FailureBlock:^(NSError *error) {
            
            NSLog(@"%@",error.userInfo.description);
            
            if (failureBlock) {
                failureBlock(error);
            }
            
        }];
    }
}

@end
