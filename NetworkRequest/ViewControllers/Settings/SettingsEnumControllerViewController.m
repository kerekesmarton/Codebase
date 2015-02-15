//
//  SettingsEnumControllerViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 6/15/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SettingsEnumControllerViewController.h"

@interface SettingsEnumControllerViewController ()

@end

@implementation SettingsEnumControllerViewController

@synthesize options;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.block = ^(){};
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        self.block = ^(){};
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.options.name isEqualToString:WorkshopFilter]) {
        [self.tableView setAllowsMultipleSelection:YES];
    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    for (id obj in options.possibleValues) {
        if ([options.selectedValues containsObject:obj]) {
            NSIndexPath *ip = [NSIndexPath indexPathForRow:[options.possibleValues indexOfObject:obj] inSection:0];
            [self.tableView selectRowAtIndexPath:ip animated:YES scrollPosition:UITableViewScrollPositionMiddle];
        }
    }
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
    return options.possibleValues.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    id settingValue = [options.possibleValues objectAtIndex:indexPath.row];
    NSString *desc = [options.displayValues objectAtIndex:indexPath.row];
    
    if (desc) {
        cell.textLabel.text = desc;
    } else {
        if ([settingValue isKindOfClass:[NSNumber class]]) {
            cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)[settingValue integerValue]];
        }
        if ([settingValue isKindOfClass:[NSString class]]) {
            cell.textLabel.text = settingValue;
        }
    }
    
    if (options.type == SettingMultiple || options.type == SettingEnum) {
        if ([options.selectedValues containsObject:settingValue]) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        } else {
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    }
    
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
    id settingValue = [options.possibleValues objectAtIndex:indexPath.row];
    if (options.type == SettingMultiple) {

        if ([options.selectedValues containsObject:settingValue]) {
            [options removeFromSelectedValues:settingValue];
        }
        else {
            [options addToSelectedValues:settingValue];
        }    
    } else {
        options.selectedValues = @[settingValue];
    }
    [options save];
    self.block();
    [tableView reloadData];
}

@end
