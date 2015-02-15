////
////  RadioViewController.m
////  NetworkRequest
////
////  Created by Kerekes Jozsef-Marton on 10/11/13.
////  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
////
//
//#import "RadioViewController.h"
//#import "StreamingDataManager.h"
//#import "RadioLoginViewController.h"
//#import "RadioSignUpViewController.h"
//#import "RadioListenViewController.h"
//
//#import "StreamingMix.h"
//#import "StreamingUser.h"
//#import "SettingsViewController.h"
//
//
//
//typedef enum AlertConstants{
//    
//    alertSignUpPassword,
//    alertSignUpEmail,
//    alertSignUpSuccess,
//    alertSignUpLoggedOut,
//}AlertConstants;
//
//@interface RadioViewController () <UIAlertViewDelegate, StreamingDataManagerProtocol,SettingsProtocol>
//
//@property (nonatomic, assign) BOOL didTryLogin;
//@property (nonatomic, strong) NSMutableArray *data;
//
//@end
//
//@implementation RadioViewController
//
//@synthesize data,didTryLogin;
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    self.didTryLogin = NO;
//    self.data = [[NSMutableArray alloc] init];
//    
//    // Uncomment the following line to preserve selection between presentations.
//    // self.clearsSelectionOnViewWillAppear = NO;
// 
//    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
//}
//
//-(void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//    
//    if (!didTryLogin) {
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [StreamingDataManager sharedInstance].dataDelegate = self;
//            [[StreamingDataManager sharedInstance] fetchMixes];
//        });
//    } else {
//        //TODO: add label that user has to log in
//    }
//    
//    UIBarButtonItem *filter = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonTapped:)];
//    self.navigationItem.rightBarButtonItem = filter;
//}
//
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.data.count;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // Configure the cell...
//    
//    StreamingMix *mix = [self.data objectAtIndex:indexPath.row];
//    cell.textLabel.text = mix.name;
//    
//    return cell;
//}
//
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
///*
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//*/
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
//#pragma mark - Table view delegate
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    StreamingMix *mix = [self.data objectAtIndex:indexPath.row];
//    
//    RadioListenViewController *listen = [[RadioListenViewController alloc] initWithNibName:@"RadioListenViewController" bundle:nil];
//    listen.currentMix = mix;
//    [self.navigationController presentViewController:listen animated:YES completion:^{ }];
//}
//
//#pragma mark - UIAlertView
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
//    
//    if (alertView.cancelButtonIndex == buttonIndex) {
//        return;
//    }
//    
//    switch (alertView.tag) {
//        case alertSignUpPassword:
//            
//            break;
//            
//        default:
//            break;
//    }
//}
//
//-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
//    
//}
//
//
//#pragma mark - Streaming Data Manager
//
//-(void)dataManagerRequiresAuthentication {
//    
//    RadioLoginViewController *login = [[RadioLoginViewController alloc] initWithNibName:@"RadioLoginViewController" bundle:nil];
//    login.modalPresentationStyle = UIModalPresentationFormSheet;
//    login.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    
//    if (self.presentedViewController) {
//        [self.navigationController dismissViewControllerAnimated:NO completion:^{
//            [self.navigationController presentViewController:login animated:YES completion:^{ }];
//        }];
//    } else {
//        [self.navigationController presentViewController:login animated:YES completion:^{ }];
//    }
//    
//    
//    
//    
//}
//
//-(void)dataManagerRequiresSignUp {
//    
//    RadioSignUpViewController *login = [[RadioSignUpViewController alloc] initWithNibName:@"RadioSignUpViewController" bundle:nil];
//    login.modalPresentationStyle = UIModalPresentationFormSheet;
//    login.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    
//    if (self.presentedViewController) {
//        [self.navigationController dismissViewControllerAnimated:NO completion:^{
//            [self.navigationController presentViewController:login animated:YES completion:^{ }];
//        }];
//    } else {
//        [self.navigationController presentViewController:login animated:YES completion:^{ }];
//    }
//}
//
//-(void)dataManager:(StreamingDataManager *)manager didRetrieveResults:(NSArray *)results {
//    
//    [self.data removeAllObjects];
//    [self.data addObjectsFromArray:results];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });
//}
//
//-(void)dataManager:(StreamingDataManager *)manager failedToRetrieveResultsWithError:(NSError *)error {
//    
//    [data removeAllObjects];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [self.tableView reloadData];
//    });
//}
//
//#pragma mark - Settings
//
//-(void)settingsButtonTapped:(UIBarButtonItem*)sender {
//    
//    UINavigationController *settingsViewController = [SettingsViewController settingsViewControllerForOption:[SettingsManager sharedInstance].structureForStreaming andPresenter:self];
//    settingsViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
//    
//    [self.navigationController presentViewController:settingsViewController animated:YES completion:^{
//        //
//    }];
//    
//}
//
//-(void)settingsDidDismiss:(SettingsViewController*)settingsViewController {
//    
//    [self.navigationController dismissViewControllerAnimated:YES completion:^{
//        //
//    }];
//}
//
//@end
