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
    [NSTimer scheduledTimerWithTimeInterval:3.f target:self selector:@selector(goToMainView) userInfo:nil repeats:NO];
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
