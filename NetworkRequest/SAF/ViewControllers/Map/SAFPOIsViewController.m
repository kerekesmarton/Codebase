//
//  SAFPOIsViewController.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 11/14/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFPOIsViewController.h"
#import <SKMaps/SKSearchResult.h>
#import <SKMaps/SKReverseGeocoderService.h>
#import "SAFDefines.h"
#import "SAFPOIsListCell.h"
#import "MapViewController+FloatingControl.h"
#import "SAFNavigationBar.h"
#import "SKSearchResult+SAF.h"

typedef enum SAFVenues{
    
    SAFVenueMain,
    SAFVenueNH,
    SAFVenueBoavista,
    SAFVenueCheckInn,
    SAFVenuesCount
    
}SAFVenues;

@interface SAFPOIsViewController () {
    
    NSMutableArray *dataSource;
}

@end

@implementation SAFPOIsViewController

+(UINavigationController *)modalNavigationController {
    
    SAFPOIsViewController *pois = [[SAFPOIsViewController alloc] initWithStyle:UITableViewStylePlain];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithNavigationBarClass:[SAFNavigationBar class] toolbarClass:[UIToolbar class]];
    nav.navigationBarHidden = NO;
    nav.toolbarHidden = YES;
    nav.navigationBar.barStyle = UIBarStyleBlackOpaque;
    nav.toolbar.barStyle = UIBarStyleBlackOpaque;
    nav.navigationBar.translucent = NO;
    nav.viewControllers = @[pois];
    
    return nav;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        [self populateData];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    //    self.tableView.delegate = self;
    //    self.tableView.dataSource = self;
    self.tableView.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    self.tableView.frame = self.view.frame;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Dismiss" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populateData {
    
    dataSource = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < SAFVenuesCount; i++) {
        SKSearchResult *object = nil;
        switch (i) {
            case SAFVenueMain:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodeLocation:CLLocationCoordinate2DMake(45.748441, 21.239689)];
                object.name = @"SAF Main Venue: Restaurant Universitar Politehnica";
                object.oneLineAddress = @"Address:1 Alexandru Vaida – Voievod str\nZip:300553 Code\nPhone:0040732672572";
                break;
            case SAFVenueNH:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodeLocation:CLLocationCoordinate2DMake(45.74827981813517, 21.226914967795217)];
                object.name = @"Hotel NH";
                object.oneLineAddress = @"Address:1A, Pestalozzi str.\nZip Code:300115\nPhone:0040732672572, ";
                break;
            case SAFVenueBoavista:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodeLocation:CLLocationCoordinate2DMake(45.746337, 21.240598)];
                object.name = @"Hotel Boavista" ;
                object.oneLineAddress = @"Address:Adress: 7A, Ripensia str.\nZip Code:300575\nPhone:0040732672572";
                break;
            case SAFVenueCheckInn:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodeLocation:CLLocationCoordinate2DMake(45.75053328186938, 21.24548258042603)];
                object.name = @"Hotel Check Inn";
                object.oneLineAddress = @"Address:11 - 13, Miorita str.\nZip:300553 Code\nPhone:0040732672572";
                break;
            default:
                break;                
        }
        if (object) {
            [dataSource addObject:object];
        }
        
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 120;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    SAFPOIsListCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[SAFPOIsListCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    SKSearchResult *object = [dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = object.name;
    cell.detailTextLabel.text = object.oneLineAddress;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKSearchResult *blockSearchObject = [dataSource objectAtIndex:indexPath.row];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
    
        [NSNotificationCenterInstance postNotification:[NSNotification notificationWithName:GoToPoiNotification object:blockSearchObject]];
    }];
}

-(void) dismiss {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{ }];
}

@end
