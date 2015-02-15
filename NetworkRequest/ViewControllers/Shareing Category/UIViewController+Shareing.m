//
//  UIViewController+Shareing.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/24/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "UIViewController+Shareing.h"
#import <Social/Social.h>
#import <MobileCoreServices/MobileCoreServices.h>

NSString    *_activity;
NSString    *_postText;
UIImage     *_postImage;
NSString    *_postURL;

int shareActionSHeetTagShare = 0;
int shareActionSHeetTagPicture = 1;

typedef enum kShareTypes {
    
    kShareFacebook = 0,
    kShareTwitter = 1,
} ShareType;

typedef enum kPhotoTypes {
    
    kPhotoTakePic = 0,
    kPhotoTakeMovie = 1,
    kPhotoChoose = 2,
    kPhotoDefault = 3,
} PhotoType;

@implementation UIViewController (Shareing)

-(UIPopoverController *)popoverWithContent:(UIViewController *)contentViewController {
    static UIPopoverController *controller;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        controller = [[UIPopoverController alloc] initWithContentViewController:contentViewController];
    });
    
    if (controller) {
        [controller setContentViewController:contentViewController];
    }
    return controller;
}

bool _useMedia = true;

-(BOOL)useMedia {
    return _useMedia;
}

-(void)setUseMedia:(BOOL)useMedia {
 
    _useMedia = useMedia;
}


-(NSString *)postText {

    return _postText;
}

-(void)setPostText:(NSString *)postText {
    _postText = postText;
}

-(UIImage *)postImage {
    
    return _postImage;
}

-(void)setPostImage:(UIImage *)postImage {
    _postImage = postImage;
}

-(NSString *)postURL {
    
    return @"https://itunes.apple.com/ro/app/salsa-addicted-festival/id596044669?mt=8&uo=4";
}

-(void)setPostURL:(NSString *)postURL {
    
//    _postURL = [NSString stringWithString:postURL];
}

-(NSString *)activity {
 
    return _activity;
}

-(void)setActivity:(NSString *)activity {
    
    _activity = activity;
}

-(void)share:(id)sender {
    
    
    UIActionSheet *shareMethods = [[UIActionSheet alloc] initWithTitle:@"Tell your friends about this app:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Facebook",@"Twitter", nil];
    shareMethods.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    shareMethods.tag = shareActionSHeetTagShare;
    if ([sender isKindOfClass:[UIBarButtonItem class]]) {
        [shareMethods showFromBarButtonItem:sender animated:YES];
    } else if ([sender isKindOfClass:[UITabBarItem class]]) {
        [shareMethods showFromTabBar:sender];
    } else
        [shareMethods showInView:self.view];
}

-(void)choosePicture:(id)sender {
    
    UIActionSheet *pictureMethods = [[UIActionSheet alloc] initWithTitle:@"Do you want to take a photo?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo",@"Capture Movie",@"Choose from existing",@"Use Artist Picture", nil];
    pictureMethods.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    pictureMethods.tag = shareActionSHeetTagPicture;
    
    if (self.navigationController.toolbarHidden == NO) {
        [pictureMethods showFromToolbar:self.navigationController.toolbar];
    } else if (self.tabBarController) {
        [pictureMethods showFromTabBar:self.tabBarController.tabBar];
    } else
        [pictureMethods showInView:self.view];
    
}

