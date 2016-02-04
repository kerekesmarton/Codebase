//
//  SAFPOIsViewController.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 11/14/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFPOIsViewController.h"
#import "SAFDefines.h"
#import "SAFPOIsListCell.h"
#import "SAFNavigationBar.h"
#import "POIAnnotation.h"

typedef enum SAFVenues{
    
    SAFVenueMain,
    SAFVenueNH,
    SAFVenueBoavista,
    SAFVenueCheckInn,
    SAFVenuesCount
    
}SAFVenues;

@interface SAFPOIsViewController ()

@property(nonatomic,strong) NSMutableArray *dataSource; ///<
@property(nonatomic,strong) CLGeocoder *geocoder;       ///<
@end

@implementation SAFPOIsViewController

+(UINavigationController *)modalNavigationControllerWithCompletion:(DidPickAnnotation) completion
{
    
    SAFPOIsViewController *pois = [[SAFPOIsViewController alloc] initWithStyle:UITableViewStylePlain];
    pois.completion = completion;
    
    UINavigationController *navController = [[UINavigationController alloc] initWithNavigationBarClass:[SAFNavigationBar class] toolbarClass:[UIToolbar class]];
    navController.navigationBarHidden = NO;
    navController.toolbarHidden = YES;
    navController.navigationBar.barStyle = UIBarStyleBlackOpaque;
    navController.toolbar.barStyle = UIBarStyleBlackOpaque;
    navController.navigationBar.translucent = NO;
    navController.viewControllers = @[pois];
    
    if ([navController.navigationBar respondsToSelector:@selector(barTintColor)]) {
        navController.navigationBar.barTintColor = [UIColor blackColor];
        navController.navigationBar.tintColor = [UIColor whiteColor];
        [navController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        navController.navigationBar.translucent = NO;
    }
    
    return navController;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        self.geocoder = [[CLGeocoder alloc] init];
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

- (void)populateData {
    
    self.dataSource = [[NSMutableArray alloc] init];
    
    for (SAFVenues i = 0; i < SAFVenuesCount; i++) {
        switch (i) {
            case SAFVenueMain:
            {
                POIAnnotation *annotation = [POIAnnotation annotationWithLocation:CLLocationCoordinate2DMake(45.748441, 21.239689)];
                annotation.primaryDetails = @"SAF Main Venue: Restaurant Universitar Politehnica";
                annotation.secondaryDetails = @"Address:1 Alexandru Vaida – Voievod str\nZip:300553 Code\nPhone:0040732672572";
                [_dataSource addObject:annotation];
            }
                break;
            case SAFVenueNH:
            {
                POIAnnotation *annotation = [POIAnnotation annotationWithLocation:CLLocationCoordinate2DMake(45.74827981813517, 21.226914967795217)];
                annotation.primaryDetails = @"Hotel NH";
                annotation.secondaryDetails = @"Address:1A, Pestalozzi str.\nZip Code:300115\nPhone:0040732672572, ";
                [_dataSource addObject:annotation];
            }
                break;
            case SAFVenueBoavista:
            {
                POIAnnotation *annotation = [POIAnnotation annotationWithLocation:CLLocationCoordinate2DMake(45.746337, 21.240598)];
                annotation.primaryDetails = @"Hotel Boavista" ;
                annotation.secondaryDetails = @"Address:Adress: 7A, Ripensia str.\nZip Code:300575\nPhone:0040732672572";
                [_dataSource addObject:annotation];
            }
                break;
            case SAFVenueCheckInn:
            {
                POIAnnotation *annotation = [POIAnnotation annotationWithLocation:CLLocationCoordinate2DMake(45.75053328186938, 21.24548258042603)];
                annotation.primaryDetails = @"Hotel Check Inn";
                annotation.secondaryDetails = @"Address:11 - 13, Miorita str.\nZip:300553 Code\nPhone:0040732672572";
                [_dataSource addObject:annotation];
            }
                break;
            default:
                break;                
        }
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
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
    
    POIAnnotation *object = [_dataSource objectAtIndex:indexPath.row];
    cell.textLabel.text = object.primaryDetails;
    cell.detailTextLabel.text = object.secondaryDetails;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    POIAnnotation *blockSearchObject = [_dataSource objectAtIndex:indexPath.row];
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{
    
        self.completion(blockSearchObject);
    }];
}

-(void) dismiss {
    
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{ }];
}

@end
