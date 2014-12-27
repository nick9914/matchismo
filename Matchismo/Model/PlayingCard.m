//
//  PlayingCard.m
//  Matchismo
//
//  Created by Ximena Valdez on 12/24/14.
//  Copyright (c) 2014 Nick Valdez. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard
//Getters and Setters

/*In this case we are modifying our parents class' getter of contents*/
- (NSString *) contents {
    
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}

@synthesize suit = _suit; //Because we provide setter and getter

//overide the getter for suit
- (NSString *) suit {
    return _suit ? _suit : @"?";
}

- (void) setSuit:(NSString *)suit {
    if( [[PlayingCard validSuits] containsObject: suit]) {
        _suit = suit;
    }
}

//Class methods
+ (NSArray *) validSuits {
    return @[@"♥︎", @"♦︎", @"♠︎", @"♣︎"];
}

+ (NSArray *) rankStrings {
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
}

+ (NSUInteger) maxRank {
    return [[self rankStrings] count] -1 ;
}

//Instance methods
- (void) setRank: (NSUInteger)rank {
    if ( rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

@end
