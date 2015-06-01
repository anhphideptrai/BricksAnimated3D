//
//  GuideViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 6/1/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "GuideViewController.h"
#import <GoogleMobileAds/GoogleMobileAds.h>
#import "BricksBarView.h"
#import "BricksViewController.h"

@interface GuideViewController ()<GADBannerViewDelegate, BricksBarViewDelegate>{
    NSInteger currentIndex;
    NSURL *oldImg;
    NSURL *newImg;
}
@property (weak, nonatomic) IBOutlet UIImageView *imgV;
@property (weak, nonatomic) IBOutlet UIView *toolBarView;
@property (weak, nonatomic) IBOutlet GADBannerView *bannerV;
@property (weak, nonatomic) IBOutlet UIButton *btnLeft;
@property (weak, nonatomic) IBOutlet UIButton *btnRight;
@property (weak, nonatomic) IBOutlet UIView *bricksView;
@property (weak, nonatomic) IBOutlet UILabel *lbDescription;
@property (nonatomic, strong) BricksBarView *bricksBarView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightBannerLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomToolBarLayoutConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightImgLayoutConstraint;
- (IBAction)actionLeft:(id)sender;
- (IBAction)actionRight:(id)sender;

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
    
    [_lbDescription setFont:[UIFont fontWithName:@"Helvetica" size:20.f]];
    [_lbDescription setTextColor:UIColorFromRGB(0x2a9c40)];
    [_imgV setContentMode:UIViewContentModeScaleAspectFit];
    
    currentIndex = -1;
    [self updateData];
    
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
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!_bricksBarView) {
        _bricksBarView = [[BricksBarView alloc] initBricksBarWithFrame:CGRectMake(0, 1, self.view.frame.size.width, _bricksView.frame.size.height - 2)];
        [_bricksBarView setDelegate:self];
        [_bricksBarView setBackgroundColor:UIColorFromRGB(0xf8f8f8)];
        [_bricksBarView loadView];
        [_bricksView setBackgroundColor:UIColorFromRGB(0xe0e0e0)];
        [_bricksView addSubview:_bricksBarView];
    }
}
- (void)adViewDidReceiveAd:(GADBannerView *)view{
    _bottomToolBarLayoutConstraint.constant = IS_IPAD ? 90 : 50;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)updateData{
    if (currentIndex == -1) {
        oldImg = [Utils getURLBundleForFileName:_lego.preview];
        newImg = oldImg;
        [_lbDescription setText:@"Preview"];
    }else{
        LegoStep *step = (LegoStep*)_lego.legoSteps[currentIndex];
        if (step.legoImgs.count > 1) {
            oldImg = [Utils getURLImageForIDLego:step.iDLego andFileName:[[((LegoImage*)step.legoImgs[0]).urlImage componentsSeparatedByString:@"/"] lastObject]];
            newImg = [Utils getURLImageForIDLego:step.iDLego andFileName:[[((LegoImage*)step.legoImgs[1]).urlImage componentsSeparatedByString:@"/"] lastObject]];
        }else{
            oldImg = newImg;
            newImg = [Utils getURLImageForIDLego:step.iDLego andFileName:[[((LegoImage*)step.legoImgs[0]).urlImage componentsSeparatedByString:@"/"] lastObject]];
        }
        [_lbDescription setText:[NSString stringWithFormat:@"%ld/%lu", currentIndex + 1, (unsigned long)_lego.legoSteps.count]];
    }
    [_imgV setImageWithURL:newImg];
}
- (IBAction)actionLeft:(id)sender {
    currentIndex = MAX(-1, currentIndex - 1);
    [self updateData];
    [_bricksBarView loadView];
}
- (IBAction)actionRight:(id)sender {
    currentIndex = MIN(_lego.legoSteps.count - 1, currentIndex + 1);
    [self updateData];
    [_bricksBarView loadView];
}
#pragma mark - BricksBarViewDelegate methods
- (NSMutableArray*)dataItemsForBricksBarView:(BricksBarView*)bricksBarView{
    return currentIndex == -1 ? _lego.bricks : ((LegoStep*)_lego.legoSteps[currentIndex]).bricks;
    
}
- (void) didTapBottomToolBarItem:(BricksBarView*)bricksBarView{
    BricksViewController *bricksVC = [BricksViewController new];
    [bricksVC setLego:_lego];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:bricksVC];
    [self presentViewController:navC animated:YES completion:^{}];
}
@end
