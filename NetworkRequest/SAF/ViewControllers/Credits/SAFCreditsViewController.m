//
//  SAFCreditsViewController.m
//  NetworkRequest
//
//  Created by Kerekes, Marton on 12/02/16.
//  Copyright © 2016 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFCreditsViewController.h"

@interface SAFCreditsViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *logo;
@property (strong, nonatomic) IBOutlet UIView *gradientBG;
@property (strong, nonatomic) IBOutlet UILabel *nameLbl;
@property (strong, nonatomic) IBOutlet UILabel *functionLbl;
@property (strong, nonatomic) IBOutlet UITextView *desc1;
@property (strong, nonatomic) CAGradientLayer *gradientLayer;


@end

@implementation SAFCreditsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *dismiss = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    UIBarButtonItem *goToFB = [[UIBarButtonItem alloc] initWithTitle:@"Visit us" style:UIBarButtonItemStyleDone target:self action:@selector(goToFacebook:)];
    
    self.navigationItem.leftBarButtonItem = dismiss;
    self.navigationItem.rightBarButtonItem = goToFB;
    
    _gradientBG.backgroundColor = [UIColor colorWithHex:0x2d2d2d];
    
    _logo.backgroundColor = [UIColor blackColor];
    _logo.contentMode = UIViewContentModeScaleAspectFit;
    
    _nameLbl.backgroundColor = [UIColor clearColor];
    _nameLbl.textColor = [UIColor redColor];
    _nameLbl.font = [UIFont fontWithName:futuraCondendsedBold size:25];
    
    _functionLbl.backgroundColor = [UIColor clearColor];
    _functionLbl.textColor = [UIColor lightGrayColor];
    _functionLbl.font = [UIFont fontWithName:myriadFontI size:20];
    
    _desc1.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
    
    if ([self.name isEqualToString: @"AIRE"])
    {
        UIImage *img = [UIImage imageNamed:@"AIRE LOGO"];
        _logo.image = img;
        _nameLbl.text = @"Aire Dance Company";
        _functionLbl.text = @"development";
        _desc1.text = [NSString stringWithFormat:@"\tAIRE Dance Company is proud to have developed the mobile application for this event.\n\n\tThis mobile application was designed to help event attendees get more out of the event and provide organizers with new channels to engage their audiences. There are many ways to enjoy a salsa event, one of which is to always have important information with you. We know this, because we love salsa and we often attend such events. With this application you can have all that information about the event at any time and place.\n\n\tTo find out more about us, please visit our Facebook page."];
    }
    else if ([self.name isEqualToString: @"Nuvo"])
    {
        
        UIImage *img = [UIImage imageNamed:@"nuvo logo"];
        _logo.image = img;
        _nameLbl.text = @"Nuvo Creative Studio";
        _functionLbl.text = @"design";
        _desc1.text = [NSString stringWithFormat:@"\tLaunched in the Webdesign and Branding industry since 2005, NuvoStudio found it’s own original way to put things together, composing unique designs and approaching with maximum responsibility and dedication, any kind of chalenge the clients have thrown in the game.\n\n\tWe hope you enjoy SAF App, and have a great party!!"];
    }
    else if ([self.name isEqualToString: @"Advents"])
    {
        
        UIImage *img = [UIImage imageNamed:@"advents logo"];
        _logo.image = img;
        _logo.backgroundColor = [UIColor whiteColor];
        _nameLbl.text = @"Advents";
        _functionLbl.text = @"design";
        _desc1.text = [NSString stringWithFormat:@"\tFrom marketing strategy to advertising campaigns, from Branding to graphic design, from company events to guerrilla marketing and PR... we choose from the menu of solutions that fits you best to differentiate yourself in the market and improve your business..\n\n\tWe hope you enjoy SAF App, and have a great party!!"];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _desc1.font = [UIFont fontWithName:myriadFontR size:16];
    _desc1.textColor = [UIColor whiteColor];
    _desc1.userInteractionEnabled = YES;
    _desc1.editable = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.gradientLayer)
    {
        self.gradientLayer = [CAGradientLayer layer];
        [_gradientBG.layer insertSublayer:_gradientLayer atIndex:0];
        _gradientLayer.frame = _gradientBG.bounds;
        [_gradientLayer setMasksToBounds:YES];
        [_gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x2d2d2d] CGColor],(id)[[UIColor colorWithHex:0x232323] CGColor], nil]];
        
        //    [_gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor],(id)[[UIColor grayColor] CGColor], nil]];
    }    
}

-(void)goToFacebook:(id)sender
{
    NSURL *url;
    if ([self.name isEqualToString: @"AIRE"])
    {
        url = [NSURL URLWithString:@"http://www.facebook.com/168510689919677"];
    }
    else if ([self.name isEqualToString:@"Nuvo"])
    {
        url = [NSURL URLWithString:@"http://www.facebook.com/225076320862473"];
    }
    else
    {
        url = [NSURL URLWithString:@"http://www.advents.ro"];
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
