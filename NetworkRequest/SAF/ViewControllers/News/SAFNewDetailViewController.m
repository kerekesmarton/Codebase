//
//  SAFNewDetailViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/20/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFNewDetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SAFDefines.h"
#import "UIViewController+Shareing.h"

@interface SAFNewDetailViewController () <UIActionSheetDelegate>

@end

@implementation SAFNewDetailViewController
@synthesize titleLbl,detailsLbl,gradient,detailsText,share;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
    CGSize size = [UIScreen mainScreen].bounds.size;
    self.gradient.frame = CGRectMake(0, 0, size.width, 110);
    self.gradient.autoresizingMask = UIViewAutoresizingNone;
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, size.width, self.gradient.frameHeight);
    [gradientLayer setMasksToBounds:YES];
    [self.gradient.layer addSublayer:gradientLayer];
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x2d2d2d] CGColor],(id)[[UIColor colorWithHex:0x232323] CGColor], nil]];
    
    [self.gradient bringSubviewToFront:titleLbl];
    [self.gradient bringSubviewToFront:detailsLbl];
    
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.font = [UIFont fontWithName:futuraCondendsedBold size:20];
    titleLbl.textColor = [UIColor redColor];
    titleLbl.numberOfLines = 0;
    titleLbl.text = self.item.title;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    
    detailsLbl.backgroundColor = [UIColor clearColor];
    detailsLbl.font = [UIFont fontWithName:myriadFontI size:15];
    detailsLbl.textColor = [UIColor lightGrayColor];
    detailsLbl.text = [dateFormatter stringFromDate:self.item.timeStamp];
    
//    detailsText.frameY = gradient.frameMaxX;
    
    detailsText.backgroundColor = [UIColor clearColor];
    detailsText.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    detailsText.text = [NSString stringWithFormat:@"\t%@",self.item.desc];
    detailsText.font = [UIFont fontWithName:myriadFontI size:20];
    detailsText.textColor = [UIColor whiteColor];
    detailsText.userInteractionEnabled = YES;
    detailsText.editable = NO;
    detailsText.textAlignment = NSTextAlignmentJustified;
    
    [self.detailsText addSubview:share];
    UIImage *img = [[UIImage imageNamed:@"buton albastru"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    [share setBackgroundImage:img forState:UIControlStateNormal];
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    [share setTitle:@"Share" forState:UIControlStateNormal];
    [share.titleLabel setFont:[UIFont fontWithName:futuraCondendsedBold size:20]];
    [share setBackgroundColor:[UIColor colorWithHex:0x3c3c3c]];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setEditing:YES animated:animated];
    
    //sharing config
    self.useMedia = kPhotoDefaultNone | kPhotoTakePicture | kPhotoTakeMovie | kPhotoChoose;
    self.postImage = nil;
    self.postText = [NSString stringWithFormat:@"%@\n%@",self.item.title,self.item.desc];
    [self layoutShareButton];
}

-(void)layoutShareButton {
//    CGSize currentSize = self.detailsText.contentSize;
//    self.detailsText.contentSize = CGSizeMake(currentSize.width, currentSize.height+10+share.frameHeight);
//    share.frame = CGRectMake((currentSize.width-share.frameWidth)/2, currentSize.height+5, share.frameWidth, share.frameHeight);
    
}

-(UIBarButtonItem *)editButtonItem {
    UIBarButtonItem *edit;
    if (self.editing) {
        edit = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(toggleEditing)];
    } else {
        edit = [[UIBarButtonItem alloc] initWithTitle:@"More" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditing)];
    }
    return edit;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self setEditing:NO animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated {
    
    [super setEditing:editing animated:animated];
    
    [self.navigationController setToolbarHidden:!editing animated:animated];
    
    UIBarButtonItem *unmark = [[UIBarButtonItem alloc] initWithTitle:@"Mark as unread" style:UIBarButtonItemStyleBordered target:self action:@selector(markUnread:)];
    UIBarButtonItem *flexi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStylePlain target:self action:@selector(share:)];
    UIBarButtonItem *flexi2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    UIBarButtonItem *delete = [[UIBarButtonItem alloc] initWithTitle:@"Delete" style:UIBarButtonItemStyleDone target:self action:@selector(delete:)];
    delete.tintColor = [UIColor redColor];
    self.toolbarItems = @[unmark,flexi,shareBtn,flexi2,delete];
    
    if (animated) {
        [self layoutShareButton];
    }
}

-(void)markUnread:(UIBarButtonItem*)sender {
 
    if ([self.item.read isEqual: @YES]) {
        self.item.read = @NO;
        [[VICoreDataManager getInstance] saveMainContext];
        sender.enabled = NO;
    }
}

-(void)delete:(UIBarButtonItem*)sender {
    self.item.del = @YES;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self shareActionSheet:actionSheet acionForIndex:buttonIndex];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    self.postImage = nil;
}

@end
