//
//  SearchSalonAdvanceViewController.m
//  hairista
//
//  Created by Dong Vo on 1/31/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SearchSalonAdvanceViewController.h"
#import "SearchOptionSalonCell.h"
#import "ProvinceViewController.h"
#import "Province.h"
#import "NCComboboxNewView.h"
#import "Salon.h"
#import "SalonCell.h"
#import "MBProgressHUD.h"

#define HEIGHT_OPTION_CELL_SHOW 351
#define HEIGHT_OPTION_CELL_NOT_SHOW 44

@interface SearchSalonAdvanceViewController (){

    BOOL isShowSearchOption;
    
    Province *provinceSelected;
    
    SearchOptionSalonCell *cellSearchOption;
}
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) NSMutableArray *arrSalon;
@property (weak, nonatomic) IBOutlet UITableView *tblSearchSalon;

@end

@implementation SearchSalonAdvanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    isShowSearchOption = YES;
    
    self.tblSearchSalon.rowHeight = UITableViewAutomaticDimension;
    self.tblSearchSalon.estimatedRowHeight = 92;
    
    [self.tblSearchSalon registerNib:[UINib nibWithNibName:@"SearchOptionSalonCell" bundle:nil] forCellReuseIdentifier:@"SearchOptionSalonCell"];
    
     [self.tblSearchSalon registerNib:[UINib nibWithNibName:@"SalonCell" bundle:nil] forCellReuseIdentifier:@"SalonCell"];
    
    self.arrData = [NSMutableArray array];
    self.arrSalon = [NSMutableArray array];
    [self.arrData addObject:@"Search Option"];
    [self.arrData addObject:self.arrSalon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

-(void)createDataSalon{
    
    
    Salon *salon_1 = [[Salon alloc] init];
    salon_1.strAddress = @"158 Nguyễn Văn Cừ, Quận 1 Tp.HCM";
    salon_1.strSalonName = @"Beauty Salon 2233";
    salon_1.strPhone = @"0932188608";
    salon_1.strSalonUrl = @"salon_1";
    [self.arrSalon addObject:salon_1];
    
    Salon *salon_2 = [[Salon alloc] init];
    salon_2.strAddress = @"250 Nguyễn Huệ, Quận 1 Tp.HCM";
    salon_2.strSalonName = @"Beauty Salon 1234";
    salon_2.strPhone = @"093123123";
    salon_2.strSalonUrl = @"salon_2";
    [self.arrSalon addObject:salon_2];
    
    
    Salon *salon_3 = [[Salon alloc] init];
    salon_3.strAddress = @"168 Thành Thái Q.10 Tp.HCM";
    salon_3.strSalonName = @"Beauty Salon 7876";
    salon_3.strPhone = @"092135433";
    salon_3.strSalonUrl = @"salon_3";
    [self.arrSalon addObject:salon_3];
    
    
    Salon *salon_4 = [[Salon alloc] init];
    salon_4.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_4.strSalonName = @"Beauty Salon 999";
    salon_4.strPhone = @"0936r464";
    salon_4.strSalonUrl = @"salon_4";
    [self.arrSalon addObject:salon_4];
    
    Salon *salon_5 = [[Salon alloc] init];
    salon_5.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_5.strSalonName = @"Beauty Salon 999";
    salon_5.strPhone = @"091112231";
    salon_5.strSalonUrl = @"salon_3";
    [self.arrSalon addObject:salon_5];
    
    Salon *salon_6 = [[Salon alloc] init];
    salon_6.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_6.strSalonName = @"Beauty Salon 999";
    salon_6.strPhone = @"09456343";
    salon_6.strSalonUrl = @"salon_2";
    [self.arrSalon addObject:salon_6];
    
    Salon *salon_7 = [[Salon alloc] init];
    salon_7.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_7.strSalonName = @"Beauty Salon 999";
    salon_7.strPhone = @"09999977543";
    salon_7.strSalonUrl = @"salon_1";
    [self.arrSalon addObject:salon_7];
    
    Salon *salon_8 = [[Salon alloc] init];
    salon_8.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_8.strSalonName = @"Beauty Salon 999";
    salon_8.strPhone = @"092214353";
    salon_8.strSalonUrl = @"salon_4";
    [self.arrSalon addObject:salon_8];
    
    Salon *salon_9 = [[Salon alloc] init];
    salon_9.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_9.strSalonName = @"Beauty Salon 999";
    salon_9.strPhone = @"090834532";
    salon_9.strSalonUrl = @"salon_5";
    [self.arrSalon addObject:salon_9];
    
    Salon *salon_10 = [[Salon alloc] init];
    salon_10.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_10.strSalonName = @"Beauty Salon 999";
    salon_10.strPhone = @"09992212121";
    salon_10.strSalonUrl = @"salon_3";
    [self.arrSalon addObject:salon_10];
    
    Salon *salon_11 = [[Salon alloc] init];
    salon_11.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_11.strSalonName = @"Beauty Salon 999";
    salon_11.strPhone = @"0977882211";
    salon_11.strSalonUrl = @"salon_1";
    [self.arrSalon addObject:salon_11];
    
}

- (IBAction)touchBtnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - ProvinceViewControllerDelegte
-(void)selectedProvince:(Province *)province controller:(ProvinceViewController *)controller{

    provinceSelected = province;
    
    [cellSearchOption.cboProvince setTextName:provinceSelected.provinceName];
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - SearchOptionSalonCellDelegate

-(void)selectedBtnSearch{

    [self createDataSalon];
    
    isShowSearchOption = NO;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
    [self performSelector:@selector(reload) withObject:nil afterDelay:0.5];
}

-(void)reload{

     [self.tblSearchSalon reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationFade];
    
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
}

-(void)touchCBOProvince{

    ProvinceViewController *vcProvince = [[ProvinceViewController alloc] initWithNibName:@"ProvinceViewController" bundle:nil provinceSelected:provinceSelected];
    vcProvince.delegate = self;
    [self.navigationController pushViewController:vcProvince animated:YES];
}
-(void)touchCBODistrict{

    
}
-(void)touchCBONumberStar{

}

-(void)clearCboProvice{

    provinceSelected = nil;
}
-(void)clearCboDistrict{

}
-(void)clearCboNumberStar{

    
}
-(void)selectedBtnShowMore:(UIButton *)btnSelected{

    isShowSearchOption = !isShowSearchOption;
    
    [self.tblSearchSalon reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if(section == 0){
    
        return 1;
    }
    else{
    
        return self.arrSalon.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
      
        cellSearchOption = [tableView dequeueReusableCellWithIdentifier:@"SearchOptionSalonCell"];
        cellSearchOption.delegate = self;
        cellSearchOption.selectionStyle = UITableViewCellSelectionStyleNone;
        [cellSearchOption setDataForCell:isShowSearchOption];
        return cellSearchOption;
    }
    else{
    
        SalonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalonCell"];
        Salon *salon = [self.arrSalon objectAtIndex:indexPath.row];
        [cell setDataForCell:salon];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0;
    
    if(indexPath.section == 0){
    
        if(isShowSearchOption){
        
             height = HEIGHT_OPTION_CELL_SHOW;
        }
        else{
        
            height = HEIGHT_OPTION_CELL_NOT_SHOW;
        }
    }
    else{
    
        return UITableViewAutomaticDimension;
    }

    return height;
}

@end
