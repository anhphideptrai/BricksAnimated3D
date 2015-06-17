//
//  MenuViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 6/17/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "MenuViewController.h"
#import "AppDelegate.h"
#import "MainViewController.h"

@interface MenuViewController (){
    AppDelegate *appDelegate;
}
- (IBAction)actionClickNormalLego:(id)sender;
- (IBAction)actionClickSimpleLego:(id)sender;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate = [UIApplication sharedApplication].delegate;
    
    [self.navigationItem setTitle:@"Animated Bricks 3D"];
    
    //create a right side button in the navigation bar
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Like!"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(actionLike)];
    [leftButton setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                         NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                         } forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    NSUInteger r = arc4random_uniform(15) + 1;
    if (r == 3) {
        if (!([[NSUserDefaults standardUserDefaults] objectForKey:SHOW_RATING_VIEW_TAG])) {
            [self actionLike];
        }
    }
}
- (IBAction)actionClickNormalLego:(id)sender {
    appDelegate.legoType = NORMAL_LEGO_TYPE;
    [self goToMainView];
}

- (IBAction)actionClickSimpleLego:(id)sender {
    appDelegate.legoType = SIMPLE_LEGO_TYPE;
    [self goToMainView];
}
- (void)actionLike{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_msg_rating_ message:nil delegate:self cancelButtonTitle:_msg_dismiss_ otherButtonTitles:_msg_rate_it_5_starts_, nil];
    [alert show];
}
- (void)goToMainView{
    [self.navigationController pushViewController:[[MainViewController alloc] initWithNibName:@"MainViewController" bundle:nil] animated:YES];
}
#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[NSUserDefaults standardUserDefaults] setValue:@(true) forKey:SHOW_RATING_VIEW_TAG];
        [[NSUserDefaults standardUserDefaults] synchronize];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appDelegate.config.urliTunes]];
    }
}
@end
