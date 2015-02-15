;//
//  ArtistsViewController.m
//  NetworkRequest
//
//  Created by Kerekes Marton on 5/31/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "ArtistsViewController.h"

#import "ArtistObject.h"
#import "ArtistsDataManager.h"
#import "ArtistDetailViewController.h"

#import "ArtistImageDataManager.h"

@interface ArtistsViewController () <UIAlertViewDelegate>

@end

@implementation ArtistsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refresh];
    
    UIBarButtonItem *filter = [[UIBarButtonItem alloc] initWithTitle:@"Filter" style:UIBarButtonItemStylePlain target:self action:@selector(settingsButtonTapped:)];
    self.navigationItem.rightBarButtonItem = filter;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[ArtistsDataManager sharedInstance] cancelRequest];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRefresh:(UIBarButtonItem*)control {
    
    [[ArtistsDataManager sharedInstance] requestDataWitchSuccess:^(id data) {
        [self refresh];
        
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
    } failBlock:^(id data) {
        [self alertMissingData];
        if ([self.refreshControl isRefreshing]) {
            [self.refreshControl endRefreshing];
        }
    }];
}

- (void)refresh {
    self.items = [ArtistObject fetchArtistsForCurrentSettingsType];
    [self.tableView reloadData];
}

- (void)alertMissingData {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Failed to retrieve data" message:@"Do you want to retry fetching from server?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [av show];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    ArtistObject *artist = [self.items objectAtIndex:indexPath.row];
    cell.textLabel.text = artist.name;
    
    if (artist.solo!= NULL) {
        artist = [ArtistObject artistForSolo:artist.solo];
    }
    [[ArtistImageDataManager sharedInstance] imageForString:artist.img completionBlock:^(NSData *imgData) {
        cell.imageView.image = [UIImage imageWithData:imgData];
        [cell setNeedsLayout];
    } failureBlock:^(NSError *error) {
        cell.imageView.image = nil;
        [cell setNeedsLayout];
    }];

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    ArtistDetailViewController *detailViewController = [[ArtistDetailViewController alloc] initWithNibName:NSStringFromClass([ArtistDetailViewController class]) bundle:nil];
    
    ArtistObject *artist = [self.items objectAtIndex:indexPath.row];
    if (artist.solo != NULL) {
        artist = [ArtistObject artistForSolo:artist.solo];
    }
    detailViewController.artist = artist;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex != alertView.cancelButtonIndex) {
        [self startRefresh:nil];
    }
}

-(void)settingsButtonTapped:(UIBarButtonItem*)sender {
    
    UINavigationController *settingsViewController = [SettingsViewController settingsViewControllerForOption:[SettingsManager sharedInstance].structureForArtists andPresenter:self];
    settingsViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.navigationController presentViewController:settingsViewController animated:YES completion:^{
        //
    }];
    
}

-(void)settingsDidDismiss:(SettingsViewController *)settingsViewController {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        //
    }];
}


@end
