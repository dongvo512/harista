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
#import "DistrictViewController.h"
#import "District.h"
#import "SalonManage.h"
#import "DetailSalonViewController.h"
#import <CoreLocation/CoreLocation.h>

#define HEIGHT_OPTION_CELL_SHOW 307

#define HEIGHT_OPTION_CELL_NOT_SHOW 44

#define LIMIT_ITEM @"14"

@interface SearchSalonAdvanceViewController ()<CLLocationManagerDelegate>{

    BOOL isShowSearchOption;
    
    BOOL isLocationUser;
    
    Province *provinceSelected;
    District *districtSelected;
    
    SearchOptionSalonCell *cellSearchOption;
    
    CLLocationManager *localManager;
    
    NSString *latLocation;
    NSString *longLocation;
    
    BOOL isSwitchOnCurr;
    
    NSInteger indexPage;
    
    BOOL isFullData;
}
@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) NSMutableArray *arrSalon;
@property (weak, nonatomic) IBOutlet UITableView *tblSearchSalon;

@end

@implementation SearchSalonAdvanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
   // latLocation = @"10.777924";
   // longLocation = @"106.690980";
    indexPage = 1;
    self.arrSalon = [NSMutableArray array];
    
    latLocation = @"";
    longLocation = @"";
    
    isShowSearchOption = YES;
    
    self.tblSearchSalon.rowHeight = UITableViewAutomaticDimension;
    self.tblSearchSalon.estimatedRowHeight = 92;
    
    [self.tblSearchSalon registerNib:[UINib nibWithNibName:@"SearchOptionSalonCell" bundle:nil] forCellReuseIdentifier:@"SearchOptionSalonCell"];
    
     [self.tblSearchSalon registerNib:[UINib nibWithNibName:@"SalonCell" bundle:nil] forCellReuseIdentifier:@"SalonCell"];
    
    self.arrData = [NSMutableArray array];
    self.arrSalon = [NSMutableArray array];
    [self.arrData addObject:@"Search Option"];
    [self.arrData addObject:self.arrSalon];
    
    
    localManager = [[CLLocationManager alloc] init];
    
    localManager.delegate = self;
    localManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    if([localManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        
         [localManager requestWhenInUseAuthorization];
        
         [localManager startUpdatingLocation];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - GetData

-(void)getListSalonNearby{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListSalonNearBy:(isSwitchOnCurr)?latLocation:@"" longLocation:(isSwitchOnCurr)?longLocation:@"" pageindex:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM provinceid:provinceSelected.idProvince.stringValue district:districtSelected.idDistrict.stringValue name:@"" dataApiResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            self.arrSalon = idObject;
            
            if(self.arrSalon.count == 0){
            
                [Common showAlert:self title:@"Thông báo" message:@"Không tìm thấy Salon nào" buttonClick:nil];
                
                isShowSearchOption = YES;
            }
            
            [self.tblSearchSalon reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationFade];

        }
        
    }];
}

-(void)loadMore{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListSalonNearBy:(isSwitchOnCurr)?latLocation:@"" longLocation:(isSwitchOnCurr)?longLocation:@"" pageindex:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM provinceid:provinceSelected.idProvince.stringValue district:districtSelected.idDistrict.stringValue name:@"" dataApiResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
            
                [self.arrSalon addObjectsFromArray:arrData];
                
                [self.tblSearchSalon reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)] withRowAnimation:UITableViewRowAnimationFade];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
        }
        
    }];
}

#pragma mark - Method

- (IBAction)touchBtnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        isLocationUser = YES;
        
        latLocation = [NSString stringWithFormat:@"%f", currentLocation.coordinate.longitude];
        longLocation = [NSString stringWithFormat:@"%f", currentLocation.coordinate.latitude];
        
