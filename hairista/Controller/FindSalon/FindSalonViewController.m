//
//  FindSalonViewController.m
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "FindSalonViewController.h"
#import "Salon.h"
#import "SalonCell.h"
#import "SlideMenuViewController.h"
#import "HeaderBannerView.h"
#import "CommonDefine.h"
#import "UIScrollView+BottomRefreshControl.h"
#import "NearByViewController.h"
#import "SearchSalonAdvanceViewController.h"
#import "DetailSalonViewController.h"
#import "SalonManage.h"

#define LIMIT_ITEM @"1"

typedef NS_ENUM(NSInteger, TypeSalon) {
    
    List_Salon_Hot,
    List_Salon

};

@interface FindSalonViewController ()<UITableViewDelegate, UITableViewDataSource>{

    HeaderBannerView *headerView;
    
    UIRefreshControl *refreshControl;
    
    UIRefreshControl *refreshControlBottom;
    
    BOOL isLoadingData;
    
    BOOL isFullData;
    
    NSInteger pageIndex;
}

@property (nonatomic, strong) NSMutableArray *arrSalons;
@property (nonatomic, strong) NSArray *arrSalonsHot;
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end

@implementation FindSalonViewController

#pragma mark - Init

static FindSalonViewController *sharedInstance = nil;
+ (id)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[FindSalonViewController alloc] initWithNibName:@"FindSalonViewController" bundle:nil];
            
        }
        return sharedInstance;
    }
    
}

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    self.automaticallyAdjustsScrollViewInsets = YES;
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 59;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"SalonCell" bundle:nil] forCellReuseIdentifier:@"SalonCell"];
    
    self.arrSalons = [NSMutableArray array];
   // [self createListSalon];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self getListSalonHot];
    [self getListSalons];
    
    
    refreshControl = [[UIRefreshControl alloc]init];
    [self.tblView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    refreshControlBottom = [[UIRefreshControl alloc]init];
    refreshControlBottom.triggerVerticalOffset = 100.;
    [refreshControlBottom addTarget:self action:@selector(refreshTableBottom) forControlEvents:UIControlEventValueChanged];
    self.tblView.bottomRefreshControl = refreshControlBottom;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Method

- (IBAction)touchBtnSearch:(id)sender {
    
    SearchSalonAdvanceViewController *vcSearchSalon = [[SearchSalonAdvanceViewController alloc] initWithNibName:@"SearchSalonAdvanceViewController" bundle:nil];
    [self.navigationController pushViewController:vcSearchSalon animated:YES];
}


- (IBAction)touchBtnNearBy:(id)sender {
    
    NearByViewController *vcNearBy = [[NearByViewController alloc] initWithNibName:@"NearByViewController" bundle:nil];
    [self.navigationController pushViewController:vcNearBy animated:YES];
    
}

#pragma mark - Get Data

- (void)getListSalonHot{

    [[SalonManage sharedInstance] getListSalons:YES page:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
            
                self.arrSalonsHot = arrData;
                
                [self.tblView reloadSections:[NSIndexSet indexSetWithIndex:List_Salon_Hot] withRowAnimation:UITableViewRowAnimationFade];
            }
        
        }
        
    }];
}
- (void)getListSalons{
    
    [[SalonManage sharedInstance] getListSalons:NO page:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                [self.arrSalons addObjectsFromArray:arrData];
                
                [self.tblView reloadSections:[NSIndexSet indexSetWithIndex:List_Salon] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }

    }];

}

- (void)refreshTable{

    pageIndex = 1;
    
    [self performSelector:@selector(refreshListSalonHot) withObject:nil afterDelay:1.0f];
    
    [self performSelector:@selector(refreshListSalon) withObject:nil afterDelay:1.0f];
}


-(void)refreshListSalonHot{

    isLoadingData = YES;
    
    [[SalonManage sharedInstance] getListSalons:YES page:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isLoadingData = NO;
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                self.arrSalonsHot = arrData;
                headerView = nil;
                [self.tblView reloadSections:[NSIndexSet indexSetWithIndex:List_Salon_Hot] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }
        
         [refreshControl endRefreshing];
    }];

}

-(void)refreshListSalon{

    isLoadingData = YES;
    
    isFullData = NO;
    
    [[SalonManage sharedInstance] getListSalons:NO page:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isLoadingData = NO;
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                self.arrSalons = [NSMutableArray arrayWithArray:arrData];
                
                [self.tblView reloadSections:[NSIndexSet indexSetWithIndex:List_Salon] withRowAnimation:UITableViewRowAnimationFade];
            }
            
        }
        
        [refreshControl endRefreshing];
    }];

}

-(void)loadMoreSalon{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    pageIndex ++;
    
    isLoadingData = YES;
    
    [[SalonManage sharedInstance] getListSalons:NO page:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isLoadingData = NO;
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                [self.arrSalons addObjectsFromArray:arrData];
                
                [self.tblView reloadSections:[NSIndexSet indexSetWithIndex:List_Salon] withRowAnimation:UITableViewRowAnimationFade];
                
                if(arrData.count < LIMIT_ITEM.integerValue){
                
                    isFullData = YES;
                }
            }
            
        }
        
    }];

}

#pragma mark - Action

- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSInteger rows;
    
    if(section == List_Salon_Hot){
        
        rows = 0;
    }
    else{
    
        rows = self.arrSalons.count;
    }
    
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalonCell"];
    Salon *salon = [self.arrSalons objectAtIndex:indexPath.row];
    [cell setDataForCell:salon];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    Salon *salon = [self.arrSalons objectAtIndex:indexPath.row];
    
    DetailSalonViewController *vcDetail = [[DetailSalonViewController alloc] initWithNibName:@"DetailSalonViewController" bundle:nil salon:salon];
    
    [self.navigationController pushViewController:vcDetail animated:YES];
    
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{

    if(indexPath.row == self.arrSalons.count - 1 && !isLoadingData &&!isFullData){
    
        [self loadMoreSalon];
    }

}
/*- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}*/
#pragma mark - Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    
    if(section == List_Salon_Hot && self.arrSalonsHot.count > 0){
    
        if(!headerView){
            
            headerView = [[HeaderBannerView alloc] initWithFrame:CGRectMake(0, 0, SW, SW/2) listSalonHot:self.arrSalonsHot];
        }
        
        view = headerView;
    }
    
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
   
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if(section == List_Salon_Hot){
    
        return (self.arrSalonsHot.count == 0)?1:SW/2;
    }
    else{
    
        return CGFLOAT_MIN;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return CGFLOAT_MIN;
    
}

@end
