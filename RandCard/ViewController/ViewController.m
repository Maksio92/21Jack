//
//  ViewController.m
//  RandCard
//
//  Created by Max Koryakin on 03.03.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIPopoverPresentationControllerDelegate>

@end

@implementation ViewController
int sum=0;
int roundCount = 1;
int point=0;
int pointOpp=0;
int count21;
NSString *win = @"Вы победили";
NSString *lose = @"Вы проиграли";
UIView *view1;
PlayerData *GamePlayer;


@synthesize score,card1,card2,card3,card4,card5,card6,card7,card8,button,opponent, stop, pointOppLab,pointLab;

- (void)viewDidLoad {
    [super viewDidLoad];
    GamePlayer = [[PlayerData alloc] init];
    [GamePlayer setPlayer:self.view];
    [opponent setText: @"0"];
    [score setText: @"0"];
    // Do any additional setup after loading the view, typically from a nib.
}

//Всплывающая подсказка о конце раунда
-(void) showAlert: (NSString *)string {
    if((point<3)&&(pointOpp<3)){
        NSString *round = [NSString stringWithFormat:@"Раунд № %i",roundCount];
    UIAlertController *newRound = [UIAlertController alertControllerWithTitle:round message:string preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *next = [UIAlertAction actionWithTitle:@"Следующий раунд" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        sum=0;
        count=0;
        [score setText:@"0"];
        [opponent setText:@"0"];
    }];
    [newRound addAction:next];
    [self presentViewController:newRound animated:YES completion:nil];
    [card1 setText:@""];
    [card2 setText:@""];
    [card3 setText:@""];
    [card4 setText:@""];
    [card5 setText:@""];
    [card6 setText:@""];
    [card7 setText:@""];
    [card8 setText:@""];
    button.enabled = true;
    stop.enabled = true;
        roundCount++;
    }
}
//Вспылвающая подсказка об окончании игры
-(void) showEndGame {
    if((point==3)||(pointOpp==3)){
        UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Партия окончена"
                                                                       message:[NSString stringWithFormat:@"Ваш счет %i - %i",point, pointOpp]
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"Закончить" style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction * action) {
                                                                  [GamePlayer save:point :pointOpp];
                                                                  [self dismissViewControllerAnimated:YES completion:nil];
                                                              }];
        UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Начать заново" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 [GamePlayer save:point :pointOpp];
                                                                 [self restart];
                                                             }];
        
        [alert addAction:defaultAction];
        [alert addAction:cancelAction];
        [self presentViewController:alert animated:YES completion:nil];
    }

}

-(IBAction)StopGame:(id)sender{
    button.enabled = false;
    stop.enabled = false;
    int opp =[Cards countScore:[Cards randomCard]]+[Cards countScore:[Cards randomCard]]+[Cards countScore:[Cards randomCard]];
    [opponent setText:[NSString stringWithFormat:@"%i",opp]];
    if([Cards end:[score.text integerValue] :opp]) {
        point++;
        [self showAlert:win];
    }
    else{
        pointOpp++;
        [self showAlert:lose];
    }
    [pointLab setText:[NSString stringWithFormat:@"%i -",point]];
    [pointOppLab setText:[NSString stringWithFormat:@"%i",pointOpp]];
    [self showEndGame];
}

-(void)restart {
    sum=0;
    count=0;
    [score setText:@"0"];
    [opponent setText:@"0"];
    [card1 setText:@""];
    [card2 setText:@""];
    [card3 setText:@""];
    [card4 setText:@""];
    [card5 setText:@""];
    [card6 setText:@""];
    [card7 setText:@""];
    [card8 setText:@""];
    button.enabled = true;
    stop.enabled = true;
    point=0;
    pointOpp=0;
    roundCount=1;
    [pointLab setText:[NSString stringWithFormat:@"%i -",point]];
    [pointOppLab setText:[NSString stringWithFormat:@"%i",pointOpp]];
    
}

