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
#import "WorkshopDay.h"
#import "WorkshopsDataManager.h"
#import "ArtistObject.h"
#import "SettingsManager.h"
#import "DateHelper.h"


@interface SAFWorkshopsViewController ()

@property(nonatomic) NSDateFormatter *cellDateFormatter;
@property(nonatomic) NSDateFormatter *headerDateFormatter;
@property(nonatomic) WorkshopDay *wsDay;
@property(nonatomic) NSDate *nextDay;

@end

@implementation SAFWorkshopsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.tabBarController.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.cellDateFormatter = [[NSDateFormatter alloc] init];
    [_cellDateFormatter setDateFormat:@"HH : mm"];
    [_cellDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Bucharest"]];

    self.headerDateFormatter = [NSDateFormatter new];
    _headerDateFormatter.timeStyle = NSDateFormatterNoStyle;
    _headerDateFormatter.dateFormat = @"EEEE";

    if (!self.day) {
        self.day = [self.allDays firstObject];
    }
    if (!self.allDays) {
        self.allDays = [WorkshopObject distinctWorkshopDays];
    }

    NSUInteger index = [self.allDays indexOfObject:self.day];
    if (self.allDays.count >= index+1) {
        self.nextDay = self.allDays[index+1];
        NSString *nextDayTitle = [_headerDateFormatter stringFromDate:self.nextDay];
        NSString *todayTitle = [_headerDateFormatter stringFromDate:self.day];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nextDayTitle style:UIBarButtonItemStyleDone target:self action:@selector(goToNextDay)];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:todayTitle style:UIBarButtonItemStyleDone target:nil action:nil];
    }
}

- (void)refresh {
    [[SettingsManager sharedInstance].selectedDay addToSelectedValues:self.day];
    [self refreshForDay:self.day];
}

- (void)refreshForDay:(NSDate *)day {
    NSArray *workshops = [WorkshopObject fetchWorkshopsForDay:day rooms:[SettingsManager sharedInstance].workshopsFilter.selectedValues];
    self.wsDay = [WorkshopDay new];
    self.wsDay.day = day;
    self.wsDay.workshops = workshops;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.wsDay.workshops.count?[self.headerDateFormatter stringFromDate:self.wsDay.day] : nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wsDay.workshops.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";

    //init cell
    SAFWorkshopsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SAFWorkshopsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    WorkshopObject *item = self.wsDay.workshops[indexPath.row];
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SAFWorkshopDetailsViewController *detailViewController = [[SAFWorkshopDetailsViewController alloc] init];
    detailViewController.item = self.wsDay.workshops[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)goToNextDay {
    SAFWorkshopsViewController *nextVC = [[SAFWorkshopsViewController alloc] init];
    nextVC.allDays = self.allDays;
    nextVC.day = self.nextDay;
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
