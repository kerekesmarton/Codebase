//
//  DetailsViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "DetailsViewController.h"
#import <Social/Social.h>
#import "UIViewController+Shareing.h"

@interface DetailsViewController ()

@end

@implementation DetailsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    self.item.read = @YES;
    [[VICoreDataManager getInstance] saveMainContext];
    
    self.textView.text=self.item.desc;
    
    UIButton *del = [UIButton buttonWithFrame:CGRectMake(0, 0, 25, 25) image:[UIImage imageNamed:@"trash"]];
    [del addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *deleteBtn = [[UIBarButtonItem alloc] initWithCustomView:del];
    deleteBtn.tintColor = [UIColor redColor];
    
    UIButton *share = [UIButton buttonWithFrame:CGRectMake(0, 0, 25, 25) image:[UIImage imageNamed:@"right2"]];
    [share addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *shareBtn = [[UIBarButtonItem alloc] initWithCustomView:share];
    
    self.navigationItem.rightBarButtonItems = @[deleteBtn,shareBtn];
}

-(IBAction)delete:(id)sender {
    
    [self.item setDel:[NSNumber numberWithBool:YES]];
    [[VICoreDataManager getInstance] saveMainContext];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
