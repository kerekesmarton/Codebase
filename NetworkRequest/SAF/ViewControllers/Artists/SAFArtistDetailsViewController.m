//
//  SAFArtistDetailsViewController.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/22/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFArtistDetailsViewController.h"
#import "SAFDefines.h"
#import "ArtistImageDataManager.h"

#define margin              15
#define imgWidth(margin)    (self.view.frameWidth - 2*margin)


@interface SAFArtistDetailsViewController ()

@end

@implementation SAFArtistDetailsViewController

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
    
    
    
	// Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    scroll.backgroundColor = [UIColor colorWithHex:0x2d2d2d];
    [self.view addSubview:scroll];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width)/2, 10, self.view.frameWidth, 200)];
    image.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [[ArtistImageDataManager sharedInstance] imageForString:self.artist.img completionBlock:^(NSData *imgData) {
        
        UIImage *img = [UIImage imageWithData:imgData];
        float widthRatio = img.size.width / imgWidth(margin);
        float requiredHeight = img.size.height / widthRatio;
        img = [img scaleToSize:CGSizeMake(imgWidth(margin), requiredHeight)];
        CGSize imgsize = img.size;
        CGRect imgFrame = CGRectMake((self.view.frame.size.width-imgsize.width)/2, 10, imgsize.width, imgsize.height);
        UIView *border = [[UIView alloc] initWithFrame:CGRectInset(imgFrame, -5, -5)];
        border.backgroundColor = [UIColor whiteColor];
        border.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        image.image = img;
        image.frame = imgFrame;
        [scroll addSubview:border];
        
    } failureBlock:nil];
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(image.frame)+10, self.view.frame.size.width-20, 60)];
    name.backgroundColor = [UIColor clearColor];
    name.font = [UIFont fontWithName:@"edo" size:25];
    name.numberOfLines = 2;
    name.textColor = [UIColor orangeColor];
    name.text = self.artist.name;
    name.textAlignment = NSTextAlignmentCenter;
    name.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    UILabel *loc = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(name.frame)+10, self.view.frame.size.width-20, 40)];
    loc.backgroundColor = [UIColor whiteColor];
    loc.font = [UIFont fontWithName:myriadFontI size:20];
    loc.textColor = [UIColor lightGrayColor];
    loc.backgroundColor = [UIColor clearColor];
    loc.textAlignment = NSTextAlignmentCenter;
    loc.text = self.artist.loc;
    loc.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //get size
    
    NSString *info = [NSString stringWithFormat:@"\t%@\n\n\t%@",
                      self.artist.desc1 == NULL ? @"": self.artist.desc1,
                      self.artist.desc2 == NULL ? self.artist.desc1 == NULL?@"No description available":@"": [NSString stringWithFormat:@"%@\n",self.artist.desc2]];
    CGSize size = [info sizeWithFont:[UIFont fontWithName:myriadFontR size:17]
                   constrainedToSize:CGSizeMake(self.view.frame.size.width, 999)
                       lineBreakMode:NSLineBreakByWordWrapping];
    
    CGRect frame;
    frame = CGRectMake(0, CGRectGetMaxY(loc.frame)+10, self.view.frame.size.width, size.height*1.2);
    UITextView *textView = [[UITextView alloc] initWithFrame:frame];
    textView.backgroundColor = [UIColor clearColor];
    textView.font = [UIFont fontWithName:myriadFontR size:16];
    textView.textColor = [UIColor whiteColor];
    textView.text = info;
    textView.userInteractionEnabled = NO;
    textView.textAlignment = NSTextAlignmentJustified;
    textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [scroll addSubview:image];
    [scroll addSubview:name];
    [scroll addSubview:loc];
    [scroll addSubview:textView];
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(textView.frame));
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
