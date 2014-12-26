//
//  ViewController.m
//  Matchismo
//
//  Created by Ximena Valdez on 12/24/14.
//  Copyright (c) 2014 Nick Valdez. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
/*Keep track of the number of flips of the card*/
@property (nonatomic) int flipCount;

@end

@implementation ViewController

-(void)setFlipCount:(int)flipCount {
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    /*Debugging Technique*/
    NSLog(@"flipCount changed to %d", self.flipCount);
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    if(sender.currentTitle.length) {
        /*UIImage has a class method called imageNamed: which crates an instance of UIImage
         given the name of an image in the imgae assets library.*/
        UIImage *cardImage = [UIImage imageNamed:@"cardback"];
        /*The @"" creates an NSString object*/
        
        
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        /*The setBackgroundImage:forState: method asks for the state. We are going to set the background for the defualt (normal state).*/
        
        [sender setTitle:@"" forState:UIControlStateNormal];
        /*Getting rid of the A of clubs on the card*/
    } else {
        UIImage *cardImage = [UIImage imageNamed:@"cardfront"];
        
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        
        [sender setTitle:@"A♣︎" forState:UIControlStateNormal];
    }
    self.flipCount++;
    
    
}


@end
