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


@interface SAFWorkshopsViewController ()

@property(nonatomic,strong) NSDateFormatter *cellDateFormatter;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSIndexPath *today;

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
    
    self.objects = [NSMutableArray array];
    NSDate *today = [DateHelper begginingOfDay:[NSDate date]];
    NSArray *days = [[WorkshopObject distinctWorkshopDays] mutableCopy];
    [days enumerateObjectsUsingBlock:^(NSDate *day, NSUInteger idx, BOOL * _Nonnull stop) {
        [[SettingsManager sharedInstance].selectedDay addToSelectedValues:day];
        NSArray *workshops = [WorkshopObject fetchWorkshopsForSelectedRooms];
        WorkshopDay *wsDay = [WorkshopDay new];
        wsDay.day = day;
        wsDay.workshops = workshops;
        [self.objects addObject:wsDay];
        if ([today isEqual:day]) {
            self.today = [NSIndexPath indexPathForRow:0 inSection:idx];
        }
    }];
    
    [self.tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.today) {
        [self.tableView scrollToRowAtIndexPath:self.today atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.objects.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    WorkshopDay *wsDay = self.objects[section];
    NSDateFormatter *formatter = [NSDateFormatter new];
    formatter.timeStyle = NSDateFormatterNoStyle;
    formatter.dateFormat = @"EEEE";
//    formatter.doesRelativeDateFormatting = YES;
    
    return wsDay.workshops.count?[formatter stringFromDate:wsDay.day] : nil;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    WorkshopDay *wsDay = self.objects[section];
    return wsDay.workshops.count;
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
    WorkshopDay *wsDay = self.objects[indexPath.section];
    WorkshopObject *item = wsDay.workshops[indexPath.row];
    
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
    WorkshopDay *wsDay = self.objects[indexPath.section];
    detailViewController.item = wsDay.workshops[indexPath.row];
    [self.navigationController pushViewController:detailViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
