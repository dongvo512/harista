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


@interface FindSalonViewController ()<UITableViewDelegate, UITableViewDataSource>{

    HeaderBannerView *headerView;
    
    UIRefreshControl *refreshControl;
    
    UIRefreshControl *refreshControlBottom;
}

@property (nonatomic, strong) NSMutableArray *arrSalons;
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
   
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 59;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"SalonCell" bundle:nil] forCellReuseIdentifier:@"SalonCell"];
    
    self.arrSalons = [NSMutableArray array];
    [self createListSalon];
    
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

-(void)createListSalon{

    Salon *salon_1 = [[Salon alloc] init];
    salon_1.strAddress = @"158 Nguyễn Văn Cừ, Quận 1 Tp.HCM";
    salon_1.strSalonName = @"Beauty Salon 2233";
    salon_1.strPhone = @"0932188608";
    salon_1.strSalonUrl = @"salon_1";
    [self.arrSalons addObject:salon_1];
    
    Salon *salon_2 = [[Salon alloc] init];
    salon_2.strAddress = @"250 Nguyễn Huệ, Quận 1 Tp.HCM";
    salon_2.strSalonName = @"Beauty Salon 1234";
    salon_2.strPhone = @"093123123";
    salon_2.strSalonUrl = @"salon_2";
    [self.arrSalons addObject:salon_2];
    
    
    Salon *salon_3 = [[Salon alloc] init];
    salon_3.strAddress = @"168 Thành Thái Q.10 Tp.HCM";
    salon_3.strSalonName = @"Beauty Salon 7876";
    salon_3.strPhone = @"092135433";
    salon_3.strSalonUrl = @"salon_3";
    [self.arrSalons addObject:salon_3];
    
    
    Salon *salon_4 = [[Salon alloc] init];
    salon_4.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_4.strSalonName = @"Beauty Salon 999";
    salon_4.strPhone = @"0936r464";
    salon_4.strSalonUrl = @"salon_4";
    [self.arrSalons addObject:salon_4];
    
    Salon *salon_5 = [[Salon alloc] init];
    salon_5.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_5.strSalonName = @"Beauty Salon 999";
    salon_5.strPhone = @"091112231";
    salon_5.strSalonUrl = @"salon_3";
    [self.arrSalons addObject:salon_5];
    
    Salon *salon_6 = [[Salon alloc] init];
    salon_6.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_6.strSalonName = @"Beauty Salon 999";
    salon_6.strPhone = @"09456343";
    salon_6.strSalonUrl = @"salon_2";
    [self.arrSalons addObject:salon_6];
    
    Salon *salon_7 = [[Salon alloc] init];
    salon_7.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_7.strSalonName = @"Beauty Salon 999";
    salon_7.strPhone = @"09999977543";
    salon_7.strSalonUrl = @"salon_1";
    [self.arrSalons addObject:salon_7];
    
    Salon *salon_8 = [[Salon alloc] init];
    salon_8.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_8.strSalonName = @"Beauty Salon 999";
    salon_8.strPhone = @"092214353";
    salon_8.strSalonUrl = @"salon_4";
    [self.arrSalons addObject:salon_8];
    
    Salon *salon_9 = [[Salon alloc] init];
    salon_9.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_9.strSalonName = @"Beauty Salon 999";
    salon_9.strPhone = @"090834532";
    salon_9.strSalonUrl = @"salon_5";
    [self.arrSalons addObject:salon_9];
    
    Salon *salon_10 = [[Salon alloc] init];
    salon_10.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_10.strSalonName = @"Beauty Salon 999";
    salon_10.strPhone = @"09992212121";
    salon_10.strSalonUrl = @"salon_3";
    [self.arrSalons addObject:salon_10];
    
    Salon *salon_11 = [[Salon alloc] init];
    salon_11.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_11.strSalonName = @"Beauty Salon 999";
    salon_11.strPhone = @"0977882211";
    salon_11.strSalonUrl = @"salon_1";
    [self.arrSalons addObject:salon_11];
}

