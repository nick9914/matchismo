//
//  Card.h
//  Matchismo
//
//  Created by Ximena Valdez on 12/24/14.
//  Copyright (c) 2014 Nick Valdez. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject
/*Properties*/
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;
//Methods
- (int)match:(NSArray *)otherCards;

@end
