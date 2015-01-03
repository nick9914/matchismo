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
#import "CardMatchingGame.h"

@interface ViewController ()

@property (strong, nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UIButton *reDeal;
@property (weak, nonatomic) IBOutlet UISwitch *switch3or2;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISlider *historySlider;
@property (strong, nonatomic) NSMutableArray *resultHistoryArray;


@end

@implementation ViewController
//Getter and Setters

-(CardMatchingGame *) game {
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    return _game;
}

-(NSMutableArray *) resultHistoryArray {
    if(!_resultHistoryArray) _resultHistoryArray = [[NSMutableArray alloc] init];
    return _resultHistoryArray;
}

-(Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}


-(void)viewDidLoad {
    [super viewDidLoad];
    self.historySlider.minimumValue = 0;
    self.historySlider.maximumValue = 0;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    if(self.switch3or2.isOn) {
        // 3 card match mode
        [self.game chooseCardAtIndexVersion3:chosenButtonIndex];
        [self updateUI];
        
    } else {
        [self.game chooseCardAtIndex:chosenButtonIndex];
        [self updateUI];
    }
    
    
}
-(void)updateUI {
    for(UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle: [self titleForCard:card] forState:UIControlStateNormal];
        //Fix the (...) problem.
        cardButton.titleLabel.adjustsFontSizeToFitWidth = YES;
        [cardButton setBackgroundImage: [self backgroundImageForCard:card] forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.resultLabel.text = self.game.processString;
    [self updateHistory];
}

-(void)updateHistory {
    //Add processString to the end of the array.
    [self.resultHistoryArray addObject:self.game.processString];
    //Increase the Maximum Value of the slider
    self.historySlider.maximumValue++;
    [self.historySlider setValue:self.historySlider.maximumValue animated:YES];
}


-(NSString *) titleForCard: (Card *)card {
    return card.isChosen ? card.contents : @"";
}

-(UIImage *) backgroundImageForCard: (Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

-(void)reDealCards {
    //Flip over all of the cards
    UIImage *cardback = [UIImage imageNamed:@"cardback"];
    for(UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:cardback forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
    //Set the score = 0
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
    self.resultLabel.text = @"";
    self.game = nil;
    
    //Rest the Hitory for the game
    self.resultHistoryArray = nil;
    self.historySlider.maximumValue = 0;
}

- (IBAction)touchReDealButton:(UIButton *)sender {
    [self reDealCards];
    self.switch3or2.enabled = YES;
    
}
- (IBAction)flipSwitch3or2:(UISwitch *)sender {
    //First re-deal cards
    [self reDealCards];
}

- (IBAction)sliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    NSInteger val = lround(slider.value);
    NSLog(@"Slider Value is: %d", val);
    if(val < [self.resultHistoryArray count] && val >= 0) {
        self.resultLabel.text = self.resultHistoryArray[val];
    }
    
    
    
}


@end
