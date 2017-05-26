//
//  Data.h
//  RandCard
//
//  Created by Max Koryakin on 25.05.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface PlayerData : UIView

-(NSManagedObjectContext *) managedObjectContext;
-(void) setPlayer:(UIView *) mainView; // set old or new player
-(void) savePlayer; // save new player
-(NSArray *) getPlayers; //list of the players
-(void) save: (int) playerScore : (int) opponentScore; // save game result
-(NSArray *) getPrizeData; //get prize in core data
-(NSArray *) getScoreData; //get score in core data

@end
