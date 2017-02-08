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
#import "SavedWorkshopsForDay.h"

@interface SAFMyAgendaViewController ()

@property(nonatomic) NSDateFormatter *cellDateFormatter;
@property(nonatomic) NSDate *day;
@property(nonatomic) NSDate *nextDay;
@property(nonatomic) NSArray *allDays;
@property(nonatomic) SavedWorkshopsForDay *wsDay;
@property(nonatomic) NSDateFormatter *headerDateFormatter;


@end

@implementation SAFMyAgendaViewController

- (instancetype)initWithDay:(NSDate *)day
{
    self = [super initWithDay:day];
    if (self) {

        _day = day;

        [self configureDay];
        [self configureAppearance];
    }
    return self;
}

- (void)configureDay {
    self.allDays = [WorkshopObject distinctWorkshopDays];
    if (!self.day) {
        self.day = [self.allDays firstObject];
    }
}

- (void)configureAppearance {
    [[UITabBar appearance] setBarTintColor:[UIColor blackColor]];
    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:futuraCondendsedBold size:12], NSFontAttributeName,
      nil] forState:UIControlStateSelected];

    [[UITabBarItem appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor redColor], NSForegroundColorAttributeName,
      [UIFont fontWithName:futuraCondendsedBold size:12], NSFontAttributeName,
      nil] forState:UIControlStateNormal];

    self.headerDateFormatter = [NSDateFormatter new];
    _headerDateFormatter.timeStyle = NSDateFormatterNoStyle;
    _headerDateFormatter.dateFormat = @"EEEE";

    NSUInteger index = [self.allDays indexOfObject:self.day];
    if (self.allDays.count > index+1) {
        self.nextDay = self.allDays[index+1];
        NSString *nextDayTitle = [_headerDateFormatter stringFromDate:self.nextDay];
        NSString *todayTitle = [_headerDateFormatter stringFromDate:self.day];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:nextDayTitle style:UIBarButtonItemStyleDone target:self action:@selector(goToNextDay)];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:todayTitle style:UIBarButtonItemStyleDone target:nil action:nil];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.

    self.cellDateFormatter = [[NSDateFormatter alloc] init];
    [_cellDateFormatter setDateFormat:@"HH : mm"];
    [_cellDateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"Europe/Bucharest"]];
}

- (void)refresh {
    
    NSArray *days = [[WorkshopObject distinctWorkshopDays] mutableCopy];
    [days enumerateObjectsUsingBlock:^(NSDate *day, NSUInteger idx, BOOL * _Nonnull stop) {
        [[SettingsManager sharedInstance].selectedDay addToSelectedValues:day];
        NSArray *workshops = [WorkshopObject fetchWorkshops];
        self.wsDay = [SavedWorkshopsForDay new];
        self.wsDay.workshops = [WorkshopObject favoritedWorkshopForArray:workshops day:day];
        self.wsDay.day = day;
        self.wsDay.hours = [_wsDay.workshops.allKeys sortedArrayUsingSelector:@selector(compare:)];
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *time = self.wsDay.hours[indexPath.row];
    NSArray *array = self.wsDay.workshops[time];
    
    return (array.count*kTableViewCellHeight + 20);
    
    return 44;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.wsDay.hours.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    //init cell
    SAFMyAgendaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SAFMyAgendaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //data
    NSDate *time = self.wsDay.hours[indexPath.row];
    NSArray *array = self.wsDay.workshops[time];
    
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

- (void)goToNextDay {
    SAFMyAgendaViewController *nextVC = [[SAFMyAgendaViewController alloc] initWithDay:self.nextDay];
    [self.navigationController pushViewController:nextVC animated:YES];
}

@end
