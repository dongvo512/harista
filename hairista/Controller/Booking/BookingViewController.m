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
#import "BookingManage.h"
#import "Salon.h"


@interface BookingViewController (){

    NSDate *dateTime;
    NSMutableArray *arrSelected;
    NSInteger totalPrice;
    Salon *salonCurr;
}
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboTime;
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboService;
@property (weak, nonatomic) IBOutlet UITableView *tblService;
@property (weak, nonatomic) IBOutlet UILabel *lbltotalPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;

@property (weak, nonatomic) IBOutlet NCTextFieldView *txtFullName;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraint;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation BookingViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Salon:(Salon *)salon{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        salonCurr = salon;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lblTitle.text = salonCurr.name;
    
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
    
    if(self.txtFullName.txtTextField.text.length == 0){
        
        
        UIAlertController *vcAlert = [UIAlertController alertControllerWithTitle:@"Thông báo" message:@"Bạn chưa nhập họ và tên" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *Oke = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        
        [vcAlert addAction:Oke];
        
        [self presentViewController:vcAlert animated:YES completion:nil];
        
    }


    
    if([self.cboTime getText].length > 0 && [self.cboService getText].length > 0 && self.txtFullName.txtTextField.text.length > 0){
    
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        
        [dic setObject:self.txtFullName.txtTextField.text forKey:@"name"];
        
        [dic setObject:[self createListPrice:arrSelected] forKey:@"price"];
        
        [dic setObject:[NSString stringWithFormat:@"%ld",totalPrice] forKey:@"totalPrice"];
        
        [dic setObject:[Common getStringDisplayFormDate:[NSDate date] andFormatString:@"yyyy-MM-dd HH:mm"] forKey:@"startDate"];
        
        [dic setObject:[self createListId:arrSelected] forKey:@"items"];
        
        
        [[BookingManage sharedInstance] createBooking:dic idSalon:salonCurr.idSalon dataResult:^(NSError *error, id idObject) {
            
            if(error){
            
                [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
            }
            else{
               
              NSString *message = [NSString stringWithFormat:@"Bạn đã đặt chỗ thành công đến Salon:%@",salonCurr.name];
                [Common showAlert:self title:@"Thông báo" message:message buttonClick:nil];
            }
        }];
        
    }
}

-(NSString *)createListId:(NSArray *)arrService{

    NSMutableString *strId = [NSMutableString string];
    
    for(Service *service in arrService){
        
        [strId appendFormat:@"%@,",service.idService];
        
    }
    
    if(strId.length > 0){
        
        [strId deleteCharactersInRange:NSMakeRange(strId.length - 1, 1)];
    }
    
    return strId;

}

-(NSString *)createListPrice:(NSArray *)arrService{

    NSMutableString *strPrice = [NSMutableString string];
    
    for(Service *service in arrService){
        
        [strPrice appendFormat:@"%@,",service.price];
        
    }
    
    if(strPrice.length > 0){
        
        [strPrice deleteCharactersInRange:NSMakeRange(strPrice.length - 1, 1)];
    }
    
    return strPrice;
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
    
    totalPrice = 0;
    
    self.heightContraint.constant = 0;
    
    [self.tblService reloadData];
}

#pragma mar - ServerBookingViewControllerDelegate
-(void)selectedItems:(NSMutableArray *)arrItems controller:(ServerBookingViewController *)controller{

    totalPrice = 0;
    
    NSMutableString *strServices = [NSMutableString string];
    

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
        
        totalPrice = 0;
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
        [self.tblService deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
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
