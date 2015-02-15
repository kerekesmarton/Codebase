//
//  UIViewController+Shareing.h
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/24/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Shareing) <UIActionSheetDelegate, UIAlertViewDelegate, UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, retain)   NSString    *activity;
@property (nonatomic, retain)   UIImage     *postImage;
@property (nonatomic, retain)   NSString    *postText;
@property (nonatomic, retain)   NSString    *postURL;

@property (nonatomic, assign)   BOOL        useMedia;
- (void) share:(id)sender;
- (BOOL) shareActionSheet:(UIActionSheet *)actionSheet acionForIndex:(NSInteger)buttonIndex;

@end
