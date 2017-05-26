//
//  Cards.m
//  RandCard
//
//  Created by Max Koryakin on 03.03.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import "Cards.h"

@implementation Cards

//Create a cards deck
+(NSArray *) createCards {
    NSArray *r = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K",@"A"];
    return r;
}

//Choose tandom card
+(NSString *) randomCard{
    NSArray *r = [Cards createCards];
    NSString *str = [NSString stringWithFormat:@"%@", r[arc4random()%14]];
    return str;
}

//Value for each card
+(int) countScore:(NSString *)s1 {
    int s=0;
    NSArray *r = [Cards createCards];
    NSArray *sc = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"2",@"3",@"4",@"11"];
    s = [[sc objectAtIndex:[r indexOfObject:s1]] integerValue];
    return s;
}


//compare player score and computer score
+(BOOL) end:(int)s1 :(int)s2 {
    BOOL T = false;
    if(s2>21){
        T = true;
    }
    if(s1>s2){
        T=true;
    }
    if((s1<=s2) &&(s2<=21))
    {
        T=false;
    }
   return T;
}

@end
