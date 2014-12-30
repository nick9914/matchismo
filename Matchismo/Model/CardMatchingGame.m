//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Ximena Valdez on 12/27/14.
//  Copyright (c) 2014 Nick Valdez. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; //of card
@property (nonatomic, readwrite) NSInteger counter;
@property (nonatomic, strong) NSMutableArray *threeCards; //of card

@end

@implementation CardMatchingGame
//Getter and Setters
- (NSMutableArray *)cards {
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}
- (NSMutableArray *)threeCards {
    if(!_threeCards) _threeCards = [[NSMutableArray alloc] init];
    return _threeCards;
}

//Class instantiation
- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init]; //super's designmated initializer
    
    if(self) {
        for(int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
        
    }
    return self;
    
}

-(Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}


static const int MISMATCH_PENATLY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

-(void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore) {
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                    } else {
                        self.score -= MISMATCH_PENATLY;
                        otherCard.chosen = NO;
                        //TODO: If we allow more than 2 card matches do not necessairly do this.
                    }
                    break; //Can only choose 2 cards for now.
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

-(void)chooseCardAtIndexVersion3:(NSUInteger)index {
    self.counter++; //counter to make sure all three cards chosen are in array before calling match.
    Card *card = [self cardAtIndex:index];
    card.chosen = YES;
    [self.threeCards addObject:card];
    if(self.counter == 3) {
        //TODO: FIX array or MATCH method
        int matchScore = [card match:self.threeCards];
        if(matchScore) {
            self.score += matchScore * MATCH_BONUS;
            for(Card *otherCard in self.threeCards) { //All three cards are taken out, even if only two match.
                otherCard.matched = YES;
            }
        } else {
            for (Card *otherCard in self.threeCards) { //TODO check if the cards in array point to the same cards
                self.score -= MISMATCH_PENATLY;
                otherCard.chosen = NO;
            }
        }
        self.score -= COST_TO_CHOOSE;
        self.counter = 0;
        self.threeCards = nil;
    }
}




@end
