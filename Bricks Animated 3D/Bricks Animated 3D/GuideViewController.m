//
//  GuideViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 6/1/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "GuideViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface GuideViewController ()<GADBannerViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerV;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBannerLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomToolBarLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightImgLayoutConstraint;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
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
    
    [_imgV setContentMode:UIViewContentModeScaleAspectFit];
    [_imgV setImageWithURL:[[NSBundle mainBundle] URLForResource:[[_lego.preview componentsSeparatedByString:@"."] firstObject] withExtension:[[_lego.preview componentsSeparatedByString:@"."] lastObject]]];
    
    //Add Admob
    _heightBannerLayoutConstraint.constant = IS_IPAD ? 90 : 50;
    _heightImgLayoutConstraint.constant = IS_IPAD ? 190 : 150;
    self.bannerV.adUnitID = BANNER_ID_ADMOB_DETAIL_PAGE;
    self.bannerV.rootViewController = self;
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:@"GAD_SIMULATOR_ID",
                           @"1485d1faa4c1010a54b384ca9e9944b7", @"f2b1a55b050ac3483e1c17a21a2073f5",
                           nil];
    [self.bannerV setDelegate:self];
    [self.bannerV loadRequest:request];

}
- (void)adViewDidReceiveAd:(GADBannerView *)view{
    _bottomToolBarLayoutConstraint.constant = IS_IPAD ? 90 : 50;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
@end
