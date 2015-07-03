//
//  GameFieldCell.h
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ColorBall.h"
#import "GameFieldCellDelegate.h"


/* This class describes one cell on the GameField. Cell may contain ColorBall or be empty.
 Cell is a part of the GameField and on the the N * M cell. Cell might be highlighted */
@interface GameFieldCell : UIImageView

@property (strong, nonatomic) NSIndexPath *index;
@property BOOL isHighlighted;
@property (weak, nonatomic) id<GameFieldCellDelegate> delegate;

//current GameFieldCell. -1 is for the empty state, ColorBallColor for other balls.
@property int currentState;

-(void)spawnBallwithColor:(ColorBallColor) colorBallColor;
-(void)removeBall;
-(id)initWithIndex:(NSIndexPath *)index andRect:(CGRect)rect;
-(void)highlight;
-(void)unhighlight;

@end
