//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Ximena Valdez on 12/27/14.
//  Copyright (c) 2014 Nick Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Designated initializer
- (instancetype) initWithCardCount: (NSUInteger)count usingDeck:(Deck *)deck;

-(void) chooseCardAtIndex: (NSUInteger)index;
-(void)chooseCardAtIndexVersion3:(NSUInteger)index;
-(Card *) cardAtIndex: (NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSString *processString;
@end
