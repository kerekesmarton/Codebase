//
//  UIDevice+Additions.m
//  ForeverMapNGX
//
//  Created by Mihai Babici on 11/28/12.
//  Copyright (c) 2012 Skobbler. All rights reserved.
//

#import "UIDevice+Additions.h"
#import <CommonCrypto/CommonDigest.h>

#import <sys/types.h>
#import <sys/sysctl.h>
#include <sys/socket.h> // Per msqr
#include <net/if.h>
#include <net/if_dl.h>


@implementation UIDevice (Additions)

static NSString *deviceModel = nil;

+ (BOOL)isiPad {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

+ (BOOL)isRetinaiPad {
    return [[UIScreen mainScreen] scale] == 2.0 && [UIDevice isiPad];
}

+ (BOOL)isWidescreeniPhone {
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    return ![UIDevice isiPad] && (screenSize.width >= 568.0 || screenSize.height >= 568.0);
}

+ (NSString *)deviceModel {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        size_t size;
        sysctlbyname("hw.machine", NULL, &size, NULL, 0);
        char *answer = (char *)malloc(size);
        sysctlbyname("hw.machine", answer, &size, NULL, 0);
        NSString *result = [NSString stringWithCString:answer encoding: NSUTF8StringEncoding];
        free(answer);
        
        NSDictionary *dictionary = @{
        @"iPhone1,1" : @"iPhone2G",
        @"iPhone1,2" : @"iPhone3G",
        @"iPhone2,1" : @"iPhone3GS",
        @"iPhone3,1" : @"iPhone4G",
        @"iPhone3,3" : @"iPhone4G",
        @"iPhone4,1" : @"iPhone4S",
        @"iPhone5,1" : @"iPhone5G",
        @"iPhone5,2" : @"iPhone5G",
        @"iPad1,1" : @"iPad",
        @"iPad2,1" : @"iPad2",
        @"iPad2,2" : @"iPad2",
        @"iPad2,3" : @"iPad2",
        @"iPad2,4" : @"iPad2",
        @"iPad2,5" : @"iPadMini",
        @"iPad2,6" : @"iPadMini",
        @"iPad2,7" : @"iPadMini",
        @"iPad3,1" : @"iPad3",
        @"iPad3,2" : @"iPad3",
        @"iPad3,3" : @"iPad3",
        @"iPad3,4" : @"iPad4",
        @"iPad3,5" : @"iPad4",
        @"iPad3,6" : @"iPad4",
        @"iPod1,1" : @"iPod1G",
        @"iPod2,1" : @"iPod2G",
        @"iPod3,1" : @"iPod3G",
        @"iPod4,1" : @"iPod4G",
        @"iPod5,1" : @"iPod5G",
        @"86" : @"iPhoneSimulator",
        @"x86_64" : @"iPhoneSimulator"
        };
        
        deviceModel = [dictionary objectForKey:result];
        if (!deviceModel) {
            deviceModel = @"unknown";
        }
    });
    
    return deviceModel;
}


- (NSString *) macaddress{
    
    int                 mib[6];
    size_t              len;
    char                *buf;
    unsigned char       *ptr;
    struct if_msghdr    *ifm;
    struct sockaddr_dl  *sdl;
    
    mib[0] = CTL_NET;
    mib[1] = AF_ROUTE;
    mib[2] = 0;
    mib[3] = AF_LINK;
    mib[4] = NET_RT_IFLIST;
    
    if ((mib[5] = if_nametoindex("en0")) == 0) {
        printf("Error: if_nametoindex error\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, NULL, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 1\n");
        return NULL;
    }
    
    if ((buf = malloc(len)) == NULL) {
        printf("Could not allocate memory. error!\n");
        return NULL;
    }
    
    if (sysctl(mib, 6, buf, &len, NULL, 0) < 0) {
        printf("Error: sysctl, take 2");
        free(buf);
        return NULL;
    }
    
    ifm = (struct if_msghdr *)buf;
    sdl = (struct sockaddr_dl *)(ifm + 1);
    ptr = (unsigned char *)LLADDR(sdl);
    NSString *outstring = [NSString stringWithFormat:@"%02X:%02X:%02X:%02X:%02X:%02X",
                           *ptr, *(ptr+1), *(ptr+2), *(ptr+3), *(ptr+4), *(ptr+5)];
    free(buf);
    
    return outstring;
}

-(NSString*)uniqueDeviceID
{
    NSString *macaddress = [[UIDevice currentDevice] macaddress];
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    
    NSString *composedString = [NSString stringWithFormat:@"%@%@",macaddress,bundleIdentifier];
    
    const char *cStr = [composedString UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    NSMutableString *md5String = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [md5String appendFormat:@"%02x",result[count]];
    }
    
    NSString *response = md5String;
    
    return response;
}

@end
