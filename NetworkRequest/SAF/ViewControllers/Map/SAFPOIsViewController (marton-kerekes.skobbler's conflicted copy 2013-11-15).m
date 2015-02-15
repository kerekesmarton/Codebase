//
//  SAFPOIsViewController.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 11/14/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFPOIsViewController.h"
#import <SKMaps/SKReverseGeocoderService.h>
#import <SKMaps/SKMapSearchObject.h>
#import "SAFDefines.h"
#import "SAFPOIsListCell.h"
#import "MapViewController+FloatingControl.h"

@interface SAFPOIsViewController () {
    
    NSMutableArray *dataSource;
}

@end

@implementation SAFPOIsViewController

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
    
    UIBarButtonItem *cancelBtn = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem = cancelBtn;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)populateData {
    
    dataSource = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 5; i++) {
        SKMapSearchObject *object = nil;
        switch (i) {
            case 0:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodePosition:21.239689 withLatY:45.748441];
                object.searchObjectName = @"SAF Main Venue: Restaurant Universitar Politehnica";
                object.onelineAddress = @"Address:1 Alexandru Vaida – Voievod str\nZip:300553 Code\nPhone:0040732672572";
                break;
            case 1:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodePosition:21.226914967795217 withLatY:45.74827981813517];
                object.searchObjectName = @"Swiss House";
                object.onelineAddress = @"Address:1-3 A, Bd. Vasile Parvan str\nZip Code:300223\nPhone:0040732672572, ";
                break;
            case 2:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodePosition:21.240598 withLatY:45.746337];
                object.searchObjectName = @"Hotel Boavista" ;
                object.onelineAddress = @"Address:Adress: 7A, Ripensia str\nZip Code:300575\nPhone:0040732672572";
                break;
            case 3:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodePosition:21.232163 withLatY:45.739379];
                object.searchObjectName = @"Hotel Reghina";
                object.onelineAddress = @"Address: 91, Cozia str\nZip Code: 300580\nPhone:0040732672572 ";
                break;
            case 4:
                object = [[SKReverseGeocoderService sharedInstance] reverseGeocodePosition:21.24548258042603 withLatY:45.75053328186938];
                object.searchObjectName = @"Hotel Check Inn";
                object.onelineAddress = @"Address:11 - 13, Miorita str.  \nZip:300553 Code\nPhone:0040732672572";
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
    
    SKMapSearchObject *object = [dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = object.searchObjectName;
    cell.detailTextLabel.text = object.onelineAddress;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SKMapSearchObject *blockSearchObject = [dataSource objectAtIndex:indexPath.row];
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
        
        [NSNotificationCenterInstance postNotification:[NSNotification notificationWithName:GoToPoiNotification object:blockSearchObject]];
    }];
}

-(void)dismiss {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

@end
