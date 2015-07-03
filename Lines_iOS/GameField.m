//
//  GameField.m
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "ColorBall.h"
#import "GameField.h"
#import "GameFieldCell.h"


@interface GameField()

@property (nonatomic, readwrite) CGFloat width;
@property (nonatomic, readwrite) CGFloat height;
@end;

@implementation GameField

-(id)initEmptyFieldWithRows:(int)numberOfRows columns:(int)numberOfColumns margin:(int)margin
{
    self = [super self];
    if (self)
    {
        self.gameFieldState = [NSMutableDictionary new];
        // init new game field frame
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        self.width = screenRect.size.width - margin*2;
        self.height = self.width * (float)numberOfRows/(float)numberOfColumns;
        CGRect gameFieldRect = CGRectMake(margin,
                                          screenRect.size.height - margin - self.height,
                                          self.width,
                                          self.height);
        
        self.frame = gameFieldRect;
        
        // size of each side of the gameFieldCell
        CGFloat gameFieldCellsize = self.width / numberOfColumns;
        
        // now, when game field is set on the bottom of the screen,
        // filling it with gameCells
        for (int i=0; i<numberOfRows; i++)
        {
            for (int j=0; j<numberOfColumns; j++)
            {
                CGRect gameFieldRect = CGRectMake(gameFieldCellsize * j,
                                                  gameFieldCellsize * i,
                                                  gameFieldCellsize,
                                                  gameFieldCellsize);
                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:j];
                GameFieldCell *cell = [[GameFieldCell alloc] initWithIndex: index andRect:gameFieldRect];
                [self addSubview:cell];
                //[self.gameFieldState setObject:0 forKey:index];
            }
        }
        //NSIndexPath *index = [NSIndexPath indexPathForRow:3 inSection:3];
        //NSLog(@"\nCHECK INDEX: %d", (int)[self.gameFieldState objectForKey:index]);
        
    }
    
    return self;
}

-(void)spawnBalls:(int)numberOfBallsToSpawn
{
    // if no more room to spawn balls
    [self.delegate gameFieldOverloaded];
}

@end
