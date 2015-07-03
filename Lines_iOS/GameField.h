//
//  GameField.h
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameDelegate.h"

// neobhodimo realizovat' delegat, soobshaushiy chto pole perepolneno

@interface GameField : UIView <GameDelegate>

@property (strong, nonatomic) UIView *view;
@property int numberOfRows;
@property int numberOfColumns;
@property (strong, nonatomic) NSMutableDictionary *gameFieldState;

@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

@property (strong, nonatomic) id<GameDelegate> delegate;

/* init empty game field of size N * M
 The frame width of new GameField will be a screen size width minus margins
 */
-(id)initEmptyFieldWithRows:(int)numberOfRows
                    columns:(int)numberOfColumns
                     margin:(int)margin;

// init gameField from saved game state
-(id)initWithGameFieldState:(NSDictionary *)gameFieldState;

-(void)spawnBalls:(int)numberOfBallsToSpawn;

// checks the whole game field for lines. If there any line return YES.
-(BOOL)checkFieldForLines;

@end
