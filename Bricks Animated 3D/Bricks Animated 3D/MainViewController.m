//
//  ViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/27/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "MainViewController.h"
#import "SQLiteManager.h"
#import "PreviewLegoViewController.h"
#import "PercentageBarUploadingView.h"
#import "GuideViewController.h"
#import "DownloadManager.h"
#import "MoreAppsViewController.h"
#import "AppDelegate.h"
#import <GoogleMobileAds/GoogleMobileAds.h>

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate, PreviewLegoViewControllerDelegate, DownloadManagerDelegate, GADInterstitialDelegate>{
    NSMutableArray *groups;
    PercentageBarUploadingView *_percentageBarUploadingV;
    DownloadManager *downloadManager;
    Lego *legoSelected;
    BOOL shouldAds;
    AppDelegate *appDelegate;
}
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property(nonatomic, strong) GADInterstitial *interstitial;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    
    appDelegate = [UIApplication sharedApplication].delegate;
    if (![appDelegate.config.moreShow isEqualToString:_more_default_]) {
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"More"
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(actionMore)];
        [rightButton setTitleTextAttributes:@{
                                              NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                              NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                              } forState:UIControlStateNormal];
        [self.navigationItem setRightBarButtonItem:rightButton];
    }
    
    groups = [[SQLiteManager getInstance] getAllLegoGroup];
    
    downloadManager = [[DownloadManager alloc] init];
    [downloadManager setDelegate:self];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (shouldAds && ![appDelegate.config.adsShow isEqualToString:_ads_default_]) {
        shouldAds = NO;
        NSUInteger r = arc4random_uniform(5) + 1;
        if (r == 3) {
            self.interstitial = [self createAndLoadInterstitial];
        }
    }
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)actionLike{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_msg_rating_ message:nil delegate:self cancelButtonTitle:_msg_dismiss_ otherButtonTitles:_msg_rate_it_5_starts_, nil];
    [alert show];
}
- (void)actionMore{
    MoreAppsViewController *moreAppsVC = [MoreAppsViewController new];
    UINavigationController *navC = [[UINavigationController alloc] initWithRootViewController:moreAppsVC];
    [self presentViewController:navC animated:YES completion:^{}];
}
- (void)openLegoDetail{
    legoSelected.legoSteps = [[SQLiteManager getInstance] getLegoStepsWithIDLego:legoSelected.iDLego];
    GuideViewController *guideVC = [[GuideViewController alloc] initWithNibName:@"GuideViewController" bundle:nil];
    [guideVC setLego:legoSelected];
    shouldAds = YES;
    [self.navigationController pushViewController:guideVC animated:YES];
}
- (UIView *) percentageBarUploadingV{
    if( !_percentageBarUploadingV ) {
        _percentageBarUploadingV = [[PercentageBarUploadingView alloc] initWithNibName:@"PercentageBarUploadingView" bundle:nil];
        [_percentageBarUploadingV.view setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    }
    [_percentageBarUploadingV setTextLoading:@""];
    [_percentageBarUploadingV setPercent:0];
    return _percentageBarUploadingV.view;
}
- (void)downloadImgWithIDLego:(NSString*)iDLego{
    [self.view setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar addSubview:self.percentageBarUploadingV];
    NSMutableArray *files = [[NSMutableArray alloc] init];
    for (LegoImage *frame in [[SQLiteManager getInstance] getLegoImagesWithIDLego:iDLego]) {
        DownloadEntry *entry = [[DownloadEntry alloc] init];
        entry.strUrl = frame.urlImage;
        entry.dir = appDelegate.legoType == NORMAL_LEGO_TYPE ? frame.iDLego : [NSString stringWithFormat:@"%@_s", frame.iDLego];
        entry.fileName = [[frame.urlImage componentsSeparatedByString:@"/"] lastObject];
        entry.size = frame.size;
        [files addObject:entry];
    }
    [downloadManager dowloadFilesWith:files];
}
- (GADInterstitial *)createAndLoadInterstitial {
    GADInterstitial *interstitial = [[GADInterstitial alloc] initWithAdUnitID:INTERSTITIAL_ID_ADMOB_PAGE];
    interstitial.delegate = self;
    GADRequest *request = [GADRequest request];
    // Requests test ads on simulators.
    request.testDevices = [NSArray arrayWithObjects:@"GAD_SIMULATOR_ID",
                           @"1485d1faa4c1010a54b384ca9e9944b7", @"f2b1a55b050ac3483e1c17a21a2073f5",
                           nil];
    [interstitial loadRequest:request];
    return interstitial;
}
#pragma mark - TableViewControll Delegate + DataSource methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return ((LegoGroup*)groups[section]).legoes.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return IS_IPAD?100:80;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 24;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *tempView=[[UIView alloc]initWithFrame:CGRectMake(0,0,tableView.frame.size.width,0)];
    tempView.backgroundColor=UIColorFromRGB(0xf8f8f8);
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(7,0,tableView.frame.size.width,24)];
    tempLabel.backgroundColor=[UIColor clearColor];
    tempLabel.textColor = UIColorFromRGB(0x2a9c40); //here you can change the text color of header.
    tempLabel.font = [UIFont fontWithName:@"Helvetica" size:18.f];
    tempLabel.text = ((LegoGroup*)groups[section]).name;
    
    [tempView addSubview:tempLabel];
    return tempView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell.imageView cancelImageRequestOperation];
    [cell.imageView setImage:[UIImage imageNamed:@"icon_placeholder.png"]];
    Lego *lego = ((LegoGroup*)groups[indexPath.section]).legoes[indexPath.row];
    [cell.textLabel setText:lego.name];
    [cell.detailTextLabel setText:[NSString stringWithFormat:appDelegate.legoType == NORMAL_LEGO_TYPE ? @"%lu Details":@"%lu Steps", (unsigned long)lego.totalBricks]];
    [cell.imageView setImageWithURL:[[NSBundle mainBundle] URLForResource:appDelegate.legoType == NORMAL_LEGO_TYPE ? [[lego.icon componentsSeparatedByString:@"."] firstObject] : [NSString stringWithFormat:@"icon%@_s", lego.iDLego] withExtension:[[lego.icon componentsSeparatedByString:@"."] lastObject]]];
    cell.accessoryType = lego.isDownloaded?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    cell.tintColor = UIColorFromRGB(0x2a9c40);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    legoSelected = ((LegoGroup*)groups[indexPath.section]).legoes[indexPath.row];
    if (legoSelected.isDownloaded) {
        [self openLegoDetail];
        
    }else{
        if (appDelegate.legoType == SIMPLE_LEGO_TYPE) {
            [self downloadImgWithIDLego:legoSelected.iDLego];
        }else{
            PreviewLegoViewController *previewVC = [[PreviewLegoViewController alloc] init];
            [previewVC setLego:legoSelected];
            [previewVC setDelegate:self];
            [self.navigationController pushViewController:previewVC animated:YES];
        }
    }
}
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionBeginFromCurrentState
                     animations:(void (^)(void)) ^{
                         cell.imageView.transform=CGAffineTransformMakeScale(1.2, 1.2);
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                             cell.imageView.transform=CGAffineTransformIdentity;
                         } completion:^(BOOL finished) {}];
                     }];
}
#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appDelegate.config.urliTunes]];
    }
}
#pragma mark - PreviewLegoViewControllerDelegate methods
-(void)didTapDownloadLego:(PreviewLegoViewController *)previewLegoVC{
    [self.navigationController popViewControllerAnimated:YES];
    [self downloadImgWithIDLego:previewLegoVC.lego.iDLego];
}
#pragma mark - DownloadManagerDelegate methods
- (void)didFinishedDownloadFilesWith:(NSArray *)filePaths withError:(NSError *)error{
    [self.view setUserInteractionEnabled:YES];
    [_percentageBarUploadingV.view removeFromSuperview];
    if (!error) {
        legoSelected.isDownloaded = YES;
        [[SQLiteManager getInstance] didDownloadedLego:legoSelected.iDLego];
        [_tbView reloadData];
        [self openLegoDetail];
    }else{
        [Utils showAlertWithError:error];
    }
}
- (void)completePercent:(NSInteger)percent{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_percentageBarUploadingV setPercent:percent];
    });
}
#pragma mark - GADInterstitialDelegate methods
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [self.interstitial presentFromRootViewController:self];
}
@end
