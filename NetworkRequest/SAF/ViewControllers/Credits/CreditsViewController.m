//
//  CreditsViewController.m
//  SAFapp
//
//  Created by Jozsef-Marton Kerekes on 2/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "CreditsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "SAFDefines.h"

@interface CreditsViewController ()

@property (nonatomic, retain) NSString *name;
@end

@implementation CreditsViewController

- (id)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        // Custom initialization
        self.name = name;
    }
    return self;
}
- (void)dealloc
{
    self.name = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
	// Do any additional setup after loading the view.
    
    UIBarButtonItem *dismiss = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = dismiss;
    
    UIView *blackBG = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
    blackBG.backgroundColor = [UIColor blackColor];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:blackBG.frame];
    logo.backgroundColor = [UIColor clearColor];
    
    
    UIView *gradientBG = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(blackBG.frame), self.view.frame.size.width, 80)];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
    [gradientLayer setMasksToBounds:YES];
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x2d2d2d] CGColor],(id)[[UIColor colorWithHex:0x232323] CGColor], nil]];
    
    
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMinY(gradientBG.frame)+5, self.view.frame.size.width, 45)];
    name.backgroundColor = [UIColor clearColor];
    name.textColor = [UIColor orangeColor];
    name.font = [UIFont fontWithName:@"edo" size:25];
    name.textAlignment = NSTextAlignmentCenter;
    


    UILabel *function = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(name.frame), self.view.frame.size.width, 25)];
    function.backgroundColor = [UIColor clearColor];
    function.textColor = [UIColor lightGrayColor];
    function.font = [UIFont fontWithName:myriadFontI size:20];
    function.textAlignment = NSTextAlignmentCenter;
    

    
    UIView *grayBG = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(gradientBG.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(gradientBG.frame))];
    grayBG.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
    
    
    UITextView *desc1 = [[UITextView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(gradientBG.frame), self.view.frame.size.width, self.view.frame.size.height-CGRectGetMaxY(gradientBG.frame))];
    desc1.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    desc1.backgroundColor = [UIColor clearColor];
    desc1.font = [UIFont fontWithName:myriadFontR size:16];
    desc1.textColor = [UIColor whiteColor];
    desc1.textAlignment = NSTextAlignmentJustified;
    desc1.userInteractionEnabled = NO;
    
    UIScrollView *scroll = [[UIScrollView alloc] initWithFrame:self.view.frame];
    scroll.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    scroll.backgroundColor = [UIColor colorWithHex:0x2d2d2d];
    [self.view addSubview:scroll];
    scroll.bounces = NO;

    
    [scroll addSubview:blackBG];
    [scroll addSubview:logo];
    [scroll addSubview:gradientBG];
    [gradientBG.layer insertSublayer:gradientLayer atIndex:0];
    [scroll addSubview:name];
    [scroll addSubview:function];
    [scroll addSubview:grayBG];
    [scroll addSubview:desc1];
    
    
    if ([self.name isEqualToString: @"AIRE"]) {
        
        UIImage *img = [[UIImage imageNamed:@"AIRE LOGO"] scaleToSize:CGSizeMake(240/1.43, 160)];
        logo.image = img;
        logo.frame = CGRectMake((self.view.frame.size.width-img.size.width)/2, 0, img.size.width, img.size.height);
        name.text = @"aire dance company";
        function.text = @"development";
        desc1.text = [NSString stringWithFormat:@"\tAIRE Dance Company is proud to have developed the mobile application for this event.\n\n\tThis mobile application was designed to help event attendees get more out of the event and provide organizers with new channels to engage their audiences. There are many ways to enjoy a salsa event, one of which is to always have important information with you. We know this, because we love salsa and we often attend such events. With this application you can have all that information about the event at any time and place.\n\n\tTo find out more about us, please visit our Facebook page."];
    } else {
        
        UIImage *img = [[UIImage imageNamed:@"nuvo logo"] scaleToSize:CGSizeMake(320, 130/1.375)];
        logo.image = img;
        logo.frame = CGRectMake((self.view.frame.size.width-img.size.width)/2, (blackBG.frame.size.height-img.size.height)/2, img.size.width, img.size.height);
        name.text = @"nuvo creative studio";
        function.text = @"design";
        desc1.text = [NSString stringWithFormat:@"\tLaunched in the Webdesign and Branding industry since 2005, NuvoStudio found it’s own original way to put things together, composing unique designs and approaching with maximum responsibility and dedication, any kind of chalenge the clients have thrown in the game.\n\n\tWe hope you enjoy SAF App, and have a great party!!"];
    }

    
    NSDictionary *attr = @{NSFontAttributeName:[UIFont fontWithName:myriadFontR size:16]};
    
    CGRect boundingRect = [desc1.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width, 999) options:0 attributes:attr context:nil];
    CGSize size = boundingRect.size;
    
//    CGSize size = [desc1.text sizeWithFont:[UIFont fontWithName:myriadFontR size:16]
//                         constrainedToSize:CGSizeMake(self.view.frame.size.width, 999)
//                             lineBreakMode:NSLineBreakByWordWrapping];

    desc1.frame = CGRectMake(desc1.frame.origin.x, desc1.frame.origin.y, desc1.frame.size.width, size.height*1.5);
    grayBG.frame = desc1.frame;
    
    scroll.contentSize = CGSizeMake(self.view.frame.size.width, CGRectGetMaxY(desc1.frame));
        
    NSString *title = @"Visit us on facebook";
    CGSize fbSize = [title sizeWithFont:[UIFont fontWithName:@"edo" size:24]];
    UIImage *img = [[UIImage imageNamed:@"buton albastru"] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
    UIButton *share = [UIButton buttonWithType:UIButtonTypeCustom];
    share.frame = CGRectMake((self.view.frame.size.width-fbSize.width)/2, scroll.contentSize.height-fbSize.height-10, fbSize.width, fbSize.height);
    [share setBackgroundImage:img forState:UIControlStateNormal];
    [share addTarget:self action:@selector(goToFacebook) forControlEvents:UIControlEventTouchUpInside];
    [share setTitle:title forState:UIControlStateNormal];
    [share.titleLabel setFont:[UIFont fontWithName:@"edo" size:20]];
    [share setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [scroll addSubview:share];
}

-(void)goToFacebook {
    
    NSURL *url;
    if ([self.name isEqualToString: @"AIRE"]) {
        url = [NSURL URLWithString:@"http://www.facebook.com/168510689919677"];
    } else {
        url = [NSURL URLWithString:@"http://www.facebook.com/225076320862473"];
    }
    [[UIApplication sharedApplication] openURL:url];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismiss {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation{
    
    return NO;
}

@end
