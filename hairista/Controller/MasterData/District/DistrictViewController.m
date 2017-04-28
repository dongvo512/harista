//
//  DistrictViewController.m
//  hairista
//
//  Created by Dong Vo on 2/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "DistrictViewController.h"
#import "NCSearchBarView.h"
#import "NCSearchBarView.h"
#import "District.h"
#import "SingleMasterDataCell.h"
#import "NCScrollLabelView.h"
#import "CommonDefine.h"
#import "SalonManage.h"


@interface DistrictViewController ()<UITableViewDelegate, UITableViewDataSource>{
    
    NCSearchBarView *searchBarView;
    
    District *districtSelected;
    
    NSString *idProvince;
}
@property (weak, nonatomic) IBOutlet UITableView *tblViewDistrict;
@property (nonatomic, strong) NSMutableArray *arrSearchData;
@property (nonatomic, strong) NSMutableArray *arrDistricts;

@end

@implementation DistrictViewController


#pragma mark - Init

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil districtSelected:(District *)aDistrictSelected province:(NSString *)idProvinceParent{
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        
        districtSelected = aDistrictSelected;
        idProvince = idProvinceParent;
    }
    
    return self;
}

#pragma mark - CircleView
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tblViewDistrict registerNib:[UINib nibWithNibName:@"SingleMasterDataCell" bundle:nil] forCellReuseIdentifier:@"SingleMasterDataCell"];
    
    self.arrDistricts = [NSMutableArray array];
    self.arrSearchData = [NSMutableArray array];
    
    //  [self createDataTemp];
    [self getListDistrict];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

-(void)getListDistrict{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[SalonManage sharedInstance] getListDistrict:idProvince dataApiResult:^(NSError *error, id idObject) {
        
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){

            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            NSArray *arrDistrict = idObject;
            
            if(arrDistrict.count > 0){
            
                self.arrDistricts = [NSMutableArray arrayWithArray:arrDistrict];
                self.arrSearchData = self.arrDistricts;
                
                [self.tblViewDistrict reloadData];
            }
        }
    }];
    
    
}

- (IBAction)clickBtnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [searchBarView close];
}


- (IBAction)clickBtnSearch:(id)sender {
    
    searchBarView = [NCSearchBarView sharedInstance:self.view.frame];
    [self.view addSubview:searchBarView];
    
    searchBarView.delegate = self;
    
    [searchBarView showSearchBar];
    
}

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
    
    District *district = [self.arrSearchData objectAtIndex:indexPath.row];
    
    if([district.idDistrict.stringValue isEqualToString:districtSelected.idDistrict.stringValue]){
        
        [cell.imgVSelected setHidden:NO];
        
        [cell.scrName setText:district.name andFont:[UIFont fontWithName:FONT_ROBOTO_MEDIUM size:16.0f]];
        
    }
    else{
        
        [cell.imgVSelected setHidden:YES];
        
        [cell.scrName setText:district.name andFont:[UIFont fontWithName:FONT_ROBOTO_REGULAR size:16.0f]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    District *district = [self.arrSearchData objectAtIndex:indexPath.row];
    
    if([[self delegate] respondsToSelector:@selector(selectedDistrict:controller:)]){
        
        [[self delegate] selectedDistrict:district controller:self];
    }
    
     [searchBarView close];
}
#pragma mark - NCSearchBarViewDelegate

- (void)searchBarTextChange:(UITextField *)textField
           andTextFieldName:(NSString *)strTextFieldName{
    
    if (textField.text.length == 0) {
        
        self.arrSearchData = nil;
        self.arrSearchData = [NSMutableArray arrayWithArray:self.arrDistricts];
        [self.tblViewDistrict reloadData];
        return;
    }

    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains[cd] %@", textField.text];
    // NSLog(@"%@",textField.text);
    
    self.arrSearchData = nil;
    self.arrSearchData = [NSMutableArray arrayWithArray: [self.arrDistricts filteredArrayUsingPredicate:predicate]];
    
    [self.tblViewDistrict reloadData];
    
}

-(void)selectedBtnClose{
    
    self.arrSearchData = nil;
    self.arrSearchData = [NSMutableArray arrayWithArray:self.arrDistricts];
    [self.tblViewDistrict reloadData];
}
- (void)selectedBtnClearText{
    
    self.arrSearchData = nil;
    self.arrSearchData = [NSMutableArray arrayWithArray:self.arrDistricts];
    [self.tblViewDistrict reloadData];
}
@end
