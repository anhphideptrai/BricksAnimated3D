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
#import <MessageUI/MessageUI.h>
#import <Social/Social.h>
#import "AppDelegate.h"

#define _TIME_TICK_CHANGE_ 3.f

@interface GuideViewController ()<GADBannerViewDelegate, BricksBarViewDelegate, MFMailComposeViewControllerDelegate>{
    NSInteger currentIndex;
    NSURL *oldImg;
    NSURL *newImg;
    NSTimer *timeChangeImage;
    AppDelegate *appDelegate;
}
@property (weak, nonatomic) IBOutlet UIImageView *a_oldImgView;
@property (weak, nonatomic) IBOutlet UIImageView *a_newImgView;
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
    appDelegate = [UIApplication sharedApplication].delegate;
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
    [self.navigationItem setBackBarButtonItem:leftButton];

    if (![appDelegate.config.statusApp isEqualToString:_status_defalt_]) {
        UIBarButtonItem *righttButton = [[UIBarButtonItem alloc] initWithTitle:@"Share!"
                                                                         style:UIBarButtonItemStylePlain
                                                                        target:self
                                                                        action:@selector(actionShare)];
        [righttButton setTitleTextAttributes:@{
                                               NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                               NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                               } forState:UIControlStateNormal];
        [self.navigationItem setRightBarButtonItem:righttButton];
    }
    
    [_lbDescription setFont:[UIFont fontWithName:@"Helvetica" size:20.f]];
    [_lbDescription setTextColor:UIColorFromRGB(0x2a9c40)];
    [_a_oldImgView setContentMode:UIViewContentModeScaleAspectFit];
    [_a_newImgView setContentMode:UIViewContentModeScaleAspectFit];
    
    _heightBannerLayoutConstraint.constant = IS_IPAD ? 90 : 50;
    _heightImgLayoutConstraint.constant = IS_IPAD ? 190 : 150;
    
    currentIndex = -1;
    
    [NSTimer scheduledTimerWithTimeInterval:_TIME_TICK_CHANGE_ target:self selector:@selector(delayShowAds) userInfo:nil repeats:NO];
}
- (void)delayShowAds{
    //Add Admob
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
    [self updateData];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    if (timeChangeImage) {
        [timeChangeImage invalidate];
        timeChangeImage = nil;
    }
    [_a_newImgView setAlpha:1.f];
}
- (void)adViewDidReceiveAd:(GADBannerView *)view{
    _bottomToolBarLayoutConstraint.constant = IS_IPAD ? 90 : 50;
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)actionShare{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_msg_share_ message:nil delegate:self cancelButtonTitle:_msg_cancel_ otherButtonTitles:_msg_share_on_facebook_, _msg_send_mail_to_friends, nil];
    [alert show];
}
- (void)updateData{
    [_bricksView setHidden:currentIndex == _lego.legoSteps.count - 1];
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
            if (currentIndex == _lego.legoSteps.count - 1) {
                newImg = [Utils getURLImageForIDLego:step.iDLego andFileName:[[((LegoImage*)step.legoImgs[0]).urlImage componentsSeparatedByString:@"/"] lastObject]];
                oldImg = newImg;
            }else{
                LegoStep *stepPre = (LegoStep*)_lego.legoSteps[currentIndex - 1];
                if (stepPre.legoImgs.count > 1) {
                    oldImg = [Utils getURLImageForIDLego:stepPre.iDLego andFileName:[[((LegoImage*)stepPre.legoImgs[1]).urlImage componentsSeparatedByString:@"/"] lastObject]];
                }else{
                    oldImg = [Utils getURLImageForIDLego:stepPre.iDLego andFileName:[[((LegoImage*)stepPre.legoImgs[0]).urlImage componentsSeparatedByString:@"/"] lastObject]];
                }
                newImg = [Utils getURLImageForIDLego:step.iDLego andFileName:[[((LegoImage*)step.legoImgs[0]).urlImage componentsSeparatedByString:@"/"] lastObject]];
            }
        }
        [_lbDescription setText:[NSString stringWithFormat:@"%ld/%lu", currentIndex + 1, (unsigned long)_lego.legoSteps.count]];
    }
    if (timeChangeImage) {
        [timeChangeImage invalidate];
        timeChangeImage = nil;
    }
    [_a_newImgView setAlpha:1.f];
    [_a_newImgView setImageWithURL:newImg];
    [_a_oldImgView setImageWithURL:oldImg];
    timeChangeImage = [NSTimer scheduledTimerWithTimeInterval:2.f target:self selector:@selector(updateImageChange) userInfo:nil repeats:YES];
}
- (void)updateImageChange{
    [UIView animateWithDuration:1.f animations:^{
        [_a_newImgView setAlpha:0.f];
    } completion:^(BOOL finished) {
        [_a_newImgView setAlpha:1.f];
    }];
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
#pragma mark - MFMailComposeViewControllerDelegate methods
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:NULL];
}
#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        if (buttonIndex == 1) {
            [self shareToFacebook];
        }else{
            [self sendMailInviteTo:@"" withSubject:@"Animated Bricks 3D for LEGO new creations" andContent:[NSString stringWithFormat:@"Lots of new instructions for Lego\niTunes:\n%@\n\nI like it!!!", appDelegate.config.urliTunes]];
        }
    }
}
// Invate utils
- (void)sendMailInviteTo:(NSString*)mail
             withSubject:(NSString*)subject
              andContent:(NSString*)contentMail{
    NSArray *toRecipents = [NSArray arrayWithObject:mail];
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    if ([MFMailComposeViewController canSendMail] && mc) {
        mc.mailComposeDelegate = self;
        [mc setSubject:subject];
        [mc setMessageBody:contentMail isHTML:NO];
        [mc setToRecipients:toRecipents];
        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:_lego.preview]);
        [mc addAttachmentData:imageData mimeType:@"image/png" fileName:[NSString stringWithFormat:@"preview.png"]];
        // Present mail view controller on screen
        [self presentViewController:mc animated:YES completion:NULL];
    }
}
- (void)shareToFacebook{
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
    [controller setInitialText:[NSString stringWithFormat:@"Lots of new instructions for Lego\niTunes:\n%@\n\nI like it!!!", appDelegate.config.urliTunes]];
    [controller addURL:[NSURL URLWithString:appDelegate.config.urliTunes]];
    [controller addImage:[UIImage imageNamed:_lego.preview]];
    [self presentViewController:controller animated:YES completion:Nil];
}
@end
