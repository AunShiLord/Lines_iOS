//
//  GameDelegate.h
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GameField, GameFieldCell;

@protocol GameFieldDelegate <NSObject>

// method that informs that there is no empty space on the gameField
-(void)gameFieldOverloaded:(GameField *)gameField;

// delegate method that informs GameScene controller that turn is over
-(void)gameField:(GameField *)gameField movedBallFrom:(GameFieldCell *)startCell to:(GameFieldCell *)destinationCell;

@end
