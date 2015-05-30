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

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *groups;
}
@property (weak, nonatomic) IBOutlet UITableView *tbView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setTitle:@"Bricks Animated 3D"];
    
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
    Lego *lego = ((LegoGroup*)groups[indexPath.section]).legoes[indexPath.row];
    [cell.textLabel setText:lego.name];
    [cell.detailTextLabel setText:[NSString stringWithFormat:@"%lu Details", (unsigned long)lego.totalBricks]];
    [cell.imageView setImage:[UIImage imageNamed:lego.icon]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Lego *lego = ((LegoGroup*)groups[indexPath.section]).legoes[indexPath.row];
    PreviewLegoViewController *previewVC = [[PreviewLegoViewController alloc] initWithNibName:@"PreviewLegoViewController" bundle:nil];
    [previewVC setLego:lego];
    [self.navigationController pushViewController:previewVC animated:YES];
}
#pragma mark - UIAlertViewDelegate methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != alertView.cancelButtonIndex) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_url_share_]];
    }
}
@end
