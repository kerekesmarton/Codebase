//
//  SettingsViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/11/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SettingsViewController.h"
#import "SettingsEnumControllerViewController.h"
#import "CustomNavigationBar.h"


@implementation SettingsViewController
@synthesize presenter;
@synthesize settingOptionGroup;

+(UINavigationController *)settingsViewControllerForOption:(SettingOptionGroup*)optionGroup andPresenter:(id<SettingsProtocol>)presenter{
    
    SettingsViewController *settings = [[SettingsViewController alloc] initWithNibName:NSStringFromClass([SettingsViewController class]) bundle:nil];
    settings.presenter = presenter;
    settings.settingOptionGroup = optionGroup;
    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[CustomNavigationBar class] toolbarClass:[UIToolbar class]];
    navController.viewControllers = @[settings];
    
    if ([navController.navigationBar respondsToSelector:@selector(barTintColor)]) {
        navController.navigationBar.barTintColor = [UIColor blackColor];
        navController.navigationBar.tintColor = [UIColor whiteColor];
        [navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        navController.navigationBar.translucent = NO;
    }
    
    return navController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStyleDone target:self action:@selector(dismissTapped:)];
}

-(void)dismissTapped:(id)sender {
    
    [self.presenter settingsDidDismiss:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return self.settingOptionGroup.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSArray *options = self.settingOptionGroup.items;
    SettingOption *option = [options objectAtIndex:indexPath.row];
    
    switch (option.type) {
        case SettingBool:
            cell.accessoryView = [self switchForItem:option];
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case SettingEnum:
        case SettingMultiple:
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case SettingGroup:
            cell.accessoryView = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = option.displayName;
    
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [self.settingOptionGroup groupName];
}

-(NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return [self.settingOptionGroup groupDescription];
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
    NSArray *options = self.settingOptionGroup.items;
    SettingOption *option = [options objectAtIndex:indexPath.row];
    
    switch (option.type) {
        case SettingBool:
        {
            //do nothing
        }
            break;
        case SettingGroup:
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"TBA.." message:@"not implemented" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [av show];
        }
            break;
        case SettingEnum:
        {
            SettingsEnumControllerViewController *controller = [[SettingsEnumControllerViewController alloc] initWithStyle:UITableViewStyleGrouped];
            controller.options = option;
            controller.block = ^(){
                [self dismissTapped:nil];
            };
            
            [self.navigationController pushViewController:controller animated:YES];
            controller.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem;
        }
            break;
        case SettingMultiple:
        {
//            SettingsEnumControllerViewController *controller = [[SettingsEnumControllerViewController alloc] initWithNibName:NSStringFromClass([SettingsEnumControllerViewController class]) bundle:nil];
            SettingsEnumControllerViewController *controller = [[SettingsEnumControllerViewController alloc] initWithStyle:UITableViewStyleGrouped];
            controller.options = option;
            [self.navigationController pushViewController:controller animated:YES];
            controller.navigationItem.rightBarButtonItem = self.navigationItem.rightBarButtonItem;
        }
        default:
            break;
    }
}

- (UISwitch*)switchForItem:(SettingOption*)option {
    
    UISwitch *switchView = [[UISwitch alloc] init];
    [switchView addTarget:option action:@selector(changeWithControl:) forControlEvents:UIControlEventValueChanged];
    switchView.on = [(NSNumber*)option.selectedValues.lastObject boolValue];
    return switchView;
}

@end
