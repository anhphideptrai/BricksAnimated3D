//
//  ViewController.m
//  Bricks Animated 3D
//
//  Created by Phi Nguyen on 5/27/15.
//  Copyright (c) 2015 Thien Nguyen. All rights reserved.
//

#import "MainViewController.h"
#import "SQLiteManager.h"

@interface MainViewController () <UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *groups;
}
@property (weak, nonatomic) IBOutlet UITableView *tbView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    groups = [[SQLiteManager getInstance] getAllLegoGroup];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
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
    
    UILabel *tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(15,0,tableView.frame.size.width,24)];
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

}

@end
