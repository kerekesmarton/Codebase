////
////  RadioListenViewController.m
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/16/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "RadioListenViewController.h"
//#import "StreamingDataManager.h"
//#import "StreamingMix.h"
//#import "StreamingUser.h"
//#import "StreamingTrack.h"
//#import "AVPlayerManager.h"
//
//@interface RadioListenViewController () <AVPlayerDelegate,StreamingDataManagerProtocol> {
//    
//    IBOutlet UIButton *dismiss;
//}
//
//@end
//
//@implementation RadioListenViewController
//
//- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
//{
//    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    // Do any additional setup after loading the view from its nib.
//}
//
//-(void)viewWillAppear:(BOOL)animated {
//    
//    [AVPlayerManager sharedInstance].mix = self.currentMix;
//    [[AVPlayerManager sharedInstance] play];
//    [AVPlayerManager sharedInstance].delegate = self;
//    
//    [dismiss addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
//    
//    //start spinner
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(void)playerAtFirstTrack {
//    //enable Next btn;
//}
//
//-(void)playerAtLastTrack {
//    //enable Prev btn;
//}
//
//-(void)playerCanSkip {
//    //enable Skip btn;
//}
//
//-(void)playbackStarting {
//    //hide spinner
//}
//
//-(void)dismiss{
//    
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
//        //
//    }];
//}
//
//@end
