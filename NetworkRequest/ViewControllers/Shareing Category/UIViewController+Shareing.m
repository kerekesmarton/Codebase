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


static NSString * const SHARE_BUTTON_TITLE_DEFAULT          = @"Just post it..";
static NSString * const SHARE_BUTTON_TITLE_TAKE_PICTURE     = @"Take a photo";
static NSString * const SHARE_BUTTON_TITLE_TAKE_MOVIE       = @"Capture a movie";
static NSString * const SHARE_BUTTON_TITLE_CHOOSE           = @"Choose from library";
static NSString * const SHARE_BUTTON_TITLE_USE_ARTIST_IMG   = @"Use provided artist picture";

NSString    *_activity;
NSString    *_postText;
UIImage     *_postImage;
NSString    *_postURL;

int shareActionSHeetTagShare = 0;
int shareActionSHeetTagPicture = 1;

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

PhotoType _useMedia = true;

-(PhotoType)useMedia {
    return _useMedia;
}

-(void)setUseMedia:(PhotoType)useMedia {
 
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

    NSMutableArray *titles = [NSMutableArray array];
    if (_useMedia & kPhotoDefaultNone)
    {
        [titles addObject:SHARE_BUTTON_TITLE_DEFAULT];
    }
    if (_useMedia & kPhotoTakePicture)
    {
        [titles addObject:SHARE_BUTTON_TITLE_TAKE_PICTURE];
    }
    if (_useMedia & kPhotoTakeMovie)
    {
        [titles addObject:SHARE_BUTTON_TITLE_TAKE_MOVIE];
    }
    if (_useMedia & kPhotoChoose)
    {
        [titles addObject:SHARE_BUTTON_TITLE_CHOOSE];
    }
    if (_useMedia & kPhotoProvidedPicture)
    {
        [titles addObject:SHARE_BUTTON_TITLE_USE_ARTIST_IMG];
    }

    UIActionSheet *pictureMethods = [[UIActionSheet alloc] initWithTitle:@"Do you want to take a photo?" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles: nil];
    for (NSString *title in titles) {
        [pictureMethods addButtonWithTitle:title];
    }
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
        switch (buttonIndex) {
            case  kShareFacebook:
                self.activity = SLServiceTypeFacebook;
                break;
            case  kShareTwitter:
                self.activity = SLServiceTypeTwitter;
                _useMedia =  _useMedia ^ kPhotoTakeMovie;
                break;
            default:
                self.activity = nil;
                break;
        }

        if (self.activity) {
            if (self.useMedia > kPhotoTakePicture) {
                [self choosePicture:nil];
            } else {
                [self selectImage:kPhotoProvidedPicture];
            }
        }
        return YES;
    } else
    if (actionSheet.tag == shareActionSHeetTagPicture) {
        if (buttonIndex == actionSheet.cancelButtonIndex) {
            return NO;
        }

        NSString * title = [actionSheet buttonTitleAtIndex:buttonIndex];

        if ([title isEqualToString:SHARE_BUTTON_TITLE_DEFAULT])
        {
            [self selectImage:kPhotoDefaultNone];
            self.postImage = nil;
        }
        else if ([title isEqualToString:SHARE_BUTTON_TITLE_TAKE_PICTURE])
        {
            [self selectImage:kPhotoTakePicture];
        }
        else if ([title isEqualToString:SHARE_BUTTON_TITLE_TAKE_MOVIE])
        {
            [self selectImage:kPhotoTakeMovie];
        }
        else if ([title isEqualToString:SHARE_BUTTON_TITLE_CHOOSE])
        {
            [self selectImage:kPhotoChoose];
        }
        else if ([title isEqualToString:SHARE_BUTTON_TITLE_USE_ARTIST_IMG])
        {
            [self selectImage:kPhotoProvidedPicture];
        }
        return YES;
    } else
        return NO;
}

- (IBAction)selectImage:(PhotoType)type {
    
    if (type == kPhotoProvidedPicture || type == kPhotoDefaultNone) {
        
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
    
    
    if (type == kPhotoTakePicture && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
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

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
    {
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [composeController setInitialText:self.postText];
        if (_postImage)
        {
            BOOL res = [composeController addImage:self.postImage];
            NSLog(@"image attached: %d",res);
        }
        else
        {
            [composeController addURL: [NSURL URLWithString:self.postURL]];
        }
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
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Facebook not installed" message:@"Please download from the app store and log in to the Facebook app or log in from Settings app/Facebook." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

-(void)shareOnTwitter {

    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        
        SLComposeViewController *composeController = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
        
        [composeController setInitialText:self.postText];
        [composeController addURL: [NSURL URLWithString:self.postURL]];
        if (_postImage)
        {
            [composeController addImage:self.postImage];
        }

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
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Twitter not installed" message:@"Please download from the app store and log in to the Twitter app or log in from Settings app/Twitter." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

@end
