//
//  SKMapPackageDownloadInfo.h
//  SKMaps
//
//  Copyright (c) 2014 Skobbler. All rights reserved.
//

#import <Foundation/Foundation.h>

/** Model class for offline package download URLs.
 */
@interface SKMapPackageDownloadInfo : NSObject

/** URL for the map file (.skm).
 */
@property(nonatomic, strong) NSString *mapURL;

/** URL for texture file (.txg).
 */
@property(nonatomic, strong) NSString *textureURL;

/** The URL for the namebrowser files (.zip).
 */
@property(nonatomic, strong) NSString *namebrowserFilesURL;

@end
