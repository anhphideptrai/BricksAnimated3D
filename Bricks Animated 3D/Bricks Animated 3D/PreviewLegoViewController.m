//
//  PreviewLegoViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/29/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "PreviewLegoViewController.h"

@interface PreviewLegoViewController ()

@end

@implementation PreviewLegoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_lego) {
        [self.navigationItem setTitle:_lego.name];
    }
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x2a9c40);
    
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:nil];
    [leftButton setTitleTextAttributes:@{
                                          NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                          NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                          } forState:UIControlStateNormal];
    
    UIBarButtonItem *righttButton = [[UIBarButtonItem alloc] initWithTitle:@"Share!"
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:nil];
    [righttButton setTitleTextAttributes:@{
                                         NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                         NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                         } forState:UIControlStateNormal];
    
    [self.navigationItem setBackBarButtonItem:leftButton];
    [self.navigationItem setRightBarButtonItem:righttButton];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
