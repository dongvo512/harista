//
//  ProfileUserViewController.m
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ProfileUserViewController.h"
#import "UserInfoView.h"
#import "CommonDefine.h"
#import "User.h"
#import "ProfileUserCell.h"

#define HEIGHT_CELL 100

@interface ProfileUserViewController (){

    UserInfoView *headerView;
    User *user;
}

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrData;

@end

@implementation ProfileUserViewController

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil User:(User *)aUser{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        user = aUser;
    }
    
    return self;
}

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tblView registerNib:[UINib nibWithNibName:@"ProfileUserCell" bundle:nil] forCellReuseIdentifier:@"ProfileUserCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - Method


#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 20;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   ProfileUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileUserCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
  //  User *user = [self.arrDataSearch objectAtIndex:indexPath.row];
   // [cell setDataForCell:user];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return HEIGHT_CELL;
 }
#pragma mark - Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = nil;
    
    if(!headerView){
        
        headerView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, SW, SW*2/3) User:user];
    }
    
    view = headerView;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SW*2/3;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
    
}
@end
