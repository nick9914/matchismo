//
//  PlayingCardDeck.m
//  Matchismo
//
//  Created by Ximena Valdez on 12/26/14.
//  Copyright (c) 2014 Nick Valdez. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype) init {
    //The only time you would ever assing something to self.
    //The idea here is to reutn nil if you cannot initialize this object.
    //The idea here is to return nil if you cannot initialize this object.
    // This is a bit of protection against our tyring to continue to initialize ourselves if our supercall couldn't initialize.
    self = [super init];
    
    if (self) {
        for(NSString *suit in [PlayingCard validSuits]) {
            for (NSUInteger rank = 1; rank <= [PlayingCard maxRank]; rank++){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                [self addCard: card];
            }
        }
        
    }
    return self;
}

@end
