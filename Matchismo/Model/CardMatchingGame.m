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
@property (nonatomic, readwrite) NSString *processString;
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
- (NSString *)processString {
    if(!_processString) _processString = [[NSString alloc] init];
    return _processString;
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
    int points = 0;
    Card *card = [self cardAtIndex:index];
    self.processString = @"";
    
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
        } else {
            // match against other chosen cards
            self.processString = card.contents;
            for (Card *otherCard in self.cards) {
                if(otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore) {
                        points = matchScore * MATCH_BONUS;
                        self.score += matchScore * MATCH_BONUS;
                        otherCard.matched = YES;
                        card.matched = YES;
                        self.processString = [NSString stringWithFormat:@"Matched %@ %@ for %d points", card.contents, otherCard.contents, points];
                    } else {
                        points = MISMATCH_PENATLY;
                        self.score -= MISMATCH_PENATLY;
                        otherCard.chosen = NO;
                        self.processString = [NSString stringWithFormat:@"%@ %@ don't match %d point penalty", card.contents, otherCard.contents, MISMATCH_PENATLY];
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
    int points = 0;
    self.counter++; //counter to make sure all three cards chosen are in array before calling match.
    Card *card = [self cardAtIndex:index];
    card.chosen = YES;
    [self.threeCards addObject:card];
    self.processString = card.contents;
    if(self.counter == 3) {
        //TODO: FIX array or MATCH method
        int matchScore = [card match:self.threeCards];
        if(matchScore) {
            self.score += matchScore * MATCH_BONUS;
            for(Card *otherCard in self.threeCards) { //All three cards are taken out, even if only two match.
                otherCard.matched = YES;
            }
            points = matchScore * MATCH_BONUS;
            self.processString = [NSString stringWithFormat:@"Matched for %d points", points];
        } else {
            for (Card *otherCard in self.threeCards) { //TODO check if the cards in array point to the same cards
                self.score -= MISMATCH_PENATLY;
                otherCard.chosen = NO;
                points += MISMATCH_PENATLY;
            }
            self.processString = [NSString stringWithFormat:@"No match, %d penalty", points];
        }
        self.score -= COST_TO_CHOOSE;
        self.counter = 0;
        self.threeCards = nil;
    }
}




@end
