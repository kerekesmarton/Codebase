////
////  RadioLoginViewController.m
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/14/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "RadioLoginViewController.h"
//#import "StreamingDataManager.h"
//#import "RadioSignUpViewController.h"
//
//@interface RadioLoginViewController () <StreamingUserManagerProtocol,UITextFieldDelegate>
//
//@end
//
//@implementation RadioLoginViewController
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
//    
//    loginName.delegate = self;
//    loginPassword.delegate = self;
//    
//    NSString *loginNameStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"loginTextValue"];
//    if (loginNameStr && [loginNameStr isNotEmptyOrWhiteSpace]) {
//        loginName.text = loginNameStr;
//    }
//    
//    // Do any additional setup after loading the view from its nib.
//}
//
//-(void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//    [StreamingDataManager sharedInstance].userDelegate = nil;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(BOOL)textFieldShouldReturn:(UITextField*)textField;
//{
//    if (textField == loginName) {
//        // Found next responder, so set it.
//        [loginPassword becomeFirstResponder];
//        [[NSUserDefaults standardUserDefaults] setObject:textField.text forKey:@"loginTextValue"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
//    if (textField == loginPassword) {
//        [textField resignFirstResponder];
//        [self login:nil];
//    }
//    return NO; // We do not want UITextField to insert line-breaks.
//}
//
//-(IBAction)signUp:(id)sender {
//    
//    if ([self.presentingViewController respondsToSelector:@selector(dataManagerRequiresSignUp)]) {
//        [(id<StreamingDataManagerProtocol>)self.presentingViewController dataManagerRequiresSignUp];
//    }
//}
//
//-(IBAction)login:(id)sender {
//    
//    if ([loginName.text isEmptyOrWhiteSpace] || [loginPassword.text isEmptyOrWhiteSpace]) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required fields" message:@"Name and password are required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//        
//        return;
//    }
//    [StreamingDataManager sharedInstance].userDelegate = self;
//    [[StreamingDataManager sharedInstance] authenticateUser:loginName.text credentials:loginPassword.text];
//    
//}
//
//-(IBAction)cancel:(id)sender {
//    
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
//        //
//    }];
//}
//
//-(void)dataManagerAuthenticationSuccessful:(id)userData error:(NSError *)error {
//    
//    if (error) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Operation failed" message:[NSString stringWithFormat:@"%@",error.userInfo] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//            [alert show];
//        });
//    } else {
//        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
//            //fetch mix process is done automatically when the radio view appears
//        }];
//        
//    }
//}
//
//@end
