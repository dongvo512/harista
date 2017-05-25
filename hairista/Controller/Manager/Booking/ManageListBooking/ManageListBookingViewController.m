//
//  ManageListBookingViewController.m
//  hairista
//
//  Created by Dong Vo on 2/12/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ManageListBookingViewController.h"
#import "Booking.h"
#import "Common.h"
#import "ManageBookingCell.h"
#import "HeaderViewBooking.h"
#import "CommonDefine.h"
#import "DetailBookingViewController.h"
#import "ManageBookingViewController.h"
#import "BookingManage.h"
#import "Date.h"

#define LIMIT_ITEM @"14"

@interface ManageListBookingViewController (){

    HeaderViewBooking *headerView;
    NSInteger typeBooking;
    NSInteger indexPage;
}

typedef NS_ENUM(NSInteger, TypeBooking) {
    
    Today = 0,
    InWeek,
    InMonth
};

@property (weak, nonatomic) IBOutlet UITableView *tblBooking;
@property (nonatomic,strong) NSMutableArray *arrBooking;

@end

@implementation ManageListBookingViewController

#pragma mark - Init

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(NSInteger)type{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        typeBooking = type;
    }
    
    return self;
}


#pragma mark - CircleView
- (void)viewDidLoad {
    [super viewDidLoad];
   
    indexPage = 1;
    
    self.tblBooking.rowHeight = UITableViewAutomaticDimension;
    self.tblBooking.estimatedRowHeight = 79;

    
    [self.tblBooking registerNib:[UINib nibWithNibName:@"ManageBookingCell" bundle:nil] forCellReuseIdentifier:@"ManageBookingCell"];
    
    switch (typeBooking) {
        case InWeek:
            [self getListBookingWeek];
            break;
        case Today:
            [self getListBookingToday];
            break;
        case InMonth:
            [self getListBookingMonth];
            break;
            
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

-(void)getListBookingToday{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
   NSString *today = [Common getStringDisplayFormDate:[NSDate date] andFormatString:@"yyyy-MM-dd"];
    
    [[BookingManage sharedInstance] getListBookingOfSalon:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM startDate:today endDate:today dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                self.arrBooking = [NSMutableArray arrayWithArray:arrData];
                [self.tblBooking reloadData];
            }
        }
        
        
    }];
    
    
//    [[BookingManage sharedInstance] getListBookingOfMe:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM startDate:today endDate:today dataResult:^(NSError *error, id idObject) {
//        
//        [MBProgressHUD hideHUDForView:self.view animated:YES];
//        
//        if(error){
//            
//            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
//        }
//        else{
//            
//            NSArray *arrData = idObject;
//            
//            if(arrData.count > 0){
//                
//                self.arrBooking = [NSMutableArray arrayWithArray:arrData];
//                [self.tblBooking reloadData];
//            }
//        }
//        
//    }];
}

-(void)getListBookingMonth{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
     Date *dateWeek = [Common getStartEndDate:NSCalendarUnitMonth formatOutPut:@"yyyy-MM-dd"];
    
    [[BookingManage sharedInstance] getListBookingOfSalon:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM startDate:dateWeek.startDate endDate:dateWeek.endDate dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                self.arrBooking = [NSMutableArray arrayWithArray:arrData];
                [self.tblBooking reloadData];
            }
        }
        
    }];
}

-(void)getListBookingWeek{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    Date *dateWeek = [Common getStartEndDate:NSCalendarUnitWeekOfMonth formatOutPut:@"yyyy-MM-dd"];
    
    [[BookingManage sharedInstance] getListBookingOfSalon:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM startDate:dateWeek.startDate endDate:dateWeek.endDate dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
            
                self.arrBooking = [NSMutableArray arrayWithArray:arrData];
                [self.tblBooking reloadData];
            }
        }
        
    }];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrBooking.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ManageBookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ManageBookingCell"];
    Booking *booking = [self.arrBooking objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataForCell:booking];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Booking *booking = [self.arrBooking objectAtIndex:indexPath.row];
    
    DetailBookingViewController *vcDetailBooking = [[DetailBookingViewController alloc] initWithNibName:@"DetailBookingViewController" bundle:nil booking:booking editing:YES];
    vcDetailBooking.delegate = self;
    [self.vcManageBooking.navigationController pushViewController:vcDetailBooking animated:YES];
}
#pragma mark - DetailBookingViewControllerDelegate

-(void)finishAceptBooking:(Booking *)booking{

    if([self.arrBooking containsObject:booking]){
    
        [self.tblBooking reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.arrBooking indexOfObject:booking] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }
}
-(void)finishCancelBooking:(Booking *)booking{

    if([self.arrBooking containsObject:booking]){
        
        [self.tblBooking reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.arrBooking indexOfObject:booking] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
    }

}

@end
