//
//  GameSceneViewController.m
//  Lines_iOS
//
//  Created by robert on 01/07/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "GameSceneViewController.h"
#import "GameField.h"

@interface GameSceneViewController ()

@property (strong, nonatomic) GameField *gameField;

@end

@implementation GameSceneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gameField = [[GameField alloc] initEmptyFieldWithRows:5 columns:5 margin:10];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
