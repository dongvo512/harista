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
#import "SessionUser.h"
#import "ProfileUserCell.h"
#import "BookingManage.h"
#import "Booking.h"
#import "DetailBookingViewController.h"

#define HEIGHT_CELL 120
#define LIMIT_ITEM @"14"

@interface ProfileUserViewController (){

    UserInfoView *headerView;
    SessionUser *user;
    NSInteger indexPage;
    
    BOOL isFullData;
    
    BOOL isLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrDataBooking;

@end

@implementation ProfileUserViewController

#pragma mark - Init

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil User:(SessionUser *)aUser{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        user = aUser;
    }
    
    return self;
}

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    indexPage = 1;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"ProfileUserCell" bundle:nil] forCellReuseIdentifier:@"ProfileUserCell"];
    
    [self getListBookingByUser];
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
-(void)getListBookingByUser{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    isLoading = YES;
    
    [[BookingManage sharedInstance] getListBookingOfUser:user.idUser indexPage:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject, NSString *strError) {
        
        isLoading = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
        
            self.arrDataBooking = [NSMutableArray arrayWithArray:idObject];
            
            if(self.arrDataBooking.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
            
            [self.tblView reloadData];
        }
    }];
}

-(void)loadMore{

    isLoading = YES;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[BookingManage sharedInstance] getListBookingOfUser:user.idUser indexPage:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject, NSString *strError) {
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        isLoading = NO;
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            [self.arrDataBooking addObjectsFromArray:arrData];
           
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }

            [self.tblView reloadData];
        }
    }];

}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrDataBooking.count;
}

 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
   ProfileUserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProfileUserCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     Booking *booking = [self.arrDataBooking objectAtIndex:indexPath.row];
    [cell setDataForCell:booking];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    return HEIGHT_CELL;

}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if( indexPath.row == self.arrDataBooking.count - 1 && !isLoading &&!isFullData){
        
        indexPage ++;
        [self loadMore];
    }
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Booking *booking = [self.arrDataBooking objectAtIndex:indexPath.row];
    
    DetailBookingViewController *vcDetailBooking = [[DetailBookingViewController alloc] initWithNibName:@"DetailBookingViewController" bundle:nil booking:booking editing:NO];
    
    [self.navigationController pushViewController:vcDetailBooking animated:YES];
}

#pragma mark - Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = nil;
    
    if(!headerView){
        
        headerView = [[UserInfoView alloc] initWithFrame:CGRectMake(0, 0, SW, SW/2) User:user];
    }
    
    view = headerView;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SW/2;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
    
}
@end
