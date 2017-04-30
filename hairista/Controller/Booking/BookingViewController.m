//
//  BookingViewController.m
//  hairista
//
//  Created by Dong Vo on 2/9/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "BookingViewController.h"
#import "UIColor+Method.h"
#import "NCComboboxNewView.h"
#import "NCCalendarViewController.h"
#import "ServerBookingViewController.h"
#import "Common.h"
#import "Service.h"
#import "NCTextFieldView.h"
#import "ServerSelectedCell.h"

@interface BookingViewController (){

    NSDate *dateTime;
    NSMutableArray *arrSelected;
}
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboTime;
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboService;
@property (weak, nonatomic) IBOutlet UITableView *tblService;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet NCTextFieldView *txtFullName;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraint;

@end

@implementation BookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.heightContraint.constant = 0;
    
    [self.tblService registerNib:[UINib nibWithNibName:@"ServerSelectedCell" bundle:nil] forCellReuseIdentifier:@"ServerSelectedCell"];
    
    self.btnSearch.layer.borderWidth = 0.5;
    self.btnSearch.layer.borderColor = [UIColor grayTextCombobox].CGColor;
    
    [self.txtFullName setBackgroundColor:[UIColor whiteColor]];
    [self.txtFullName.txtTextField setPlaceholder:@"Nhập họ và tên"];
    self.txtFullName.delegate = self;

    
    [self.cboTime.view setBackgroundColor:[UIColor whiteColor]];
    [self.cboTime setPlaceHolder:@"Chọn thời gian"];
    self.cboTime.delegate = self;
    
    [self.cboService.view setBackgroundColor:[UIColor whiteColor]];
    [self.cboService setPlaceHolder:@"Chọn dịch vụ"];
    self.cboService.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Method

- (IBAction)create:(id)sender {
    
    
    if(!dateTime){
    
        
        UIAlertController *vcAlert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Bạn chưa chọn thời gian" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Oke = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        
        [vcAlert addAction:Oke];
        
        [self presentViewController:vcAlert animated:YES completion:nil];

    }
    
    if(!arrSelected){
        
        
        UIAlertController *vcAlert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Bạn chưa chọn dịch vụ" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Oke = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        
        [vcAlert addAction:Oke];
        
        [self presentViewController:vcAlert animated:YES completion:nil];
        
    }

    
    if([self.cboTime getText].length > 0 && [self.cboService getText].length > 0){
    
        UIAlertController *vcAlert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Đã gửi lịch hẹn của bạn thành công" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Oke = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        
        [vcAlert addAction:Oke];
        
        [self presentViewController:vcAlert animated:YES completion:nil];

    }
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - NCComboboxNewViewDelegate

- (void)didSelect:(CGRect)frame inView:(UIView *)vieParent andType:(NSInteger)type andCombobox:(NCComboboxNewView*)comboboxCurr{

    if([comboboxCurr isEqual:self.cboTime]){
    
        NCCalendarViewController *vcCalendar = [[NCCalendarViewController alloc] initWithDate:dateTime andType:1];
        vcCalendar.delegate = self;
        [vcCalendar presentInParentViewController:self];
    }
    else{
    
        ServerBookingViewController *vcServices = [[ServerBookingViewController alloc] initWithNibName:@"ServerBookingViewController" bundle:nil arrSelected:arrSelected];
        vcServices.delegate = self;
        [self.navigationController pushViewController:vcServices animated:YES];
    }

}

- (void)clearCombobox:(NCComboboxNewView *)comboboxCurr{

    arrSelected = nil;
    self.lbltotalPrice.text = @"0 VNĐ";
    
    self.heightContraint.constant = 0;
    
    [self.tblService reloadData];
}

#pragma mar - ServerBookingViewControllerDelegate
-(void)selectedItems:(NSMutableArray *)arrItems controller:(ServerBookingViewController *)controller{

    NSMutableString *strServices = [NSMutableString string];
    
    NSInteger totalPrice = 0;
    for(Service *service in arrItems){
    
        [strServices appendFormat:@"%@, ",service.name];
        
        totalPrice += service.price.integerValue;
        
    }
    
    if(strServices.length > 0){
    
        [strServices deleteCharactersInRange:NSMakeRange(strServices.length - 2, 2)];
    }
    
    [self.cboService setTextName:strServices];
    self.lbltotalPrice.text = [NSString stringWithFormat:@"%ld ngàn đồng", (long)totalPrice];
    
    arrSelected = [NSMutableArray arrayWithArray:arrItems];
    
    self.heightContraint.constant = arrSelected.count * 50;
    
    [self.tblService reloadData];
    
}
#pragma mark - Table view DataSource - Delegate


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return arrSelected.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Service *service = [arrSelected objectAtIndex:indexPath.row];
    
    ServerSelectedCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServerSelectedCell"];
   
   [cell setDataForCell:service];
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        [arrSelected removeObjectAtIndex:indexPath.row];
        
        NSMutableString *strServices = [NSMutableString stringWithString:@""];
        
        NSInteger totalPrice = 0;
        for(Service *service in arrSelected){
            
            [strServices appendFormat:@"%@, ",service.name];
            
            totalPrice += service.price.integerValue;
            
        }
        
        if(strServices.length > 0){
            
            [strServices deleteCharactersInRange:NSMakeRange(strServices.length - 2, 2)];
        }
        
        [self.cboService setTextName:strServices];
        self.lbltotalPrice.text = [NSString stringWithFormat:@"%ld ngàn đồng", (long)totalPrice];

        self.heightContraint.constant = 50 * arrSelected.count;
        [self.tblService reloadData];
    }
}
#pragma mark - NCCalendarViewControllerDelegate

-(void)selectedCalendar:(NSDate *)date andCalendar:(NCCalendarViewController *)canlendarCurr andType:(NSInteger)type{
    
    UIAlertController *vcAlert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Thời gian không được nhỏ hơn thời gian hiện tại" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Oke = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
    
    
    [vcAlert addAction:Oke];
    
    //&& ![Common isSameDay:date otherDay:[NSDate date]]
    if([date compare:[NSDate date]] == NSOrderedAscending){
        
        [self presentViewController:vcAlert animated:YES completion:nil];
        return;
    }
    
    dateTime = date;
    
    [self.cboTime setTextName:[Common getStringDisplayFormDate:date andFormatString:@"dd/MM/yyyy HH:mm"]];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
