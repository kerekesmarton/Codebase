////
////  RadoSignUpViewController.m
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/14/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "RadioSignUpViewController.h"
//#import "StreamingDataManager.h"
//
//@interface RadioSignUpViewController () <UITextFieldDelegate,StreamingUserManagerProtocol>
//
//@end
//
//@implementation RadioSignUpViewController
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
//    signupName.delegate = self;
//    signupEmail.delegate = self;
//    signupPassword.delegate = self;
//    signupPasswordConfirm.delegate = self;
//    
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
//
//-(BOOL)textFieldShouldReturn:(UITextField*)textField;
//{
//    if (textField == signupName) {
//        [signupEmail becomeFirstResponder];
//    }
//    if (textField == signupEmail) {
//        [signupPasswordConfirm becomeFirstResponder];
//    }
//    if (textField == signupPassword) {
//        [signupPasswordConfirm becomeFirstResponder];
//    }
//    if (textField == signupPasswordConfirm) {
//        [signupPasswordConfirm resignFirstResponder];
//        [self signUp:nil];
//    }
//    return NO; // We do not want UITextField to insert line-breaks.
//}
//
//-(IBAction)signUp:(id)sender {
//    
//    if ([signupName.text isEmptyOrWhiteSpace] || [signupEmail.text isEmptyOrWhiteSpace] || [signupPassword.text isEmptyOrWhiteSpace]) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required fields" message:@"All fields are required to proceed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//        
//        return;
//    }
//    
//    
//    if (![signupPassword.text isEqualToString:signupPasswordConfirm.text]) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Password error" message:@"Passwords do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//        
//        return;
//    }
//    
//    [StreamingDataManager sharedInstance].userDelegate = self;
//    [[StreamingDataManager sharedInstance] createUser:signupName.text password:signupPassword.text address:signupEmail.text didAgree:YES];
//}
//
//-(IBAction)cancel:(id)sender {
//    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
//        //fetch mix process is done automatically when the radio view appears
//    }];
//}
//
//-(void)dataManagerAuthenticationSuccessful:(id)userData error:(NSError *)error {
//    
//    if (error) {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"There was an error creating your account" message:[error.userInfo description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
//        [alert show];
//        
//        return;
//    } else {
//        [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
//            //fetch mix process is done automatically when the radio view appears
//        }];
//    }
//}
//
//@end
