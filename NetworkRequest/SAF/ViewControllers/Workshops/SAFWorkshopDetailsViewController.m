//
//  SAFWorkshopDetailsViewController.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/22/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFWorkshopDetailsViewController.h"
#import "ArtistObject.h"
#import "ArtistImageDataManager.h"
#import "SAFDefines.h"
#import "SAFArtistDetailsViewController.h"
#import "UIViewController+Shareing.h"
#import "WSFeedbackViewController.h"


#define kAdd        @"Add to my Agenda"
#define kRemove     @"Remove from my Agenda"

#define margin              15
#define imgWidth(margin)    (self.view.frameWidth - 2*margin)


@interface SAFWorkshopDetailsViewController () <UIScrollViewDelegate,UITextViewDelegate,UIActionSheetDelegate>

@end

@implementation SAFWorkshopDetailsViewController {
    UIImageView     *_imageView;
    UIView          *_border;
    UIButton        *_info;
    UIButton        *_artist;
    UIScrollView    *_content;
    
    ArtistObject    *artist;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)loadView {
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.view = scroll;
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UIToolbar *toolbar = self.navigationController.toolbar;
    if ([toolbar respondsToSelector:@selector(barTintColor)]) {
        toolbar.barTintColor = [UIColor blackColor];
        toolbar.tintColor = [UIColor whiteColor];
        toolbar.translucent = NO;
    }
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Feedback" style:UIBarButtonItemStyleBordered target:self action:@selector(pushFeedback)];
    
    NSString *btnTitle = nil;
    int tag = 0;
    if (![self.item.favorited boolValue]) {
        btnTitle = kAdd;
        tag = 1;
    } else {
        btnTitle = kRemove;
        tag = 0;
    }
    
    UIBarButtonItem *favorite = [[UIBarButtonItem alloc] initWithTitle:btnTitle style:UIBarButtonItemStyleBordered target:self action:@selector(addToFavorites:)];
    favorite.tag = tag;
    
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithTitle:@"Share" style:UIBarButtonItemStyleBordered target:self action:@selector(share:)];
    
    self.toolbarItems = @[favorite,space,share];
    [self.navigationController setToolbarHidden:NO animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController setToolbarHidden:YES animated:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
    
    artist = [ArtistObject artistForId:self.item.instructor];
    if (artist.solo!= NULL) {
        artist = [ArtistObject artistForSolo:artist.solo];
    }
    
    [[ArtistImageDataManager sharedInstance] imageForString:artist.img completionBlock:^(NSData *imgData) {
        
        UIImage *img = [UIImage imageWithData:imgData];
        float widthRatio = img.size.width / imgWidth(margin);
        float requiredHeight = img.size.height / widthRatio;
        img = [img scaleToSize:CGSizeMake(imgWidth(margin), requiredHeight)];
        CGSize imgsize = img.size;
        CGRect imgFrame = CGRectMake((self.view.frame.size.width-imgsize.width)/2, 10, imgsize.width, imgsize.height);
        _border = [[UIView alloc] initWithFrame:CGRectInset(imgFrame, -5, -5)];
        [self.view addSubview:_border];
        _border.backgroundColor = [UIColor whiteColor];
        _border.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        _imageView = [[UIImageView alloc] initWithFrame:imgFrame];
        [self.view addSubview:_imageView];
        _imageView.image = img;
        _imageView.frame = imgFrame;
        
        [self createUI];
        
    } failureBlock:^(NSError *error) {
        
        _border = [[UIView alloc] initWithFrame:CGRectMake(10, 10, self.view.frameWidth, 0)];
        [self.view addSubview:_border];
        _border.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [self createUI];
    }];
    
}

