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
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:nil];
    [rightButton setTitleTextAttributes:@{
                                          NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                          NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                          } forState:UIControlStateNormal];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x2a9c40);
    [self.navigationItem setBackBarButtonItem:rightButton];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
