//
//  GameSceneViewController.m
//  Lines_iOS
//
//  Created by robert on 01/07/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "GameSceneViewController.h"
#import "GameField.h"
#import "ColorBall.h"

// for arc4random_uniform
#include <stdlib.h>

@interface GameSceneViewController () <GameFieldDelegate>

@property (strong, nonatomic) GameField *gameField;

@end

@implementation GameSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gameField = [[GameField alloc] initEmptyFieldWithRows:9 columns:9 margin:10];
    self.gameField.delegate = self;
    [self.view addSubview:self.gameField];
    
    [self.gameField spawnBallsWithColors:@[[NSNumber numberWithInt:arc4random_uniform(7)],
                                           [NSNumber numberWithInt:arc4random_uniform(7)],
                                           [NSNumber numberWithInt:arc4random_uniform(7)]]];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)spawnBallsTest:(id)sender
{
    [self.gameField spawnBallsWithColors:@[[NSNumber numberWithInt:arc4random_uniform(7)],
                                           [NSNumber numberWithInt:arc4random_uniform(7)],
                                           [NSNumber numberWithInt:arc4random_uniform(7)]]];
}

#pragma mark - Game Delegate Methods
-(void)gameFieldOverloaded:(GameField *)gameField
{
    NSLog(@"\n\nGAME FIELD IS OVERLOADED");
}

-(void)gameField:(GameField *)gameField movedBallFrom:(GameFieldCell *)startCell to:(GameFieldCell *)destinationCell
{
    NSLog(@"\n\nBALL MOVED\n\n");
    [gameField testPrintGameFieldState];
    
    [self.gameField spawnBallsWithColors:@[[NSNumber numberWithInt:arc4random_uniform(7)],
                                           [NSNumber numberWithInt:arc4random_uniform(7)],
                                           [NSNumber numberWithInt:arc4random_uniform(7)]]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
