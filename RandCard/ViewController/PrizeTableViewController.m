//
//  PrizeTableViewController.m
//  RandCard
//
//  Created by Max Koryakin on 10.05.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import "PrizeTableViewController.h"

#import "PlayerData.h"

@interface PrizeTableViewController ()

@end

NSArray *prizes;

@implementation PrizeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PlayerData *Player = [[PlayerData alloc] init];
    prizes = [Player getPrizeData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [[prizes objectAtIndex:1] objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[[prizes objectAtIndex:0] objectAtIndex:indexPath.row]];
    // Configure the cell...
    
    return cell;
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