- (void)createUI {
    
    UILabel *instructor = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(_border.frame), self.view.frame.size.width, 50)];
    instructor.text = artist.name;
    instructor.backgroundColor = [UIColor clearColor];
    instructor.textColor = [UIColor whiteColor];
    instructor.font = [UIFont fontWithName:futuraCondendsedBold size:20];
    instructor.numberOfLines = 2;
    instructor.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:instructor];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH.mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Bucharest"]];
    
    NSDate *wsTime = self.item.time;
    
    //time
    UILabel *dateLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(instructor.frame), self.view.frame.size.width-10, 20)];
    dateLbl.backgroundColor = [UIColor clearColor];
    dateLbl.font = [UIFont fontWithName:myriadFontR size:20];
    dateLbl.textColor = [UIColor whiteColor];
    dateLbl.text = [NSString stringWithFormat:@"%@ - %@", [formatter stringFromDate:wsTime],[formatter stringFromDate:[NSDate dateWithTimeInterval:3000 sinceDate:wsTime]]];
    [self.view addSubview:dateLbl];
    dateLbl.textAlignment = NSTextAlignmentCenter;
    
    //type
    UILabel *titleLbl = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(dateLbl.frame), self.view.frame.size.width-10, 20)];
    titleLbl.backgroundColor = [UIColor clearColor];
    titleLbl.font = [UIFont fontWithName:myriadFontB size:20];
    titleLbl.numberOfLines = 2;
    titleLbl.textColor = [UIColor lightGrayColor];
    titleLbl.text = self.item.name;
    titleLbl.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:titleLbl];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, CGRectGetMaxY(titleLbl.frame));
    [gradientLayer setMasksToBounds:YES];
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x2d2d2d] CGColor],(id)[[UIColor colorWithHex:0x232323] CGColor], nil]];
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    //buttons
    _info = [UIButton buttonWithType:UIButtonTypeCustom];
    [_info setTitle:@"Workshop details" forState:UIControlStateNormal];
    _info.frame = CGRectMake(0, CGRectGetMaxY(titleLbl.frame), self.view.frame.size.width/2, 30);
    _info.tag = 0;
    [_info.titleLabel setFont:[UIFont fontWithName:futuraCondendsedBold size:18]];
    [_info addTarget:self action:@selector(pushContent:) forControlEvents:UIControlEventTouchUpInside];
    _info.backgroundColor = [UIColor redColor];
    [_info setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_info setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:_info];
    
    _artist = [UIButton buttonWithType:UIButtonTypeCustom    ];
    [_artist setTitle:@"Artist details" forState:UIControlStateNormal];
    _artist.frame = CGRectMake(self.view.frame.size.width/2, CGRectGetMaxY(titleLbl.frame), self.view.frame.size.width/2, 30);
    _artist.tag = 1;
    [_artist.titleLabel setFont:[UIFont fontWithName:futuraCondendsedBold size:18]];
    [_artist addTarget:self action:@selector(pushContent:) forControlEvents:UIControlEventTouchUpInside];
    _artist.backgroundColor = [UIColor blackColor];
    [_artist setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    [_artist setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.view addSubview:_artist];
    
    //scroll
    _content = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, CGRectGetMaxY(_artist.frame), self.view.frame.size.width, self.view.frame.size.height-60)];
    _content.contentSize = CGSizeMake(2*self.view.frame.size.width, self.view.frame.size.height-60);
    _content.pagingEnabled = YES;
    _content.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
    [_content setDelegate:self];
    [self.view addSubview:_content];
    
    //diff
    
    UILabel *diff = [[UILabel alloc] initWithFrame:CGRectMake(5, 10, self.view.frame.size.width-5, 40)];
    switch ([self.item.difficulty integerValue]) {
        case 1:
            diff.text = @"This is an INTERMEDIATE - ADVANCED workshop";
            break;
        case 2:
            diff.text = @"This is a INTERMEDIATE workshop";
            break;
        case 3:
            diff.text = @"This is an ADVANCED workshop";
            break;
        case 4:
            diff.text = @"This is workshop is designated for dancers of ALL LEVELS";
            break;
            
        default:
            break;
    }
    diff.numberOfLines = 2;
    diff.backgroundColor = [UIColor clearColor];
    diff.font = [UIFont fontWithName:myriadFontI size:16];
    diff.textColor = [UIColor whiteColor];
    [_content addSubview:diff];
    
    NSString *textWS = [NSString stringWithFormat:@"%@",self.item.details == NULL? @"No description available":[NSString stringWithFormat:@"%@\n",self.item.details]];
    UIFont *wsFont = [UIFont fontWithName:myriadFontI size:17];
    CGRect wsRect = [textWS boundingRectWithSize:CGSizeMake(self.view.frame.size.width-10, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:wsFont} context:nil];

    UITextView *wsDetails = [[UITextView alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(diff.frame), self.view.frame.size.width-10, wsRect.size.height * 2)];
    wsDetails.backgroundColor = [UIColor clearColor];
    wsDetails.font = wsFont;
    wsDetails.textColor = [UIColor whiteColor];
    wsDetails.text = textWS;
    wsDetails.userInteractionEnabled = NO;
    wsDetails.textAlignment = NSTextAlignmentJustified;
    
    [_content addSubview:wsDetails];

    //artist details
    NSString *text = [NSString stringWithFormat:@"%@\n\n\t..read more",artist.desc1];
    UIFont *font = [UIFont fontWithName:myriadFontI size:16];

    CGRect rect = [text boundingRectWithSize:CGSizeMake(self.view.frame.size.width-10, 999) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];

    UITextView *artistDetails = [[UITextView alloc] init];
    artistDetails.delegate = self;
    artistDetails.frame = CGRectMake(self.view.frame.size.width+5, 10, self.view.frame.size.width-10,rect.size.height * 2);
    artistDetails.backgroundColor = [UIColor clearColor];
    [artistDetails setFont:font];
    [artistDetails setTextColor:[UIColor whiteColor]];
    [artistDetails setText:text];
    [_content addSubview:artistDetails];
    _content.bounces = NO;
    
    [(UIScrollView*)self.view setContentSize:CGSizeMake(self.view.frame.size.width, CGRectGetMinY(_content.frame)+MAX(CGRectGetMaxY(diff.frame) + MAX(wsRect.size.height, rect.size.height) * 2, 10+rect.size.height))];
    
    [self preConfigureSharing];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)preConfigureSharing {
    self.useMedia = kPhotoDefaultNone | kPhotoTakePicture | kPhotoTakeMovie | kPhotoChoose | kPhotoProvidedPicture;
    [[ArtistImageDataManager sharedInstance] imageForString:artist.img completionBlock:^(NSData *imgData) {
        self.postImage = [UIImage imageWithData:imgData];
    } failureBlock:^(NSError *error) {
        self.postImage = nil;
    }];
    self.postText = [NSString stringWithFormat:@"%@ is teaching %@! Check it out at:",artist.name, self.item.name];
}

