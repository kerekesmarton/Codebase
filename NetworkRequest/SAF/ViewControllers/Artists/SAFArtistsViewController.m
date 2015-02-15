//
//  SAFArtistsViewController.m
//  NetworkRequest
//
//  Created by Kerekes Jozsef-Marton on 7/22/13.
//  Copyright (c) 2013 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFArtistsViewController.h"
#import "ArtistsDataManager.h"
#import "ArtistObject.h"
#import "ArtistImageDataManager.h"
#import "SAFArtistsTableViewCell.h"
#import "SAFArtistDetailsViewController.h"

@interface SAFArtistsViewController ()

@end

#define kPlaceHolderImageWidth      80
#define kRowHeight                  80
@implementation SAFArtistsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHex:0x1b1a19];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
//    tabbar covers uitableview
    self.edgesForExtendedLayout = UIRectEdgeAll;
    self.tableView.contentInset = UIEdgeInsetsMake(0.0f, 0.0f, CGRectGetHeight(self.tabBarController.tabBar.frame), 0.0f);
}

- (void)refresh {
    self.items = [[ArtistObject fetchArtistsForCurrentSettingsType] sortedArrayUsingComparator:^NSComparisonResult(ArtistObject *obj1, ArtistObject *obj2) {
        return [obj1.id_num compare:obj2.id_num];
    }];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kRowHeight;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"CellIdentifier";
    
    SAFArtistsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[SAFArtistsTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    ArtistObject *artist = [self.items objectAtIndex:indexPath.row];
    
    if (artist.solo!= NULL) {
        artist = [ArtistObject artistForSolo:artist.solo];
    }
    [[ArtistImageDataManager sharedInstance] imageForString:artist.img completionBlock:^(NSData *imgData) {
        UIImage *img = [UIImage imageWithData:imgData];
        float widthRatio = img.size.width / kPlaceHolderImageWidth;
        float requiredHeight = img.size.height / widthRatio;
        img = [img scaleToSize:CGSizeMake(kPlaceHolderImageWidth, requiredHeight)];
        cell.imageView.image = img;
        [cell setNeedsLayout];
    } failureBlock:^(NSError *error) {
        cell.imageView.image = nil;
        [cell setNeedsLayout];
    }];
    
    
    cell.textLabel.text = artist.name;
    cell.detailTextLabel.text = artist.loc;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    SAFArtistDetailsViewController *detailViewController = [[SAFArtistDetailsViewController alloc] initWithNibName:NSStringFromClass([ArtistDetailViewController class]) bundle:nil];
    
    ArtistObject *artist = [self.items objectAtIndex:indexPath.row];
    if (artist.solo != NULL) {
        artist = [ArtistObject artistForSolo:artist.solo];
    }
    detailViewController.artist = artist;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
