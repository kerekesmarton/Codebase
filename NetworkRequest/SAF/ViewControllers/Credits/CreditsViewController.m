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
@property (strong, nonatomic) IBOutlet UIView *blackBG;
@property (strong, nonatomic) IBOutlet UIView *gradientBG;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *functionLbl;
@property (strong, nonatomic) IBOutlet UIView *grayBG;
@property (strong, nonatomic) IBOutlet UITextView *desc1;
@property (strong, nonatomic) IBOutlet UIButton *shareBtn;


@end

@implementation CreditsViewController

- (id)initWithName:(NSString *)name
{
    self = [super initWithNibName:@"CreditsViewController" bundle:nil];
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
    
    self.blackBG.backgroundColor = [UIColor blackColor];
    
    UIImageView *logo = [[UIImageView alloc] initWithFrame:_blackBG.frame];
    logo.backgroundColor = [UIColor clearColor];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = _gradientBG.frame;
    [gradientLayer setMasksToBounds:YES];
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x2d2d2d] CGColor],(id)[[UIColor colorWithHex:0x232323] CGColor], nil]];
    
    _nameLbl.backgroundColor = [UIColor clearColor];
    _nameLbl.textColor = [UIColor redColor];
    _nameLbl.font = [UIFont fontWithName:futuraCondendsedBold size:25];

    _functionLbl.backgroundColor = [UIColor clearColor];
    _functionLbl.textColor = [UIColor lightGrayColor];
    _functionLbl.font = [UIFont fontWithName:myriadFontI size:20];
    
    _grayBG.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
    
    
    _desc1.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    _desc1.backgroundColor = [UIColor clearColor];
    _desc1.font = [UIFont fontWithName:myriadFontR size:16];
    _desc1.textColor = [UIColor whiteColor];
    _desc1.userInteractionEnabled = NO;
    
    if ([self.name isEqualToString: @"AIRE"])
    {
        
        UIImage *img = [[UIImage imageNamed:@"AIRE LOGO"] scaleToSize:CGSizeMake(240/1.43, 160)];
        logo.image = img;
        _nameLbl.text = @"aire dance company";
        _functionLbl.text = @"development";
        _desc1.text = [NSString stringWithFormat:@"\tAIRE Dance Company is proud to have developed the mobile application for this event.\n\n\tThis mobile application was designed to help event attendees get more out of the event and provide organizers with new channels to engage their audiences. There are many ways to enjoy a salsa event, one of which is to always have important information with you. We know this, because we love salsa and we often attend such events. With this application you can have all that information about the event at any time and place.\n\n\tTo find out more about us, please visit our Facebook page."];
    }
    else if ([self.name isEqualToString: @"Nuvo"])
    {
        
        UIImage *img = [[UIImage imageNamed:@"nuvo logo"] scaleToSize:CGSizeMake(320, 130/1.375)];
        logo.image = img;
        _nameLbl.text = @"nuvo creative studio";
        _functionLbl.text = @"design";
        _desc1.text = [NSString stringWithFormat:@"\tLaunched in the Webdesign and Branding industry since 2005, NuvoStudio found it’s own original way to put things together, composing unique designs and approaching with maximum responsibility and dedication, any kind of chalenge the clients have thrown in the game.\n\n\tWe hope you enjoy SAF App, and have a great party!!"];
    }
    else if ([self.name isEqualToString: @"Advents"])
    {
        
        UIImage *img = [[UIImage imageNamed:@"advents logo"] scaleToSize:CGSizeMake(320, 130/1.375)];
        logo.image = img;
        _nameLbl.text = @"Advents";
        _functionLbl.text = @"design";
        _desc1.text = [NSString stringWithFormat:@"\tFrom marketing strategy to advertising campaigns, from Branding to graphic design, from company events to guerrilla marketing and PR... we choose from the menu of solutions that fits you best to differentiate yourself in the market and improve your business..\n\n\tWe hope you enjoy SAF App, and have a great party!!"];
    }

    
    NSString *title = @"Visit us on facebook";
    
    [_shareBtn addTarget:self action:@selector(goToFacebook) forControlEvents:UIControlEventTouchUpInside];
    [_shareBtn setTitle:title forState:UIControlStateNormal];
    [_shareBtn.titleLabel setFont:[UIFont fontWithName:futuraCondendsedBold size:20]];
    [_shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];

}

-(IBAction)goToFacebook:(id)sender
{
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
