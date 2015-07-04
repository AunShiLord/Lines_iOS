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

@property CGFloat killingSpreeMultiplyer;
@property int scorePoints;
@property (weak, nonatomic) IBOutlet UILabel *scorePointLabel;

@end

@implementation GameSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.killingSpreeMultiplyer = 1.0;
    self.scorePoints = 0;
    self.gameField = [[GameField alloc] initEmptyFieldWithRows:9 columns:9 margin:10];
    self.gameField.delegate = self;
    [self.view addSubview:self.gameField];
    
    [self.gameField spawnBallsWithColors:@[[NSNumber numberWithInt:arc4random_uniform(7)],
                                           [NSNumber numberWithInt:arc4random_uniform(7)],
                                           [NSNumber numberWithInt:arc4random_uniform(7)],
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
- (IBAction)checkLines:(id)sender
{
    self.scorePoints = [self.gameField scanForLinesAndGetScorePoints];
    self.scorePointLabel.text = [NSString stringWithFormat:@"Score: %d", self.scorePoints];
}

-(void)updateScorePoints:(int)scorePoints
{
    scorePoints *= self.killingSpreeMultiplyer;
    self.killingSpreeMultiplyer += 0.25;
    self.scorePoints += scorePoints;
    self.scorePointLabel.text = [NSString stringWithFormat:@"Score: %d", self.scorePoints];
}

// turn is over
-(void)gameField:(GameField *)gameField movedBallFrom:(GameFieldCell *)startCell to:(GameFieldCell *)destinationCell
{
    NSLog(@"\n\nBALL MOVED\n\n");
    [gameField testPrintGameFieldState];
    int newScorePoints = [self.gameField scanForLinesAndGetScorePoints];
    
    // check lines, destroy balls, count scorePoints
    if (newScorePoints != 0)
        [self updateScorePoints:newScorePoints];
    // if no balls were deleted, then spawn balls
    else
    {
        [self.gameField spawnBallsWithColors:@[[NSNumber numberWithInt:arc4random_uniform(7)],
                                               [NSNumber numberWithInt:arc4random_uniform(7)],
                                               [NSNumber numberWithInt:arc4random_uniform(7)]]];
        self.killingSpreeMultiplyer = 1.0;
        newScorePoints = [self.gameField scanForLinesAndGetScorePoints];
        if (newScorePoints != 0)
            [self updateScorePoints:newScorePoints];
        
        
    }
    
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
