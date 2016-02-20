//
//  UIViewController+Shareing.h
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/24/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum kShareTypes {

    kShareFacebook = 0,
    kShareTwitter = 1,
} ShareType;

typedef enum kPhotoTypes {

    kPhotoDefaultNone = 1<<0,
    kPhotoTakePicture = 1<<1,
    kPhotoTakeMovie = 1<<2,
    kPhotoChoose = 1<<3,
    kPhotoProvidedPicture = 1<<4,

} PhotoType;


@interface UIViewController (Shareing) <UIActionSheetDelegate, UIAlertViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, retain)   NSString    *activity;
@property (nonatomic, retain)   UIImage     *postImage;
@property (nonatomic, retain)   NSString    *postText;
@property (nonatomic, retain)   NSString    *postURL;

@property (nonatomic, assign)   PhotoType   useMedia;
- (void) share:(id)sender;
- (BOOL) shareActionSheet:(UIActionSheet *)actionSheet acionForIndex:(NSInteger)buttonIndex;

@end
