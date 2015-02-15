//
//  ArtistDetailViewController.m
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/31/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ArtistDetailViewController.h"

@interface ArtistDetailViewController ()

@property (nonatomic,assign) IBOutlet UILabel      *artistName;
@property (nonatomic,assign) IBOutlet UITextView   *artistDetails;

@end

@implementation ArtistDetailViewController

@synthesize artistName,artistDetails;
@synthesize artist;

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
    self.artistName.text = self.artist.name;
    self.artistDetails.text = [self.artist.desc1 stringByAppendingFormat:@"\n%@",self.artist.desc2];
    self.artistDetails.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.artistDetails.editable = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