- (void)addMoreSalon{

    NSMutableArray *arrIndexPath = [NSMutableArray array];
    
    Salon *salon_1 = [[Salon alloc] init];
    salon_1.strAddress = @"158 Nguyễn Văn Cừ, Quận 1 Tp.HCM";
    salon_1.strSalonName = @"Beauty Salon 2233";
    salon_1.strPhone = @"0932188608";
    salon_1.strSalonUrl = @"salon_1";
    [self.arrSalons addObject:salon_1];
    NSIndexPath *indexPath_1 = [NSIndexPath indexPathForRow:[self.arrSalons indexOfObject:salon_1] inSection:0];
    [arrIndexPath addObject:indexPath_1];
    

    Salon *salon_2 = [[Salon alloc] init];
    salon_2.strAddress = @"250 Nguyễn Huệ, Quận 1 Tp.HCM";
    salon_2.strSalonName = @"Beauty Salon 1234";
    salon_2.strPhone = @"093123123";
    salon_2.strSalonUrl = @"salon_2";
    [self.arrSalons addObject:salon_2];
    NSIndexPath *indexPath_2 = [NSIndexPath indexPathForRow:[self.arrSalons indexOfObject:salon_2] inSection:0];
    [arrIndexPath addObject:indexPath_2];
    
    
    Salon *salon_3 = [[Salon alloc] init];
    salon_3.strAddress = @"168 Thành Thái Q.10 Tp.HCM";
    salon_3.strSalonName = @"Beauty Salon 7876";
    salon_3.strPhone = @"092135433";
    salon_3.strSalonUrl = @"salon_3";
    [self.arrSalons addObject:salon_3];
    NSIndexPath *indexPath_3 = [NSIndexPath indexPathForRow:[self.arrSalons indexOfObject:salon_3] inSection:0];
    [arrIndexPath addObject:indexPath_3];
    
    
    Salon *salon_4 = [[Salon alloc] init];
    salon_4.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_4.strSalonName = @"Beauty Salon 999";
    salon_4.strPhone = @"0936r464";
    salon_4.strSalonUrl = @"salon_4";
    [self.arrSalons addObject:salon_4];
    NSIndexPath *indexPath_4 = [NSIndexPath indexPathForRow:[self.arrSalons indexOfObject:salon_4] inSection:0];
    [arrIndexPath addObject:indexPath_4];
    
    Salon *salon_5 = [[Salon alloc] init];
    salon_5.strAddress = @"123 Nguyễn Thị Minh Khai Q.3 Tp.HCM";
    salon_5.strSalonName = @"Beauty Salon 999";
    salon_5.strPhone = @"091112231";
    salon_5.strSalonUrl = @"salon_3";
    [self.arrSalons addObject:salon_5];
    NSIndexPath *indexPath_5 = [NSIndexPath indexPathForRow:[self.arrSalons indexOfObject:salon_5] inSection:0];
    [arrIndexPath addObject:indexPath_5];
    
    [self.tblView insertRowsAtIndexPaths:arrIndexPath withRowAnimation:NO];
    [refreshControlBottom endRefreshing];
}
- (void)refreshTableBottom{

     [self performSelector:@selector(addMoreSalon) withObject:nil afterDelay:2.0f];
}
- (void)refreshTable{

    [self performSelector:@selector(finishRefresh) withObject:nil afterDelay:2.0f];
}
-(void)finishRefresh{

    [self.arrSalons removeAllObjects];
    
    [self createListSalon];
    
    [self.tblView reloadData];
    [refreshControl endRefreshing];
}
- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrSalons.count;
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

/*- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}*/
#pragma mark - Header
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *view = nil;
    
    if(!headerView){
    
        headerView = [[HeaderBannerView alloc] initWithFrame:CGRectMake(0, 0, SW, SW/2)];
    }
    
    view = headerView;
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return SW/2;
    
}

@end
