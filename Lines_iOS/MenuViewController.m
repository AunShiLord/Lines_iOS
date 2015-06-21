//
//  MenuViewController.m
//  Lines_iOS
//
//  Created by robert on 21/06/15.
//  Copyright (c) 2015 A'Shi. All rights reserved.
//

#import "MenuViewController.h"

#import "NewGameTypeViewController.h"
#import "LeadereboardViewController.h"
#import "SettingViewController.h"
#import "HelpViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Button actions
- (IBAction)continueGame:(id)sender {
}
- (IBAction)openNewGameTypeMenu:(id)sender {
    NewGameTypeViewController *newGameTypeMenu = [NewGameTypeViewController new];
    newGameTypeMenu.title = @"";
    [self.navigationController pushViewController:newGameTypeMenu animated:YES];
}
- (IBAction)openLeaderboard:(id)sender {
    LeadereboardViewController *leaderboard = [LeadereboardViewController new];
    leaderboard.title = @"";
    [self.navigationController pushViewController:leaderboard animated:YES];
}
- (IBAction)openSetting:(id)sender {
    SettingViewController *settings = [SettingViewController new];
    settings.title = @"";
    [self.navigationController pushViewController:settings animated:YES];
}
- (IBAction)openHelp:(id)sender {
    HelpViewController *help = [HelpViewController new];
    help.title = @"";
    [self.navigationController pushViewController:help animated:YES];
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
