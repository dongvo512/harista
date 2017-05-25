//
//  DetailBookingViewController.m
//  hairista
//
//  Created by Dong Vo on 2/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "DetailBookingViewController.h"
#import "ServiceBookingCell.h"
#import "BookingManage.h"
#import "Booking.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "Service.h"
#import "ProfileUserViewController.h"

#define HEIGHT_CELL_SERVICE 44

#define STATUS_PENDING @"pending"
#define STATUS_DONE @"done"
#define STATUS_CANCEL @"cancel"

@interface DetailBookingViewController (){

    Booking *bookingCurr;
    
    BOOL isEdit;
}

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraintService;
@property (nonatomic, strong) NSArray *arrService;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblUserBookingName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserBookingPhone;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewUserBookingAvatar;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraintBottom;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;

@end

@implementation DetailBookingViewController

#pragma mark - Init

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil booking:(Booking *)aBooking editing:(BOOL)aEdit{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        isEdit = aEdit;
        bookingCurr = aBooking;
    }
    
    return self;
}

#pragma mark - CircleView
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if([bookingCurr.status isEqualToString:STATUS_PENDING]){
        
        self.heightContraintBottom.constant = 50;
        [self.viewBottom setHidden:NO];
    }
    else{
        
        self.heightContraintBottom.constant = 0;
         [self.viewBottom setHidden:YES];
    }

    
    if(!isEdit){
    
        self.heightContraintBottom.constant = 0;
        [self.viewBottom setHidden:YES];
    }
    
    
    [self.tblView registerNib:[UINib nibWithNibName:@"ServiceBookingCell" bundle:nil] forCellReuseIdentifier:@"ServiceBookingCell"];
    
    self.heightContraintService.constant = 0;
    
//    self.tblView.layer.borderColor = [UIColor whiteColor].CGColor;
//    self.tblView.layer.borderWidth = 0.5;
    
    [self loadDataForUI];
    
    [self getDetailBooking];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)touchBtnInfoUser:(id)sender {
    
    if(isEdit){
        ProfileUserViewController *vcProfile = [[ProfileUserViewController alloc] initWithNibName:@"ProfileUserViewController" bundle:nil User:bookingCurr.user];
        
        [self.navigationController pushViewController:vcProfile animated:YES];
    }

}
- (IBAction)touchBtnAcept:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[BookingManage sharedInstance] updateBooking:bookingCurr.idBooking.stringValue status:STATUS_DONE dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            bookingCurr.status = STATUS_DONE;
            
            if([[self delegate] respondsToSelector:@selector(finishAceptBooking:)]){
            
                [[self delegate] finishAceptBooking:bookingCurr];
            }
            
            [Common showAlert:self title:@"Thông báo" message:@"Xác nhận thành công" buttonClick:^(UIAlertAction *alertAction) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
           
        }
        
    }];
}
- (IBAction)touchBtnCancel:(id)sender {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[BookingManage sharedInstance] updateBooking:bookingCurr.idBooking.stringValue status:STATUS_CANCEL dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            bookingCurr.status = STATUS_CANCEL;
            
            if([[self delegate] respondsToSelector:@selector(finishCancelBooking:)]){
                
                [[self delegate] finishCancelBooking:bookingCurr];
            }
            
            [Common showAlert:self title:@"Thông báo" message:@"Đã huỷ đặt chỗ" buttonClick:^(UIAlertAction *alertAction) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
            
        }
        
    }];
}

#pragma mark - Method

-(void)loadDataForUI{

    NSString *totalPrice = [Common getString3DigitsDot:bookingCurr.totalPrice.integerValue];
    self.lblTotalPrice.text = [NSString stringWithFormat:@"%@ đ",totalPrice];
    
    NSString *dayName = [Common getDayInWeekVietNamese:[Common getDateFromStringFormat:bookingCurr.startDate format:@"yyyy-MM-dd HH:mm:ss"]];
    
    NSString *strStartTime = [Common formattedDateTimeWithDateString:bookingCurr.startDate inputFormat:@"yyyy-MM-dd HH:mm:ss" outputFormat:@"dd/MM/yyyy HH:mm"];
    
    self.lblStartDate.text = [NSString stringWithFormat:@"%@, %@",dayName,strStartTime];
    
    self.lblUserBookingName.text = bookingCurr.user.name;
    
    self.lblUserBookingPhone.text = bookingCurr.user.phone;
    
     [self.imgViewUserBookingAvatar sd_setImageWithURL:[NSURL URLWithString:bookingCurr.user.avatar] placeholderImage:IMG_USER_DEFAULT];
    
   
}

-(void)getDetailBooking{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[BookingManage sharedInstance] getDetailBooking:bookingCurr.idBooking.stringValue dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        [self.viewBackground setHidden:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
            
                self.arrService = [NSArray arrayWithArray:arrData];
                
                self.heightContraintService.constant = HEIGHT_CELL_SERVICE *self.arrService.count;
                
                [self.tblView reloadData];
            }
        }
    }];
}


#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrService.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Service *service = [self.arrService objectAtIndex:indexPath.row];
    
    ServiceBookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceBookingCell"];
 
    [cell setDataForCell:service];
    
    return cell;
}
@end
