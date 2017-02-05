//
//  SAFShopViewController.m
//  NetworkRequest
//
//  Created by Marton Kerekes on 27/01/2017.
//  Copyright © 2017 Jozsef-Marton Kerekes. All rights reserved.
//

#import "SAFShopSelectViewController.h"
#import "SAFShopSelectTableViewCell.h"
#import "SAFShopCalculatorViewController.h"

@interface SAFShopSelectViewController ()
@property (strong, nonatomic) IBOutlet UILabel *headerLabel;

@end

@implementation SAFShopSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *bgColor = [UIColor colorWithHex:0x1b1a19];
    self.view.backgroundColor = bgColor;
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
    SAFShopSelectTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Available Tickets";
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"ShopStoryboard" bundle:nil];
    SAFShopCalculatorViewController *viewController = [sb instantiateViewControllerWithIdentifier:@"SAFShopCalculatorViewController"];
    [self.navigationController pushViewController:viewController animated:YES];
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

