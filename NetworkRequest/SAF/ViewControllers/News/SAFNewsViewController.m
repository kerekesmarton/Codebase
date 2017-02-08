//
//  SAFNewsViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/20/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFNewsViewController.h"
#import "SAFSettingsViewController.h"
#import "SAFNewDetailViewController.h"

@implementation SAFNewsViewController {
    NSDateFormatter *_formatter;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    self.tableView.backgroundColor = [UIColor colorWithHex:0x3c3c3c];
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem];
    [self startRefresh];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

-(UIBarButtonItem *)editButtonItem {
    UIBarButtonItem *edit;
    if (self.editing) {
        edit = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(toggleEditing)];
    } else {
        edit = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(toggleEditing)];
    }
    return edit;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kSAFNewsCellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SAFNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCell"];
    if (cell == nil) {
        cell = [[SAFNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"NewsCell"];
    }
    if (!_formatter) {
        _formatter = [[NSDateFormatter alloc] init];
        [_formatter setTimeStyle:NSDateFormatterShortStyle];
        [_formatter setDateStyle:NSDateFormatterShortStyle];
    }
    
    // Configure the cell...
    NewsObject *item = [[NewsObject fetchUndeletedNews] objectAtIndex:indexPath.row];
    cell.textLabel.text = item.title;
    cell.detailTextLabel.text = [_formatter stringFromDate:item.timeStamp];
    cell.read = [item.read boolValue];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    
    SAFNewDetailViewController *detailViewController = [[SAFNewDetailViewController alloc] initWithNibName:[UIDevice isiPad]?@"SAFNewDetailViewController~iPad":@"SAFNewDetailViewController" bundle:nil];
    NewsObject *news = [[NewsObject fetchUndeletedNews] objectAtIndex:indexPath.row];
    detailViewController.item = news;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

//- (void)tableView:(UITableView*)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    self
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    self.navigationItem.rightBarButtonItems = @[self.editButtonItem];
    [self.navigationController setToolbarHidden:!editing animated:animated];
    
    
    UIBarButtonItem *settings = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(settingsButtonTapped:)];
    UIBarButtonItem *refresh = [[UIBarButtonItem alloc] initWithTitle:@"Refresh" style:UIBarButtonItemStyleBordered target:self action:@selector(startRefresh:)];
    UIBarButtonItem *flexi = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:NULL];
    
    
    self.toolbarItems = @[settings,flexi,refresh];
    
    [[self navigationController] setToolbarHidden:!self.editing animated:animated];
}

-(void)settingsButtonTapped:(UIBarButtonItem*)sender {
    
    UINavigationController *settingsViewController = [SAFSettingsViewController settingsViewControllerForOption:[SettingsManager sharedInstance].structureForNews andPresenter:self];
    settingsViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    [self.navigationController presentViewController:settingsViewController animated:YES completion:^{
        //
    }];
}

-(void)toggleEditing {
    
    [self setEditing:!self.editing animated:YES];
}

@end
