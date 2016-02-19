 //
//  SAGWorkshopsViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/21/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFWorkshopsViewController.h"
#import "SAFWorkshopsTableViewCell.h"
#import "SAFWorkshopDetailsViewController.h"
#import "WorkshopObject.h"
#import "WorkshopsDataManager.h"
#import "ArtistObject.h"
#import "SettingsManager.h"


@interface SAFWorkshopsViewController ()

@property(nonatomic,strong) NSDateFormatter *cellDateFormatter;

@end

@implementation SAFWorkshopsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    //    tabbar covers uitableview
    if ([self.tabBarController respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.tabBarController.edgesForExtendedLayout = UIRectEdgeNone;
    }

    self.cellDateFormatter = [[NSDateFormatter alloc] init];
    [_cellDateFormatter setDateFormat:@"HH : mm"];
    [_cellDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Bucharest"]];

}

- (void)refresh {
    self.items = [WorkshopObject fetchWorkshopsForSelectedDayAndRooms];
    [self.tableView reloadData];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.items.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";

    //init cell
    SAFWorkshopsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SAFWorkshopsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    WorkshopObject *item = [self.items objectAtIndex:indexPath.row];
    
    ArtistObject *artistO = [ArtistObject artistForId:item.instructor];
    cell.instructor.text = artistO.name;
    cell.name.text = item.name;
    cell.difficulty = item.difficulty.intValue;    
    
    [cell.date setText:[NSString stringWithFormat:@"%@\n-\n%@",
                    [_cellDateFormatter stringFromDate:item.time],
                    [_cellDateFormatter stringFromDate:[NSDate dateWithTimeInterval:3000 sinceDate:item.time]]]];
    
    cell.favorited = item.favorited.boolValue;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
    SAFWorkshopDetailsViewController *detailViewController = [[SAFWorkshopDetailsViewController alloc] init];
    detailViewController.item = [self.items objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
