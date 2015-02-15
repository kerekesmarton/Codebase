//
//  WorkshopDetailsViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/30/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "WorkshopDetailsViewController.h"
#import "ArtistObject.h"

@interface WorkshopDetailsViewController ()

@end

@implementation WorkshopDetailsViewController

@synthesize wsTitle,wsDescription;
@synthesize item;

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
    self.wsTitle.text = self.item.name;
    
    
    self.wsDescription.text = [NSString stringWithFormat:@"%@\n\n",self.item.details];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(0, 0, 25, 25) image:[UIImage imageNamed:@"star"]];
    [btn addTarget:self action:@selector(addToFavorites:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *favBtn = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [favBtn setTintColor: [self.item.favorited boolValue]?[UIColor blueColor]:nil];
    self.navigationItem.rightBarButtonItem = favBtn;
}

-(IBAction)addToFavorites:(UIBarButtonItem*)sender {
    
    BOOL action = NO;
    if (![self.item.favorited boolValue]) {
        action = YES;
    } else {
        action = NO;
    }
    
    self.item.favorited = [NSNumber numberWithBool:action];
    [[VICoreDataManager getInstance] saveMainContext];
    
    [sender setTintColor: action?[UIColor blueColor]:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
