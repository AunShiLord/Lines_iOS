//
//  GameField.h
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GameFieldDelegate.h"

// neobhodimo realizovat' delegat, soobshaushiy chto pole perepolneno

@interface GameField : UIView <GameFieldDelegate>

//@property (strong, nonatomic) UIView *view;
@property int numberOfRows;
@property int numberOfColumns;
@property int **gameFieldState;

@property (strong, nonatomic) NSIndexPath *currentlySelectedCellIndex;

@property int spawnedBalls;

@property (nonatomic, readonly) CGFloat width;
@property (nonatomic, readonly) CGFloat height;

@property (weak, nonatomic) id<GameFieldDelegate> delegate;

/* init empty game field of size N * M
 The frame width of new GameField will be a screen size width minus margins
 */
-(id)initEmptyFieldWithRows:(int)numberOfRows
                    columns:(int)numberOfColumns
                     margin:(int)margin;

// init gameField from saved game state
-(id)initWithGameFieldState:(NSDictionary *)gameFieldState;

-(void)spawnBallsWithColors:(NSArray *)colors;

// scans GameField for possible lines and destroy them. Returns recieved score points
-(int)scanForLinesAndGetScorePoints;

// checks the whole game field for lines. If there any line return YES.
-(BOOL)checkFieldForLines;

-(void)testPrintGameFieldState;

@end