//        latLocation = @"";
//        longLocation = @"";
        
        //NSLog(@"long: %@",latLocation);
        //NSLog(@"lat: %@",longLocation);
        
         [self.tblSearchSalon reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    // Stop Location Manager
    [localManager stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    // NSLog(@"%@",error.userInfo);
    if([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied){
            
        isLocationUser = NO;
        [Common showAlert:self title:@"Thông báo" message:@"Bạn chưa xác nhận định vị toạ độ" buttonClick:nil];
        }
    }
}

#pragma mark - DistrictViewControllerDelegte
-(void)selectedDistrict:(District *)district controller:(DistrictViewController *)controller{

    if(district.idDistrict.integerValue == districtSelected.idDistrict.integerValue){
    
        return;
    }
    
    districtSelected = district;
    
    [cellSearchOption.cboDistrict setTextName:districtSelected.name];
    
   [controller.navigationController popViewControllerAnimated:YES];

}
#pragma mark - ProvinceViewControllerDelegte
-(void)selectedProvince:(Province *)province controller:(ProvinceViewController *)controller{

    if(province.idProvince.integerValue == provinceSelected.idProvince.integerValue){
    
        return;
    }
    
    provinceSelected = province;
    
    [cellSearchOption.cboProvince setTextName:provinceSelected.provinceName];
    
    districtSelected = nil;
    [cellSearchOption.cboDistrict setTextName:@""];
    
    [controller.navigationController popViewControllerAnimated:YES];
}

#pragma mark - SearchOptionSalonCellDelegate

-(void)switchChangeValue:(BOOL)isSwitchOn{

    isSwitchOnCurr = isSwitchOn;
}
-(void)selectedBtnSearch{
    
    isShowSearchOption = NO;
    
    indexPage = 1;
    isFullData = NO;
    
    [self getListSalonNearby];
    
}

-(void)touchCBOProvince{

    ProvinceViewController *vcProvince = [[ProvinceViewController alloc] initWithNibName:@"ProvinceViewController" bundle:nil provinceSelected:provinceSelected];
    vcProvince.delegate = self;
    [self.navigationController pushViewController:vcProvince animated:YES];
}
-(void)touchCBODistrict{

    if(!provinceSelected){
        
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Bạn chưa chọn tỉnh/thành" buttonClick:nil];
        return;
    }

    
    DistrictViewController *vcDistrict = [[DistrictViewController alloc] initWithNibName:@"DistrictViewController" bundle:nil districtSelected:districtSelected province:provinceSelected.idProvince.stringValue];
   
    vcDistrict.delegate = self;
    [self.navigationController pushViewController:vcDistrict animated:YES];
}

-(void)clearCboProvice{

    provinceSelected = nil;
    
    districtSelected = nil;

}

-(void)clearCboDistrict{

    districtSelected = nil;
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
        [cellSearchOption setDataForCell:isShowSearchOption location:isLocationUser];
        if(provinceSelected){
        
            [cellSearchOption.cboProvince setTextName:provinceSelected.provinceName];
        }
        
        if(districtSelected){
        
            [cellSearchOption.cboDistrict setTextName:districtSelected.name];
        }
        
        return cellSearchOption;
    }
    else{
    
        SalonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalonCell"];
        Salon *salon = [self.arrSalon objectAtIndex:indexPath.row];
        [cell setDataForCell:salon];
        [cell.contentView setBackgroundColor:[UIColor whiteColor]];
        
        if(indexPath.row == self.arrSalon.count - 1 && !isFullData){
        
            indexPage ++;
            [self loadMore];
        }
        
        return cell;
    }

}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat height = 0;
    
    if(indexPath.section == 0){
    
        if(isShowSearchOption){
        
            height = (isLocationUser)?HEIGHT_OPTION_CELL_SHOW:HEIGHT_OPTION_CELL_SHOW - 44;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Salon *salon = [self.arrSalon objectAtIndex:indexPath.row];
    
    DetailSalonViewController *vcDetail = [[DetailSalonViewController alloc] initWithNibName:@"DetailSalonViewController" bundle:nil salon:salon];
    
    [self.navigationController pushViewController:vcDetail animated:YES];
    
}
@end
