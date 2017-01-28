//
//  SAFShopViewController.m
//  NetworkRequest
//
//  Created by Marton Kerekes on 27/01/2017.
//  Copyright © 2017 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFShopViewController.h"
#import "SAFShopTableViewCell.h"

@interface SAFShopViewController ()
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation SAFShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *bgColor = [UIColor colorWithHex:0x1b1a19];
    self.view.backgroundColor = bgColor;
    [self.tableView registerNib:[UINib nibWithNibName:@"SAFShopTableViewCell" bundle:nil] forCellReuseIdentifier:@"ShopCell"];
    
    self.headerLabel.backgroundColor = bgColor;
    self.tableView.tableHeaderView = self.headerLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ShopCell";
    SAFShopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
//    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
//    
//    // Pass the selected object to the new view controller.
//    
//    // Push the view controller.
//    [self.navigationController pushViewController:detailViewController animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

