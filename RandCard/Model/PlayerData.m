//
//  Player.m
//  RandCard
//
//  Created by Max Koryakin on 25.05.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import "PlayerData.h"

UITextField *textField; // name of the new player
UIView *createView; // view for create new player 
int gamesCount; //count of all played games
int zeroLose; // count of game played with 0 player point
int zeroWin; // count of game played with 0 opponent point
int winCount; // count of win games
int loseCount; //count of lose games
int onlyWins; //count of win games in a row

@implementation PlayerData

-(NSManagedObjectContext *) managedObjectContext {
    NSManagedObjectContext *context =nil;
    id delegate = [[UIApplication sharedApplication] delegate];
    if([delegate performSelector:@selector(managedObjectContext)]){
        context = [delegate managedObjectContext];
    }
    return context;
}

-(NSArray *) getPlayers{
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *requestPlayer = [[NSFetchRequest alloc] initWithEntityName:@"Player"];
    NSArray *players = [context executeFetchRequest:requestPlayer error:nil];
    NSLog(@"%@",players);
    NSLog(@"1");
    return players;
}

-(void) setPlayer: (UIView *) mainView {
    [self getPlayers];
    NSLog(@"2");
    NSLog(@"%@",[self getPlayers]);
    if([self getPlayers].count==0){
        CGRect rect = CGRectMake(0, 0, mainView.bounds.size.width, 135);
        createView = [[UIView alloc] initWithFrame:rect];
        [createView setBackgroundColor:[UIColor grayColor]];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(createView.bounds.size.width/2-150, 10, 300, 20)];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15];
        label.text = @"Добро пожаловать! Введите ваше имя";
        label.textColor = [UIColor blackColor];
        [createView addSubview:label];
        
        textField = [[UITextField alloc] initWithFrame:CGRectMake(createView.bounds.size.width/2-100, 35, 200, 30)];
        textField.textColor = [UIColor blackColor];
        textField.placeholder = @"Введите ваше имя";
        textField.borderStyle = UITextBorderStyleRoundedRect;
        
        UIButton *buttonName = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        buttonName.frame = CGRectMake(createView.bounds.size.width/2-50, 85, 100, 40);
        buttonName.backgroundColor = [UIColor redColor];
        [buttonName setTitle:@"Начать" forState:UIControlStateNormal];
        [buttonName addTarget:self action:@selector(savePlayer) forControlEvents:UIControlEventTouchDown];
        [createView addSubview:buttonName];
        
        [createView addSubview:textField];
        [mainView addSubview:createView];
    }
    else{
        NSManagedObject *player = [[self getPlayers] objectAtIndex:0];
        gamesCount = [[player valueForKey:@"gamesAmount"] integerValue];
        loseCount = [[player valueForKey:@"lose"] integerValue];
        winCount = [[player valueForKey:@"win"] integerValue];
        onlyWins = [[player valueForKey:@"onlyWins"] integerValue];
    }
}

-(void) savePlayer {
    NSLog(@"%@", textField.text);
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *player = [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:context];
    NSManagedObject *prize = [NSEntityDescription insertNewObjectForEntityForName:@"Trophy" inManagedObjectContext:context];
    [player setValue:textField.text forKey:@"name"];
    [player setValue:[NSNumber numberWithInt:0] forKey:@"gamesAmount"];
    [player setValue:[NSNumber numberWithInt:0] forKey:@"lose"];
    [player setValue:[NSNumber numberWithInt:0] forKey:@"win"];
    [player setValue:[NSNumber numberWithInt:0] forKey:@"onlyWins"];
    [prize setValue:[NSNumber numberWithInt:0] forKey:@"twentyOne"];
    [prize setValue:[NSNumber numberWithInt:0] forKey:@"winInARow"];
    [prize setValue:[NSNumber numberWithInt:0] forKey:@"zeroLose"];
    [prize setValue: [NSNumber numberWithInt:0] forKey:@"zeroWin"];
    createView.hidden = YES;
    
    [context save:nil];
}

