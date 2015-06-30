//
//  GameField.m
//  Lines_iOS
//
//  Created by robert on 30/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "GameField.h"

@implementation GameField

-(void)spawnBalls:(int)numberOfBallsToSpawn
{
    // if no more room to spawn balls
    [self.delegate gameFieldOverloaded];
}

@end
