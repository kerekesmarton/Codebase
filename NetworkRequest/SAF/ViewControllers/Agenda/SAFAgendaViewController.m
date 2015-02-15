//
//  SAGAgendaViewController.m
//  NetworkRequest
//
//  Created by Jozsef-Marton Kerekes on 7/29/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFAgendaViewController.h"
#import "SAFDefines.h"
#import "SAFAgendaTableViewCell.h"

@implementation SAFAgendaViewController {
    NSInteger expandedSection;
}

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        //
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    expandedSection = 0;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return section == expandedSection? [super tableView:tableView numberOfRowsInSection:section] : 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSDate *time = [self.sortedDays objectAtIndex:section];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
    button.tag = section;
    [button addTarget:self action:@selector(animateTable:) forControlEvents:UIControlEventTouchUpInside];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    [formatter setDateFormat:@"EEEE"];
    
    UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
    [day setTextColor:[UIColor orangeColor]];
    [day setFont:[UIFont fontWithName:@"edo" size:25]];
    [day setText:[formatter stringFromDate:time]];
    day.textAlignment = NSTextAlignmentCenter;
    day.backgroundColor = [UIColor clearColor];
    
    [formatter setDateFormat:@"d MMMM"];
    UILabel *date = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, self.view.frame.size.width, 30)];
    [date setTextColor:[UIColor whiteColor]];
    [date setFont:[UIFont fontWithName:@"edo" size:20]];
    date.backgroundColor = [UIColor clearColor];
    date.textAlignment = NSTextAlignmentCenter;
    [date setText:[formatter stringFromDate:time]];
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, 80);
    [gradientLayer setMasksToBounds:YES];
    [gradientLayer setColors:[NSArray arrayWithObjects:(id)[[UIColor colorWithHex:0x2d2d2d] CGColor],(id)[[UIColor colorWithHex:0x232323] CGColor], nil]];
    [button.layer insertSublayer:gradientLayer atIndex:0];
    
    [button addSubview:day];
    [button addSubview:date];
    
    return button;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDate *day = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *objects = [self.items objectForKey:day];
    AgendaObject *object = [objects objectAtIndex:indexPath.row];
    
    NSString *infoString = [NSString stringWithFormat:@"%@\n%@",object.name,object.location];
    if (object.details != nil) {
        infoString = [infoString stringByAppendingFormat:@"\n%@",object.details];
    }
    
    CGSize constraint = CGSizeMake([UIDevice isiPad]?658:210, 999);
    CGSize size = [infoString sizeWithFont:[UIFont fontWithName:myriadFontB size:16] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
    
    return MAX(size.height*1.2 + 10, 80);
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"H . mm"];
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    SAFAgendaTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[SAFAgendaTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDate *day = [self.sortedDays objectAtIndex:indexPath.section];
    NSArray *objects = [self.items objectForKey:day];
    AgendaObject *object = [objects objectAtIndex:indexPath.row];
    
    NSString *infoString = [NSString stringWithFormat:@"%@\n%@",object.name,object.location];
    
    if (object.details != nil) {
        infoString = [infoString stringByAppendingFormat:@"\n%@",object.details];
    }
    
    NSString *interval = [formatter stringFromDate:object.time];
    if (object.endTime != NULL) {
        interval = [interval stringByAppendingFormat:@"\n-\n%@",[formatter stringFromDate:object.endTime]];
    }
    
    [cell setInfo:infoString andDate:interval];    
    return cell;
}

-(void)animateTable:(id)sender {
    
    if (expandedSection == [(UIButton *)sender tag]) {
        expandedSection = 1000;
        
        [self.tableView beginUpdates];
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:[(UIButton *)sender tag]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView endUpdates];
        
    } else {
        
        [self.tableView beginUpdates];
        
        if (expandedSection !=1000) {
            [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:expandedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
        }
        expandedSection = [(UIButton *)sender tag];
        
        [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:expandedSection] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        [self.tableView endUpdates];
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:[(UIButton*)sender tag]];
        [self.tableView scrollToRowAtIndexPath:ip atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
}

@end
