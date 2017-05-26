//
//  ViewController.h
//  RandCard
//
//  Created by Max Koryakin on 03.03.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Cards.h"
#import <CoreData/CoreData.h>
#import "ScoresTableViewController.h"
#import "PlayerData.h"


@interface ViewController : UIViewController

{
    int count;
    int point;
    int pointOpp;
    UILabel *lab;
}

@property (retain, nonatomic) IBOutlet UILabel *pointLab;
@property (retain, nonatomic) IBOutlet UILabel *pointOppLab;
@property (retain, nonatomic) IBOutlet UILabel *score;
@property (retain, nonatomic) IBOutlet UILabel *opponent;
@property (retain, nonatomic) IBOutlet UILabel *card1;
@property (retain, nonatomic) IBOutlet UILabel *card2;
@property (retain, nonatomic) IBOutlet UILabel *card3;
@property (retain, nonatomic) IBOutlet UILabel *card4;
@property (retain, nonatomic) IBOutlet UILabel *card5;
@property (retain, nonatomic) IBOutlet UILabel *card6;
@property (retain, nonatomic) IBOutlet UILabel *card7;
@property (retain, nonatomic) IBOutlet UILabel *card8;
@property (retain, nonatomic) IBOutlet UIButton *button;
@property (retain, nonatomic) IBOutlet UIButton *stop;

-(IBAction)cancel:(id)sender;
-(IBAction)Click:(id)sender;
-(IBAction)StopGame:(id)sender;
-(void)showEndGame;
-(void) showAlert: (NSString *)string;
-(void)restart;

@end

