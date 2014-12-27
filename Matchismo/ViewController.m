//
//  ViewController.m
//  Matchismo
//
//  Created by Ximena Valdez on 12/24/14.
//  Copyright (c) 2014 Nick Valdez. All rights reserved.
//

#import "ViewController.h"
#import "Deck.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
/*Keep track of the number of flips of the card*/
@property (nonatomic) int flipCount;
@property (nonatomic) Deck *deckOfCards;

@end

@implementation ViewController
//Getter and Setters

-(Deck *) deckOfCards {
    if(!_deckOfCards) _deckOfCards = [[PlayingCardDeck alloc] init];
    return _deckOfCards;
}

-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    /*Debugging Technique*/
    NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if(sender.currentTitle.length) {
        UIImage *cardImage = [UIImage imageNamed:@"cardback"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        /*Getting rid of the A of clubs on the card*/
    } else {
        UIImage *cardImage = [UIImage imageNamed:@"cardfront"];
        PlayingCard *playingCard = (PlayingCard *)[self.deckOfCards drawRandomCard];
        
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        NSLog(@"Contents are: %@", playingCard.contents);
        [sender setTitle: playingCard.contents forState:UIControlStateNormal];
    }
    self.flipCount++;
    
    
}


@end
