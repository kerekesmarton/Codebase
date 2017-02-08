//
//  ViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 5/25/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "NewsViewController.h"

@interface NewsViewController () <UIAlertViewDelegate,SettingsProtocol>

@end

@implementation NewsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIToolbar *toolbar = self.navigationController.toolbar;
    if ([toolbar respondsToSelector:@selector(barTintColor)]) {
        toolbar.barTintColor = [UIColor blackColor];
        toolbar.tintColor = [UIColor whiteColor];
        toolbar.translucent = NO;
    }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    
    UIButton *settingsBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 24, 24) image:[UIImage imageNamed:@"gears"]];
    [settingsBtn addTarget:self action:@selector(settingsButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithCustomView:settingsBtn];
    
    
    UIButton *refreshBtn = [UIButton buttonWithFrame:CGRectMake(0, 0, 24, 24) image:[UIImage imageNamed:@"refresh"]];
    [refreshBtn addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithCustomView:refreshBtn];
    //    _editButtonItem.image = [UIImage imageNamed:@"edit"];
    
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem,settings,refresh];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(startRefresh:) forControlEvents:UIControlEventValueChanged];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refresh];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(UIBarButtonItem *)editButtonItem {
    UIButton *editButton = [UIButton buttonWithFrame:CGRectMake(0, 0, 24, 24) image:[UIImage imageNamed:@"edit_notes"] highlightedImage:[UIImage imageNamed:@"approve_notes"]];
    [editButton addTarget:self action:@selector(toggleEditing) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithCustomView:editButton];
    return refresh;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)startRefresh {
    [[NewsDataManager sharedInstance] requestDataWitchSuccess:^(id data)
     {
         [self refresh];
         if ([self.refreshControl isRefreshing])
         {
             [self.refreshControl endRefreshing];
         }
     } failBlock:^(id data)
     {
         [self alertMissingData];
         if ([self.refreshControl isRefreshing])
         {
             [self.refreshControl endRefreshing];
         }
     }];
}

- (void)startRefresh:(UIBarButtonItem*)control
{
    [self startRefresh];
}

- (void)refresh {
    self.items = [NewsObject fetchUndeletedNews];
    [self.tableView reloadData];
}

- (void)alertMissingData {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"Failed to retrieve data" message:@"Do you want to retry fetching from server?" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [av show];
}

#pragma mark - Table view data source

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
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NewsObject *item = [self.items objectAtIndex:indexPath.row];
    
    cell.textLabel.text = item.title;
    
    if (item.read) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        NewsObject *news = [self.items objectAtIndex:indexPath.row];
        [news markAsDeleted];
        
        [self refresh];
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    DetailsViewController *detailViewController = [[DetailsViewController alloc] initWithNibName:@"DetailsViewController" bundle:nil];
    NewsObject *news = [self.items objectAtIndex:indexPath.row];
    detailViewController.item = news;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    [self startRefresh:nil];
}

-(void)settingsButtonTapped:(UIBarButtonItem*)sender {
    
    UINavigationController *settingsViewController = [SettingsViewController settingsViewControllerForOption:[SettingsManager sharedInstance].structureForNews andPresenter:self];
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

-(void)toggleEditing {
    
    [self setEditing:!self.editing animated:YES];
}

@end
