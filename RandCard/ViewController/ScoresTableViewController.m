//
//  ScoresTableViewController.m
//  RandCard
//
//  Created by Max Koryakin on 04.05.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import "ScoresTableViewController.h"
#import "PlayerData.h"

@interface ScoresTableViewController () <UITableViewDelegate, UITableViewDataSource>

@end

NSArray *scoreInfo;
NSArray *playerInfo;
PlayerData *Player;

@implementation ScoresTableViewController
@synthesize tableView,playerName,playerGames,playerWinGames,playerLoseGames,playerGamesCount,playerWinGamesCount,playerLoseGamesCount;

- (void)viewDidLoad {
    [super viewDidLoad];
    Player = [[PlayerData alloc] init];
    [self setTable];
}

-(void) viewWillAppear:(BOOL)animated {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) setTable {
    CGRect rect = CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height);
    tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    tableView.delegate = self;
    tableView.dataSource = self;

    scoreInfo = [Player getScoreData];
    if([Player getPlayers].count !=0){
        playerInfo = [Player getPlayers];
        NSManagedObject *player = [playerInfo objectAtIndex:0];
        playerName.text = [player valueForKey:@"name"];
        playerGamesCount.text = [NSString stringWithFormat:@"%@",[player valueForKey:@"gamesAmount"] ];
        playerWinGamesCount.text = [NSString stringWithFormat:@"%@",[player valueForKey:@"win"] ];
        playerLoseGamesCount.text = [NSString stringWithFormat:@"%@",[player valueForKey:@"lose"] ];
    }
    
    [tableView reloadData];
    [self.view addSubview:tableView];
    
}

#pragma mark - Table view data source

-(IBAction)cancel:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    NSLog(@"%i",scoreInfo.count);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    if((indexPath.row+1<=scoreInfo.count)){
        NSManagedObject *score = [scoreInfo objectAtIndex:indexPath.row];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
        NSDate *gameDate =[score valueForKey:@"date"];
        NSString *date = [dateFormatter stringFromDate:gameDate];
        cell.textLabel.text = [NSString stringWithFormat:@"%@",date];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ / %@", [score valueForKey:@"playerScore"],[score valueForKey:@"opponentScore"]];
        if([[score valueForKey:@"playerScore"] integerValue]>[[score valueForKey:@"opponentScore"] integerValue]){
            cell.backgroundColor=[UIColor greenColor];
        }
        else{
            cell.backgroundColor = [UIColor redColor];
        }
    }
    else {
        cell.textLabel.text = @"";
        cell.detailTextLabel.text = @"";
    }
    
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
