//
//  ScoresTableViewController.h
//  RandCard
//
//  Created by Max Koryakin on 04.05.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ScoresTableViewController : UIViewController

@property (strong,nonatomic) IBOutlet UILabel *playerName;
@property (strong,nonatomic) IBOutlet UILabel *playerGames;
@property (strong,nonatomic) IBOutlet UILabel *playerGamesCount;
@property (strong,nonatomic) IBOutlet UILabel *playerWinGames;
@property (strong,nonatomic) IBOutlet UILabel *playerWinGamesCount;
@property (strong,nonatomic) IBOutlet UILabel *playerLoseGames;
@property (strong,nonatomic) IBOutlet UILabel *playerLoseGamesCount;

@property (strong,nonatomic) UITableView *tableView;

-(void) setTable;
-(IBAction)cancel:(id)sender;

@end
