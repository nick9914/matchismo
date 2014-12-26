//
//  PlayingCard.h
//  Matchismo
//
//  Created by Ximena Valdez on 12/24/14.
//  Copyright (c) 2014 Nick Valdez. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;
+ (NSArray *) validSuits;
+ (NSUInteger) maxRank;

@end
