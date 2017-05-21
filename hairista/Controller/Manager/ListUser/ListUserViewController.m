//
//  ListUserViewController.m
//  hairista
//
//  Created by Dong Vo on 2/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ListUserViewController.h"
#import "UserCell.h"
#import "SessionUser.h"
#import "UIScrollView+BottomRefreshControl.h"
#import "ProfileUserViewController.h"
#import "SlideMenuViewController.h"
#import "AuthenticateManage.h"

#define LIMIT_ITEM @"14"

@interface ListUserViewController ()
    <UISearchBarDelegate>
{
    UIRefreshControl *refreshControl;
   
    NSString *strSearchKey;
    
    NSInteger indexPage;
    
    BOOL isLoadingData;
    
    BOOL isFullData;
    
    BOOL isUserOfSalon;
}

@property (nonatomic, strong) NSMutableArray *arrUser;
//@property (nonatomic, strong) NSArray *arrDataSearch;


@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ListUserViewController

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    isUserOfSalon = YES;
    
    [self configUI];
    
    indexPage = 1;
    
    [self getListUser:@""];
    
   // [self createDataTemp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)touchBtnMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}

#pragma mark - Method
-(void)configUI{
    
    self.searchBar.placeholder = @"Tìm kiếm khách hàng...";
    
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 80;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    
}

-(void)getListUser:(NSString *)keyword{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    
    
    [[AuthenticateManage sharedInstance] searchListUser:keyword pageIndex:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        isLoadingData = NO;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
            self.arrUser = [NSMutableArray arrayWithArray:arrData];
            
            [self.tblView reloadData];
        }
        
    }];
}

-(void)loadMore{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    [[AuthenticateManage sharedInstance] searchListUser:self.searchBar.text pageIndex:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        isLoadingData = NO;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
            
                [self.arrUser addObjectsFromArray:arrData];
                
                [self.tblView reloadData];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
            
        }
        
    }];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    if(searchText.length == 0){
   
        indexPage = 1;
        [self getListUser:@""];
    }
    
    //[self performSelector:@selector(filter) withObject:nil afterDelay:0.0];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
     [self.view endEditing:YES];
    
    indexPage = 1;
    
    [self getListUser:searchBar.text];
}


#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SessionUser *user = [self.arrUser objectAtIndex:indexPath.row];
    [cell setDataForCell:user];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.arrUser.count - 1 && !isLoadingData &&!isFullData){
        
        indexPage ++;
        [self loadMore];
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SessionUser *user = [self.arrUser objectAtIndex:indexPath.row];
    
    ProfileUserViewController *vcProfile = [[ProfileUserViewController alloc] initWithNibName:@"ProfileUserViewController" bundle:nil User:user];
    
    [self.navigationController pushViewController:vcProfile animated:YES];
    
}

/*- (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return 60;
 }*/


@end