-(IBAction)Click:(id)sender {
    switch (count) {
        case 0:{
        [card1 setText:[Cards randomCard]];
            sum = [Cards countScore:[card1 text]];
            [score setText:[NSString stringWithFormat:@"%i",sum]];
            break;
        }
        case 1:{
        [card2 setText:[Cards randomCard]];
            sum = [score.text integerValue]+[Cards countScore:[card2 text]];
            [score setText:[NSString stringWithFormat:@"%i",sum]];
            break;
        }
        case 2:{
        [card3 setText:[Cards randomCard]];
            sum = [score.text integerValue]+[Cards countScore:[card3 text]];
            [score setText:[NSString stringWithFormat:@"%i",sum]];
            break;
        }
        case 3:{
            [card4 setText:[Cards randomCard]];
            sum = [score.text integerValue]+[Cards countScore:[card4 text]];
            [score setText:[NSString stringWithFormat:@"%i",sum]];
            break;
        }
        case 4:{
            [card5 setText:[Cards randomCard]];
            sum = [score.text integerValue]+[Cards countScore:[card5 text]];
            [score setText:[NSString stringWithFormat:@"%i",sum]];
            break;
        }
        case 5:{
            [card6 setText:[Cards randomCard]];
            sum = [score.text integerValue]+[Cards countScore:[card6 text]];
            [score setText:[NSString stringWithFormat:@"%i",sum]];
            break;
        }
        case 6:{
            [card7 setText:[Cards randomCard]];
            sum = [score.text integerValue]+[Cards countScore:[card7 text]];
            [score setText:[NSString stringWithFormat:@"%i",sum]];
            break;
        }
        case 7:{
            [card8 setText:[Cards randomCard]];
            sum = [score.text integerValue]+[Cards countScore:[card8 text]];
            [score setText:[NSString stringWithFormat:@"%i",sum]];
            [button setTitle:@"Начать Заново" forState: UIControlStateNormal ];
            int opp =[Cards countScore:[Cards randomCard]]+[Cards countScore:[Cards randomCard]]+[Cards countScore:[Cards randomCard]];
            [opponent setText:[NSString stringWithFormat:@"%i",opp]];
            break;
        }
        default:
            break;
    }
    if(sum >21){
        button.enabled =false;
        stop.enabled = false;
        pointOpp++;
        [self showAlert:lose];
        [pointOppLab setText:[NSString stringWithFormat:@"%i",pointOpp]];
    }
    if(sum==21){
        button.enabled =false;
        stop.enabled = false;
        point++;
        NSManagedObjectContext *context = [GamePlayer managedObjectContext];
        NSFetchRequest *request21 = [[NSFetchRequest alloc] initWithEntityName:@"Trophy"];
        NSArray *twentyOne = [context executeFetchRequest:request21 error:nil];
        NSManagedObject *object21 = [twentyOne objectAtIndex:0];
        count21 = [[object21 valueForKey:@"twentyOne"] integerValue];
        count21++;
        [object21 setValue:[NSNumber numberWithInt:count21] forKey:@"twentyOne"];
        [context save:nil];
        [self showAlert:win];
        [pointLab setText:[NSString stringWithFormat:@"%i -",point]];
    }
    if(count==7){
        button.enabled = false;
        stop.enabled = false;
        int opp =[Cards countScore:[Cards randomCard]]+[Cards countScore:[Cards randomCard]]+[Cards countScore:[Cards randomCard]];
        [opponent setText:[NSString stringWithFormat:@"%i",opp]];
        if([Cards end:sum :opp]){
            point ++;
            [self showAlert:win];
        }
        else{
            pointOpp++;
            [self showAlert:lose];
        }
        [pointLab setText:[NSString stringWithFormat:@"%i -",point]];
        [pointOppLab setText:[NSString stringWithFormat:@"%i",pointOpp]];
    }
    [self showEndGame];
        count++;
}

-(IBAction)cancel:(id)sender {
    UIAlertController *cancel = [UIAlertController alertControllerWithTitle:@"Закончить партию?" message:@"Вы уверены, что хотите выйти?" preferredStyle:UIAlertControllerStyleAlert ];
    UIAlertAction *agree = [UIAlertAction actionWithTitle:@"Да" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    UIAlertAction *disagree = [UIAlertAction actionWithTitle:@"Нет" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action){}];
    [cancel addAction:agree];
    [cancel addAction:disagree];
    [self presentViewController:cancel animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
