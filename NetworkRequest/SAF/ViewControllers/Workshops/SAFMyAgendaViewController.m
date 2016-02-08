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

@interface SAFMyAgendaViewController ()

@property (nonatomic, strong) NSDictionary *workshops;
@property (nonatomic, strong) NSArray *distinctHours;

@end

@implementation SAFMyAgendaViewController {
    
    NSDateFormatter *_cellDateFormatter;
}

@synthesize workshops,distinctHours;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.workshops = [WorkshopObject fetchWorkshopsForDistinctHours:YES];
    self.distinctHours = [WorkshopObject distinctWorkshopHours:YES];
    
    [self configureNavigation];
    
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDate *time = [self.distinctHours objectAtIndex:indexPath.row];
    NSArray *array = [self.workshops objectForKey:time.description];
    
    return (array.count*kTableViewCellHeight + 20);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.distinctHours.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    if (!_cellDateFormatter) {
        _cellDateFormatter = [[NSDateFormatter alloc] init];
        [_cellDateFormatter setDateFormat:@"HH : mm"];
    }
    //init cell
    SAFMyAgendaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SAFMyAgendaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    //data
    NSDate *time = [self.distinctHours objectAtIndex:indexPath.row];
    NSArray *array = [self.workshops objectForKey:time.description];
    
    [cell clearRows];
    
    //hour label    
    NSDate *wsTime = [NSDate dateWithTimeInterval:-7200 sinceDate:time];
    NSString *interval = [_cellDateFormatter stringFromDate:wsTime];
    interval = [interval stringByAppendingFormat:@"\n-\n%@",[_cellDateFormatter stringFromDate:[wsTime dateByAddingTimeInterval:3000]]];
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

-(void)configureNavigation {
    
    //decide if there is a day before this.
    
    
    if ([self.day compare: [[SettingsManager sharedInstance].selectedDay.possibleValues firstObject]]==NSOrderedSame) {
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sunday" style:UIBarButtonItemStylePlain target:self action:@selector(nextDay:)];
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(flipAndPop)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Saturday" style:UIBarButtonItemStylePlain target:self action:@selector(previousDay:)];
    }
    
}

-(void)previousDay:(UIBarButtonItem *)sender {
    
    NSArray *days = [WorkshopObject distinctWorkshopDays];
    
    if (days.count) {
        NSDate *firstDay = [days firstObject];
        [[SettingsManager sharedInstance].selectedDay addToSelectedValues:firstDay];
    }
    [self flip];
    
}

-(void)nextDay:(UIBarButtonItem *)sender {
    
    NSArray *days = [WorkshopObject distinctWorkshopDays];
    
    if (days.count) {
        NSDate *lastDay = [days lastObject];
        [[SettingsManager sharedInstance].selectedDay addToSelectedValues:lastDay];
        
        SAFMyAgendaViewController *next = [[SAFMyAgendaViewController alloc] init];
        next.day = lastDay;
        next.modalDelegate = self;
        UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[SAFNavigationBar class] toolbarClass:[UIToolbar class]];
        navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
        navController.toolbar.barStyle = UIBarStyleBlackOpaque;
        navController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        navController.viewControllers = @[next];
        
        if ([navController.navigationBar respondsToSelector:@selector(barTintColor)]) {
            navController.navigationBar.barTintColor = [UIColor blackColor];
            navController.navigationBar.tintColor = [UIColor whiteColor];
            [navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
            navController.navigationBar.translucent = NO;
        }
        
        [self.navigationController presentViewController:navController animated:YES completion:^{
            
        }];
    }
}

-(void)flipAndPop {
    if (self.modalDelegate && [self.modalDelegate respondsToSelector:@selector(popModalWithCompletion:)]) {
        [self.modalDelegate popModalWithCompletion:^{
            [self.modalDelegate.navigationController popViewControllerAnimated:YES];
        }];
    }
}

-(void)flip {
    if (self.modalDelegate && [self.modalDelegate respondsToSelector:@selector(popModalWithCompletion:)]) {
        [self.modalDelegate popModalWithCompletion:^{
            //
        }];
    }
}

-(void)popModalWithCompletion:(void (^)(void))block {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        block();
    }];
}

@end
