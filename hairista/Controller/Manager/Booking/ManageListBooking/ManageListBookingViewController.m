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

@interface ManageListBookingViewController (){

    HeaderViewBooking *headerView;
    NSInteger typeBooking;
}

typedef NS_ENUM(NSInteger, TypeBooking) {
    
    Today = 0,
    InWeek,
    InMonth
};

@property (weak, nonatomic) IBOutlet UITableView *tblBooking;
@property (nonatomic,strong) NSMutableArray *arrBooking;

@property (nonatomic, strong) NSArray *arrDate;

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
   
    self.tblBooking.rowHeight = UITableViewAutomaticDimension;
    self.tblBooking.estimatedRowHeight = 79;

    
    [self.tblBooking registerNib:[UINib nibWithNibName:@"ManageBookingCell" bundle:nil] forCellReuseIdentifier:@"ManageBookingCell"];
    
    [self createDataTemp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Metho
- (void)createDataTemp{

    self.arrBooking = [NSMutableArray array];
    
    Booking *booking_1 = [[Booking alloc] init];
    booking_1.strDate = @"9:30 AM";
    booking_1.imgAvtarName = @"ngan_1";
    booking_1.strUserNameBooking = @"Hồ Ngọc Hà";
    booking_1.strUserPhone = @"093123343";
    booking_1.strListService = @"Cắt tóc, gội đầu";
    [self.arrBooking addObject:booking_1];
    
    Booking *booking_2 = [[Booking alloc] init];
    booking_2.strDate = @"11:30 AM";
    booking_2.imgAvtarName = @"ngan_2";
    booking_2.strUserNameBooking = @"Nguyễn Hồng Nhung";
    booking_2.strUserPhone = @"093111111";
    booking_2.strListService = @"Cắt tóc, Matxa";
    [self.arrBooking addObject:booking_2];
    
    Booking *booking_3 = [[Booking alloc] init];
    booking_3.strDate = @"7:30 PM";
    booking_3.strUserNameBooking = @"Tiên Cookie";
    booking_3.strUserPhone = @"0908073123";
    booking_3.imgAvtarName = @"ngan_3";
    booking_3.strListService = @"Nhuộm tóc";
    [self.arrBooking addObject:booking_3];
}


#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    NSInteger num = 0;
    
    switch (typeBooking) {
        case Today:
            num = 1;
            break;
            
        case InWeek:
            num = 7;
            break;
            
        case InMonth:
            num = 30;
            break;
            
        default:
            break;
    }
    
    return num;
}

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

    DetailBookingViewController *vcDetailBooking = [[DetailBookingViewController alloc] initWithNibName:@"DetailBookingViewController" bundle:nil];
    [self.vcManageBooking.navigationController pushViewController:vcDetailBooking animated:YES];
}

#pragma mark - Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = nil;
    
     headerView = [[HeaderViewBooking alloc] initWithFrame:CGRectMake(0, 0, SW, 50)];
    
   /* if(!headerView){
        
       
    }*/
    
    view = headerView;
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
    
}

@end
