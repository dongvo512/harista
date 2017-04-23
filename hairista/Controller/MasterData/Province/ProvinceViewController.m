//
//  ProvinceViewController.m
//  hairista
//
//  Created by Dong Vo on 2/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ProvinceViewController.h"
#import "NCSearchBarView.h"
#import "NCSearchBarView.h"
#import "Province.h"
#import "SingleMasterDataCell.h"
#import "NCScrollLabelView.h"
#import "CommonDefine.h"

@interface ProvinceViewController ()<UITableViewDelegate, UITableViewDataSource>{

    NCSearchBarView *searchBarView;
    
    Province *provinceSelected;
}
@property (weak, nonatomic) IBOutlet UITableView *tblViewProvince;
@property (nonatomic, strong) NSMutableArray *arrSearchData;
@property (nonatomic, strong) NSMutableArray *arrProvinces;

@end

@implementation ProvinceViewController


#pragma mark - Init

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil provinceSelected:(Province *)aProvinceSelected{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        provinceSelected = aProvinceSelected;
    }
    
    return self;
}

#pragma mark - CircleView
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tblViewProvince registerNib:[UINib nibWithNibName:@"SingleMasterDataCell" bundle:nil] forCellReuseIdentifier:@"SingleMasterDataCell"];
    
    self.arrProvinces = [NSMutableArray array];
    self.arrSearchData = [NSMutableArray array];
    
  //  [self createDataTemp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

- (IBAction)clickBtnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)clickBtnSearch:(id)sender {
    
    searchBarView = [NCSearchBarView sharedInstance:self.view.frame];
    [self.view addSubview:searchBarView];
    
    searchBarView.delegate = self;
    
    [searchBarView showSearchBar];

}

//-(void)createDataTemp{
//
//    Province *province_1 = [[Province alloc] init];
//    province_1.idProvince = @"111111111";
//    province_1.provinceName = @"TP.Hồ chí minh";
//    [self.arrProvinces addObject:province_1];
//    
//    Province *province_2 = [[Province alloc] init];
//    province_2.idProvince = @"123123";
//    province_2.provinceName = @"TP.Hà nội";
//    [self.arrProvinces addObject:province_2];
//
//    
//    Province *province_3 = [[Province alloc] init];
//    province_3.idProvince = @"24123123";
//    province_3.provinceName = @"Long an";
//    [self.arrProvinces addObject:province_3];
//
//    
//    Province *province_4 = [[Province alloc] init];
//    province_4.idProvince = @"1827389172";
//    province_4.provinceName = @"Sóc trăng";
//    [self.arrProvinces addObject:province_4];
//
//    
//    Province *province_5 = [[Province alloc] init];
//    province_5.idProvince = @"12318238";
//    province_5.provinceName = @"Hà tĩnh";
//    [self.arrProvinces addObject:province_5];
//
//    self.arrSearchData = self.arrProvinces;
//}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrSearchData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SingleMasterDataCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SingleMasterDataCell"];
   
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Province *province = [self.arrSearchData objectAtIndex:indexPath.row];
    
    if([province.idProvince isEqualToString:provinceSelected.idProvince]){
    
        [cell.imgVSelected setHidden:NO];
        
        [cell.scrName setText:province.provinceName andFont:[UIFont fontWithName:FONT_ROBOTO_MEDIUM size:16.0f]];
        
    }
    else{
    
        [cell.imgVSelected setHidden:YES];
        
        [cell.scrName setText:province.provinceName andFont:[UIFont fontWithName:FONT_ROBOTO_REGULAR size:16.0f]];
    }
   
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Province *province = [self.arrSearchData objectAtIndex:indexPath.row];
    
    if([[self delegate] respondsToSelector:@selector(selectedProvince:controller:)]){
    
        [[self delegate] selectedProvince:province controller:self];
    }
    
    
}
#pragma mark - NCSearchBarViewDelegate

- (void)searchBarTextChange:(UITextField *)textField
           andTextFieldName:(NSString *)strTextFieldName{
    
    if (textField.text.length == 0) {
        
        self.arrSearchData = nil;
        self.arrSearchData = [NSMutableArray arrayWithArray:self.arrProvinces];
        [self.tblViewProvince reloadData];
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"provinceName contains[cd] %@", textField.text];
   // NSLog(@"%@",textField.text);
    
    self.arrSearchData = nil;
    self.arrSearchData = [NSMutableArray arrayWithArray: [self.arrProvinces filteredArrayUsingPredicate:predicate]];
    
    [self.tblViewProvince reloadData];
    
}

- (void)selectedBtnClearText{
    
    self.arrSearchData = nil;
    self.arrSearchData = [NSMutableArray arrayWithArray:self.arrProvinces];
    [self.tblViewProvince reloadData];
}
@end
