//
//  SplashScreenViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 6/2/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "SplashScreenViewController.h"
#import "MainViewController.h"
#import "AppDelegate.h"

@interface SplashScreenViewController ()

@end

@implementation SplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[ConfigManager getInstance] loadConfig:@"https://raw.githubusercontent.com/anhphideptrai/BricksAnimated3D/master/config-app/get_config_bricks_app.json" finished:^(BOOL success, ConfigApp *configApp) {
        AppDelegate *appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        if (success) {
            appDelegate.config = configApp;
            [[NSUserDefaults standardUserDefaults] setValue:appDelegate.config.statusApp forKey:CONFIG_STATUS_TAG];
            [[NSUserDefaults standardUserDefaults] setValue:appDelegate.config.adsShow forKey:CONFIG_ADS_TAG];
            [[NSUserDefaults standardUserDefaults] setValue:appDelegate.config.moreShow forKey:CONFIG_MORE_TAG];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }else{
            appDelegate.config = [[ConfigApp alloc] init];
            if ([[NSUserDefaults standardUserDefaults] objectForKey:CONFIG_STATUS_TAG]) {
                appDelegate.config.statusApp = [[NSUserDefaults standardUserDefaults] objectForKey:CONFIG_STATUS_TAG];
            }else{
                appDelegate.config.statusApp = _status_defalt_;
            }
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:CONFIG_ADS_TAG]) {
                appDelegate.config.adsShow = [[NSUserDefaults standardUserDefaults] objectForKey:CONFIG_ADS_TAG];
            }else{
                appDelegate.config.adsShow = _ads_default_;
            }
            
            if ([[NSUserDefaults standardUserDefaults] objectForKey:CONFIG_MORE_TAG]) {
                appDelegate.config.moreShow = [[NSUserDefaults standardUserDefaults] objectForKey:CONFIG_MORE_TAG];
            }else{
                appDelegate.config.moreShow = _more_default_;
            }
        }
        [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(goToMainView) userInfo:nil repeats:NO];
    }];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)goToMainView{
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil]];
    appDelegate.window.rootViewController = navC;
}
@end
