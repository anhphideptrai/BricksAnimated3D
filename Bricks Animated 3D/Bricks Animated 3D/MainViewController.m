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

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate, PreviewLegoViewControllerDelegate, DownloadManagerDelegate>{
    NSMutableArray *groups;
    PercentageBarUploadingView *_percentageBarUploadingV;
    DownloadManager *downloadManager;
    Lego *legoSelected;
}
@property (weak, nonatomic) IBOutlet UITableView *tbView;

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
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"More"
                                                                 style:UIBarButtonItemStylePlain
                                                                target:self
                                                                action:@selector(actionMore)];
    [rightButton setTitleTextAttributes:@{
                                       NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                       NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                       } forState:UIControlStateNormal];
    
    [self.navigationItem setLeftBarButtonItem:leftButton];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    groups = [[SQLiteManager getInstance] getAllLegoGroup];
    
    downloadManager = [[DownloadManager alloc] init];
    [downloadManager setDelegate:self];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)actionLike{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:_msg_rating_ message:nil delegate:self cancelButtonTitle:_msg_dismiss_ otherButtonTitles:_msg_rate_it_5_starts_, nil];
    [alert show];
}
- (void)actionMore{
    
}
- (void)openLegoDetail{
    GuideViewController *guideVC = [[GuideViewController alloc] initWithNibName:@"GuideViewController" bundle:nil];
    [guideVC setLego:legoSelected];
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
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%lu Details", (unsigned long)lego.totalBricks]];
    [cell.imageView setImageWithURL:[[NSBundle mainBundle] URLForResource:[[lego.icon componentsSeparatedByString:@"."] firstObject] withExtension:[[lego.icon componentsSeparatedByString:@"."] lastObject]]];
    cell.accessoryType = lego.isDownloaded?UITableViewCellAccessoryCheckmark:UITableViewCellAccessoryNone;
    cell.tintColor = UIColorFromRGB(0x2a9c40);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    legoSelected = ((LegoGroup*)groups[indexPath.section]).legoes[indexPath.row];
    if (legoSelected.isDownloaded) {
        legoSelected.legoSteps = [[SQLiteManager getInstance] getLegoStepsWithIDLego:legoSelected.iDLego];
        [self openLegoDetail];
    }else{
        PreviewLegoViewController *previewVC = [[PreviewLegoViewController alloc] init];
        [previewVC setLego:legoSelected];
        [previewVC setDelegate:self];
        [self.navigationController pushViewController:previewVC animated:YES];
    }
}
#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url_share_]];
    }
}
#pragma mark - PreviewLegoViewControllerDelegate methods
-(void)didTapDownloadLego:(PreviewLegoViewController *)previewLegoVC{
    [self.navigationController popViewControllerAnimated:YES];
    [self.view setUserInteractionEnabled:NO];
    [self.navigationController.navigationBar addSubview:self.percentageBarUploadingV];
    NSMutableArray *files = [[NSMutableArray alloc] init];
    for (LegoImage *frame in [[SQLiteManager getInstance] getLegoImagesWithIDLego:previewLegoVC.lego.iDLego]) {
        DownloadEntry *entry = [[DownloadEntry alloc] init];
        entry.strUrl = frame.urlImage;
        entry.dir = frame.iDLego;
        entry.fileName = [[frame.urlImage componentsSeparatedByString:@"/"] lastObject];
        entry.size = frame.size;
        [files addObject:entry];
    }
    [downloadManager dowloadFilesWith:files];
}
#pragma mark - DownloadManagerDelegate methods
- (void)didFinishedDownloadFilesWith:(NSArray *)filePaths withError:(NSError *)error{
    [self.view setUserInteractionEnabled:YES];
    [_percentageBarUploadingV.view removeFromSuperview];
    if (!error) {
        legoSelected.isDownloaded = YES;
        [[SQLiteManager getInstance] didDownloadedLego:legoSelected.iDLego];
        [_tbView reloadData];
    }else{
        [Utils showAlertWithError:error];
    }
}
- (void)completePercent:(NSInteger)percent{
    dispatch_async(dispatch_get_main_queue(), ^{
        [_percentageBarUploadingV setPercent:percent];
    });
}
@end
