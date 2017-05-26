//
//  Cards.h
//  RandCard
//
//  Created by Max Koryakin on 03.03.17.
//  Copyright © 2017 Max Koryakin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cards : NSObject
{
    NSArray *allCard;
}
+(NSArray *) createCards;
+(NSString *) randomCard;
+(int) countScore : (NSString *) s1;
+(BOOL) end: (int) s1 :(int) s2;

@end