#pragma mark - Various Delegates

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    
    [self pushArtist:nil];
    
    return NO;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    scrolling = false;
    //set highlighted button
    
    if (!scrolling) {
        //set buttons
        CGPoint pagePoint = scrollView.contentOffset;
        if (pagePoint.x < self.view.frame.size.width) {
            _info.backgroundColor = [UIColor redColor];
            [_info.titleLabel setTextColor:[UIColor blackColor]];
            _artist.backgroundColor = [UIColor blackColor];
            [_artist.titleLabel setTextColor:[UIColor whiteColor]];
        } else {
            _info.backgroundColor = [UIColor blackColor];
            [_info.titleLabel setTextColor:[UIColor whiteColor]];
            _artist.backgroundColor = [UIColor redColor];
            [_artist.titleLabel setTextColor:[UIColor blackColor]];
        }
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    scrolling = true;
    //user scrolls directly on scrollview
}

#pragma mark - private methods

-(void)addToFavorites:(id)sender {
    
    if ([(UIBarButtonItem*)sender tag] == 0) {
        self.item.favorited = [NSNumber numberWithBool:NO];
        [(UIBarButtonItem*)sender setTitle:kAdd];
        [(UIBarButtonItem*)sender setTag:1];
    } else {
        self.item.favorited = [NSNumber numberWithBool:YES];
        [(UIBarButtonItem*)sender setTitle:kRemove];
        [(UIBarButtonItem*)sender setTag:0];
    }
    
    [[VICoreDataManager getInstance] saveMainContext];
}

static bool scrolling = false;
-(void)pushFeedback {
    
    WSFeedbackViewController *fb = [[WSFeedbackViewController alloc] initWithUID:self.item.uID];
    [self.navigationController pushViewController:fb animated:YES];
    
}

-(void)pushContent:(id)sender {
    
    CGPoint pagePoint = CGPointMake(self.view.frame.size.width*[(UIButton*)sender tag], 0);
    [_content setContentOffset:pagePoint animated:YES];
    
    if (sender == _info) {
        _artist.backgroundColor = [UIColor blackColor];
        [_artist.titleLabel setTextColor:[UIColor whiteColor]];
    }else {
        _info.backgroundColor = [UIColor blackColor];
        [_info.titleLabel setTextColor:[UIColor whiteColor]];
    }
    [(UIButton*)sender setBackgroundColor:[UIColor redColor]];
    [[(UIButton*)sender titleLabel] setTextColor:[UIColor blackColor]];
    
    scrolling = true;
}

-(void)pushArtist:(id)sender {
    
    SAFArtistDetailsViewController *detailViewController = [[SAFArtistDetailsViewController alloc] initWithNibName:NSStringFromClass([ArtistDetailViewController class]) bundle:nil];
    detailViewController.artist = artist;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self shareActionSheet:actionSheet acionForIndex:buttonIndex];
}

-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [self preConfigureSharing];
}

@end