-(void) save: (int) playerScore : (int) opponentScore {
    gamesCount++;
    NSManagedObjectContext *context = [self managedObjectContext];
    NSManagedObject *newScore = [NSEntityDescription insertNewObjectForEntityForName:@"Score" inManagedObjectContext:context];
    NSFetchRequest *countGamesRequest =[[NSFetchRequest alloc] initWithEntityName:@"Player"];
    NSArray *ar = [context executeFetchRequest:countGamesRequest error:nil];
    NSManagedObject *countGames = [ar objectAtIndex:0];
    NSFetchRequest *prizeRequest = [[NSFetchRequest alloc] initWithEntityName:@"Trophy"];
    NSArray *prize = [context executeFetchRequest:prizeRequest error:nil];
    NSManagedObject *prizeObject = [prize objectAtIndex:0];
    zeroLose = [[prizeObject valueForKey:@"zeroLose"] integerValue];
    zeroWin = [[prizeObject valueForKey:@"zeroWin"] integerValue];
    if(playerScore>opponentScore){
        winCount++;
        onlyWins++;
        if(opponentScore ==0){
            zeroWin++;
            [prizeObject setValue:[NSNumber numberWithInt:zeroWin] forKey:@"zeroWin"];
        }
    }
    else{
        loseCount++;
        onlyWins = 0;
        if(playerScore ==0){
            zeroLose++;
            [prizeObject setValue:[NSNumber numberWithInt:zeroLose] forKey:@"zeroLose"];
        }
    }
    [countGames setValue:[NSNumber numberWithInt:gamesCount] forKey:@"gamesAmount"];
    [countGames setValue:[NSNumber numberWithInt:loseCount] forKey:@"lose"];
    [countGames setValue:[NSNumber numberWithInt:winCount] forKey:@"win"];
    [countGames setValue:[NSNumber numberWithInt:onlyWins] forKey:@"onlyWins"];
    if([[countGames valueForKey:@"onlyWins"] integerValue]>[[prizeObject valueForKey:@"winInARow"] integerValue]){
        [prizeObject setValue:[NSNumber numberWithInt:[[countGames valueForKey:@"onlyWins"] integerValue]] forKey:@"winInARow"];
    }
    [newScore setValue:[NSDate date] forKey:@"date"];
    [newScore setValue:[NSString stringWithFormat:@"%i",playerScore] forKey:@"playerScore"];
    [newScore setValue:[NSString stringWithFormat:@"%i",opponentScore]  forKey:@"opponentScore"];
    
    [context save:nil];
}


-(NSArray *) getPrizeData {
    NSArray *key = [NSArray arrayWithObjects: @"Сыграно игр",@"Выиграно раундов подряд",@"Набрано '21' раз",@"Проигрыш в сухую",@"Победа в сухую",nil];
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *Trophy = [NSFetchRequest fetchRequestWithEntityName:@"Trophy"];
    NSFetchRequest *Player = [NSFetchRequest fetchRequestWithEntityName:@"Player"];
    NSArray *player = [context executeFetchRequest:Player error:nil];
    NSArray *prize = [context executeFetchRequest:Trophy error:nil];
    if(player.count!=0 && prize.count!=0){
        NSManagedObject *games = [player objectAtIndex:0];
        NSManagedObject *objectPrize = [prize objectAtIndex:0];
        NSArray *tableLabel = [NSArray arrayWithObjects:[games valueForKey:@"gamesAmount"],[objectPrize valueForKey:@"winInARow"],[objectPrize valueForKey:@"twentyOne"],[objectPrize valueForKey:@"zeroLose"],[objectPrize valueForKey:@"zeroWin"], nil];
        NSArray *arr = [NSArray arrayWithObjects:tableLabel,key, nil];
        return arr;
    }
    else{
        NSArray *tableLabel = [NSArray arrayWithObjects:@"0",@"0",@"0",@"0",@"0",nil];
        NSArray *arr = [NSArray arrayWithObjects:tableLabel,key, nil];
        return arr;
    }
}
-(NSArray *) getScoreData {
    NSManagedObjectContext *context = [self managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Score"];
    request.fetchLimit = 10;
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    NSArray *sorts = @[sort];
    request.sortDescriptors = sorts;
    NSArray *array = [context executeFetchRequest:request error:nil];
    return array;
}

@end
