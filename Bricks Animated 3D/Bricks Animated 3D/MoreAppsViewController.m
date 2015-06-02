//
//  MoreAppsViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 6/2/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "MoreAppsViewController.h"
#import "AppDelegate.h"

@interface MoreAppsViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *arrApps;
    UITableView *tbView;
    UIActivityIndicatorView *waitingV;
}

@end

@implementation MoreAppsViewController

- (void)loadView{
    [super loadView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.navigationItem setTitle:@"Developer Apps"];
    self.navigationController.navigationBar.tintColor = UIColorFromRGB(0x2a9c40);
    
    UIBarButtonItem *righttButton = [[UIBarButtonItem alloc] initWithTitle:@"Close"
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:self
                                                                    action:@selector(closeView)];
    [righttButton setTitleTextAttributes:@{
                                           NSFontAttributeName: [UIFont fontWithName:@"Helvetica" size:15.f],
                                           NSForegroundColorAttributeName: UIColorFromRGB(0x2a9c40)
                                           } forState:UIControlStateNormal];
    
    [self.navigationItem setRightBarButtonItem:righttButton];
    arrApps = [NSArray new];
    
    tbView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tbView setDataSource:self];
    [tbView setDelegate:self];
    [self.view addSubview:tbView];
    
    waitingV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [waitingV setHidesWhenStopped:YES];
    [self.view addSubview:waitingV];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    if (appDelegate.moreApps) {
        arrApps = appDelegate.moreApps;
        [tbView reloadData];
    }else{
        [tbView setHidden:YES];
        [waitingV startAnimating];
        [[ConfigManager getInstance] loadMoreApp:_url_more_apps_ finished:^(BOOL success, NSArray *moreApps) {
            arrApps = moreApps;
            appDelegate.moreApps = moreApps;
            [tbView setHidden:NO];
            [tbView reloadData];
            [waitingV stopAnimating];
        }];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [tbView setFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height)];
    [waitingV setFrame:CGRectMake((self.view.frame.size.width - waitingV.frame.size.width)/2, self.navigationController.navigationBar.frame.size.height + 10, waitingV.frame.size.width, waitingV.frame.size.height)];
}
- (BOOL)prefersStatusBarHidden {
    return YES;
}
- (void)closeView{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark - TableViewControll Delegate + DataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrApps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return IS_IPAD?100:80;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell.imageView cancelImageRequestOperation];
    [cell.imageView setImage:[UIImage imageNamed:@"ic_more.png"]];
    MoreApp *moreApp = arrApps[indexPath.row];
    [cell.textLabel setText:moreApp.name];
    [cell.detailTextLabel setText:moreApp.descriptionApp];
    [cell.imageView setImageWithURL:[NSURL URLWithString:moreApp.urlImage]];
    cell.tintColor = UIColorFromRGB(0x2a9c40);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MoreApp *moreApp = arrApps[indexPath.row];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:moreApp.urlItunes]];
}
@end