- (BOOL)shareActionSheet:(UIActionSheet *)actionSheet acionForIndex:(NSInteger)buttonIndex {
    if (actionSheet.tag == shareActionSHeetTagShare) {
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return NO;
        }
        if (!iOS6) {
            [[[UIAlertView alloc ] initWithTitle:@"We are sorry!" message:@"Sharing only supported on iOS 6 and above" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
            return NO;
        }
        switch (buttonIndex) {
            case  kShareFacebook:
                self.activity = SLServiceTypeFacebook;
                break;
            case  kShareTwitter:
                self.activity = SLServiceTypeTwitter;
                break;
            default:
                self.activity = nil;
                break;
        }
        
        if (self.activity) {
            if (self.useMedia) {
                [self choosePicture:nil];
            } else {
                [self selectImage:kPhotoDefault];
            }
        }
        return YES;
    } else
    if (actionSheet.tag == shareActionSHeetTagPicture) {
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return NO;
        }
        switch (buttonIndex) {
            case  kPhotoTakePic:
                [self selectImage:kPhotoTakePic];
                break;
            case kPhotoTakeMovie:
                if ([self.activity isEqualToString: SLServiceTypeTwitter]) {
                    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Using picture" message:@"movie posting not avaible for twitter" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    [av show];
                    [self selectImage:kPhotoTakePic];
                } else {
                    [self selectImage:kPhotoTakeMovie];
                }
                break;
            case  kPhotoChoose:
                [self selectImage:kPhotoChoose];
                break;
            case kPhotoDefault:
                [self selectImage:kPhotoDefault];
                break;
            default:
                break;
        }
        return YES;
    } else
        return NO;
}

- (IBAction)selectImage:(PhotoType)type {
    
    if (type == kPhotoDefault) {
//        self.postImage = ???
        
        if ([self.activity isEqualToString:SLServiceTypeFacebook]) {
            [self shareOnFacebook];
        }
        if ([self.activity isEqualToString:SLServiceTypeTwitter]) {
            [self shareOnTwitter];
        }
        return;
    }
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.editing = YES;
    imagePicker.allowsEditing = NO;
    
    
    if (type == kPhotoTakePic && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeImage, nil];
    }
    
    if (type == kPhotoTakeMovie && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        imagePicker.mediaTypes = [NSArray arrayWithObjects: (NSString *) kUTTypeMovie, nil];
    }
    
    if (type == kPhotoChoose && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if ([UIDevice isiPad]) {
        [[self popoverWithContent:imagePicker] presentPopoverFromRect:CGRectInset(self.view.frame, 100, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    } else {
        [self.navigationController presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        self.postImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    
    if ([UIDevice isiPad]) {
        if ([self.activity isEqualToString:SLServiceTypeFacebook]) {
            [self shareOnFacebook];
        }
        if ([self.activity isEqualToString:SLServiceTypeTwitter]) {
            [self shareOnTwitter];
        }
        [[self popoverWithContent:picker] dismissPopoverAnimated:YES];
    } else {
        [picker.presentingViewController dismissViewControllerAnimated:YES completion:^(){
            if ([self.activity isEqualToString:SLServiceTypeFacebook]) {
                [self shareOnFacebook];
            }
            if ([self.activity isEqualToString:SLServiceTypeTwitter]) {
                [self shareOnTwitter];
            }
        }];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    if ([UIDevice isiPad]) {
        [[self popoverWithContent:picker] dismissPopoverAnimated:YES];
    } else {
        [picker.presentingViewController dismissViewControllerAnimated:YES completion:^{
            //
        }];
    }
}

-(void)shareOnFacebook {
    if (!iOS6) {
        
        return;
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [composeController setInitialText:self.postText];
        [composeController addImage:self.postImage];
        [composeController addURL: [NSURL URLWithString:self.postURL]];
        [composeController setCompletionHandler:^(SLComposeViewControllerResult result){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result == SLComposeViewControllerResultDone) {
                    NSLog(@"share on FB done");
                } else {
                    NSLog(@"share on FB cancelled");
                }
            });
        }];
        [self.navigationController presentViewController:composeController animated:YES completion:^(){}];
    }
}

-(void)shareOnTwitter {
    if (!iOS6) {
        
        return;
    }
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [composeController setInitialText:self.postText];
        [composeController addImage:self.postImage];
        [composeController addURL: [NSURL URLWithString:self.postURL]];
        [composeController setCompletionHandler:^(SLComposeViewControllerResult result){
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result == SLComposeViewControllerResultDone) {
                    NSLog(@"share on TW done");
                } else {
                    NSLog(@"share on TW cancelled");
                }
            });
        }];
        [self.navigationController presentViewController:composeController animated:YES completion:^(){}];
    }
}

@end
