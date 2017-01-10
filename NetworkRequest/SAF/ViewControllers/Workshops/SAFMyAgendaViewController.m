//
//  SAFMyAgendaViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/31/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFMyAgendaViewController.h"
#import "WorkshopObject.h"
#import "ArtistObject.h"
#import "SAFWorkshopDetailsViewController.h"
#import "SAFMyAgendaTableViewCell.h"
#import "SettingsManager.h"
#import "SAFNavigationBar.h"
#import "WorkshopDay.h"

@interface SAFMyAgendaViewController ()

@property(nonatomic,strong) NSDateFormatter *cellDateFormatter;
@property (nonatomic, strong) NSMutableArray *objects;
@property (nonatomic, strong) NSIndexPath *today;

@end

@implementation SAFMyAgendaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.cellDateFormatter = [[NSDateFormatter alloc] init];
    [_cellDateFormatter setDateFormat:@"HH : mm"];
    [_cellDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Bucharest"]];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
    [self.tableView reloadData];
}

- (void)refresh {
    
    self.objects = [NSMutableArray array];
    NSDate *today = [DateHelper begginingOfDay:[NSDate date]];
    NSArray *days = [[WorkshopObject distinctWorkshopDays] mutableCopy];
    [days enumerateObjectsUsingBlock:^(NSDate *day, NSUInteger idx, BOOL * _Nonnull stop) {
        [[SettingsManager sharedInstance].selectedDay addToSelectedValues:day];
        NSArray *workshops = [WorkshopObject fetchWorkshopsForSelectedRooms];
        WorkshopDay *wsDay = [WorkshopDay new];
        
        
        //Create a method in workshopObject to return a WorkshopDay / FavoriteWorkshopsDay
        
        wsDay.distinctHours = [WorkshopObject distinctWorkshopHoursForArray:workshops day:day filterFavorites:YES];
        wsDay.day = day;
        wsDay.workshops = workshops;
        [self.objects addObject:wsDay];
        if ([today isEqual:day]) {
            self.today = [NSIndexPath indexPathForRow:0 inSection:idx];
        }
    }];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WorkshopDay *wsDay = self.objects[indexPath.section];
    NSDate *time = wsDay.distinctHours[indexPath.row];
//    NSArray *array = [self.workshops objectForKey:time.description];
    
//    return (array.count*kTableViewCellHeight + 20);
    
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    WorkshopDay *wsDay = self.objects[section];
    return wsDay.distinctHours.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    //init cell
    SAFMyAgendaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SAFMyAgendaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //data
    WorkshopDay *wsDay = self.objects[indexPath.section];
    NSDate *time = wsDay.distinctHours[indexPath.row];
    NSArray *array = @[];
    //[self.workshops objectForKey:time.description];
    
    [cell clearRows];

    //hour label    
    NSString *interval = [_cellDateFormatter stringFromDate:time];
    interval = [interval stringByAppendingFormat:@"\n-\n%@",[_cellDateFormatter stringFromDate:[time dateByAddingTimeInterval:3000]]];
    [cell configureTimeText:interval];
    
    //add details
    [array enumerateObjectsUsingBlock:^(WorkshopObject *obj, NSUInteger idx, BOOL *stop) {
        ArtistObject *artist = [ArtistObject artistForId:obj.instructor];
        NSString *location = [obj location];
        NSString *difficulty = [WorkshopObject stringForDifficulty:[obj.difficulty intValue]];
        UIButton *btn =[cell configureRows:idx artist:artist.name workshop:obj.name level:difficulty room:location];
        btn.tag = [obj.uID intValue];
        [btn addTarget:self action:@selector(didPushButton:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
    return cell;
}

-(void)didPushButton:(UIButton *)sender {
    
    SAFWorkshopDetailsViewController *detail = [[SAFWorkshopDetailsViewController alloc] init];
    detail.item = [WorkshopObject workshopForUID:[NSNumber numberWithInteger:sender.tag]];
    [self.navigationController pushViewController:detail animated:YES];
}


#pragma mark - Flip action related
-(void)saveItemAtIndex:(int)index {
    SettingOption *workshopOption = [SettingsManager sharedInstance].workshopsFilter;
    if (workshopOption.possibleValues.count >= index) {
        id obj = [workshopOption.possibleValues objectAtIndex:index];
        workshopOption.selectedValues = @[obj];
        [workshopOption save];
    }
}

@end
