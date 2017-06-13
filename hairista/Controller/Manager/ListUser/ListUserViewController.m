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
#import "UIColor+Method.h"

#define LIMIT_ITEM @"14"

@interface ListUserViewController ()
    <UISearchBarDelegate>
{
    UIRefreshControl *refreshControl;
   
    NSString *strSearchKey;
    
    NSInteger indexPageSearchAll;
    
    NSInteger indexPageSearchSalon;
    
    BOOL isLoadingData;
    
    BOOL isFullDataAll;
    
    BOOL isFullDataSalon;
    
    NSString *keywordCurr;
    
    BOOL isSearchALL;
}

@property (nonatomic, strong) NSMutableArray *arrUser;
//@property (nonatomic, strong) NSArray *arrDataSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnSearchAll;

@property (weak, nonatomic) IBOutlet UIButton *btnSearchSalon;

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UILabel *lblResult;

@end

@implementation ListUserViewController

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
    
    indexPageSearchSalon = 1;
    indexPageSearchAll = 1;
    
   // [self getListUser:@""];
    keywordCurr = @"";
    [self getListUserSalon:keywordCurr];
    
   // [self createDataTemp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)tpuchBtnSearchAll:(id)sender {
    
    if(isSearchALL){
    
        return;
    }
    
    isSearchALL = YES;
    [self.btnSearchAll setBackgroundColor:[UIColor colorFromHexString:@"BF0A6A"]];
    [self.btnSearchSalon setBackgroundColor:[UIColor lightGrayColor]];

    
    indexPageSearchAll = 1;
    isFullDataAll = NO;
    [self getListUser:keywordCurr];
}

- (IBAction)touchBtnSearchSalon:(id)sender {
    
    if(!isSearchALL){
    
        return;
    }
    
    isSearchALL = NO;
    isFullDataSalon = NO;
    [self.btnSearchSalon setBackgroundColor:[UIColor colorFromHexString:@"BF0A6A"]];
    [self.btnSearchAll setBackgroundColor:[UIColor lightGrayColor]];
    
    indexPageSearchSalon = 1;
    
    [self getListUserSalon:keywordCurr];

}

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

-(void)addUserForSalon:(SessionUser *)user{

    if(user){
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [[AuthenticateManage sharedInstance] addUserForSalonByID:user.idUser dataResult:^(NSError *error, id idObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if(error){
            
                [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
            }
            else{
                
                [Common showAlert:self title:@"Thông báo" message:[NSString stringWithFormat:@"Đã thêm %@ vào salon của bạn",user.name] buttonClick:nil];
            }
        }];
    }

}

-(void)getListUserSalon:(NSString *)keyword{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    [[AuthenticateManage sharedInstance] searchListUserOfSalon:keyword pageIndex:[NSString stringWithFormat:@"%ld",(long)indexPageSearchSalon] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        isLoadingData = NO;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullDataSalon = YES;
            }
            self.arrUser = [NSMutableArray arrayWithArray:arrData];
            
            if(self.arrUser.count > 0){
                self.lblResult.text = [NSString stringWithFormat:@"%ld kết quả",(long)self.arrUser.count];
            }
            else{
            
                self.lblResult.text = @"Không có kết quả";
            }
            
            [self.tblView reloadData];
        }
        
    }];
}
-(void)getListUser:(NSString *)keyword{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    [[AuthenticateManage sharedInstance] searchListUser:keyword pageIndex:[NSString stringWithFormat:@"%ld",(long)indexPageSearchAll] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        isLoadingData = NO;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullDataAll = YES;
            }
            
            self.arrUser = [NSMutableArray arrayWithArray:arrData];
           
            if(self.arrUser.count > 0){
                self.lblResult.text = [NSString stringWithFormat:@"%ld kết quả",(long)self.arrUser.count];
            }
            else{
                
                self.lblResult.text = @"Không có kết quả";
            }

            [self.tblView reloadData];
        }
        
    }];
}

-(void)loadMoreSalon{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    [[AuthenticateManage sharedInstance] searchListUser:self.searchBar.text pageIndex:[NSString stringWithFormat:@"%ld",(long)indexPageSearchSalon] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
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
                
                isFullDataSalon = YES;
            }
        }
        
    }];
}


-(void)loadMoreAll{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    [[AuthenticateManage sharedInstance] searchListUser:self.searchBar.text pageIndex:[NSString stringWithFormat:@"%ld",(long)indexPageSearchAll] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
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
                
                isFullDataAll = YES;
            }
            
        }
        
    }];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    keywordCurr = searchText;
    
    if(searchText.length == 0){
        
        if(isSearchALL){
        
            indexPageSearchAll = 1;
            isFullDataAll = NO;
            [self getListUser:@""];
        }
        else{
        
            indexPageSearchSalon = 1;
            isFullDataSalon = NO;
            [self getListUserSalon:@""];
        }
        
    }
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
     [self.view endEditing:YES];
    
    if(isSearchALL){
        
        indexPageSearchAll = 1;
        
        [self getListUser:searchBar.text];
    }
    else{
        
        indexPageSearchSalon = 1;
        
        [self getListUserSalon:searchBar.text];
    }

}


#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if(isSearchALL){
    
        [cell.btnAddUser setHidden:NO];
        
        cell.widthContraintButtonAdd.constant = 44;
    }
    else{
    
        [cell.btnAddUser setHidden:YES];
        
        cell.widthContraintButtonAdd.constant = 0;
    }
    
    SessionUser *user = [self.arrUser objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell setDataForCell:user];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(!isSearchALL){
    
        if(indexPath.row == self.arrUser.count - 1 && !isLoadingData && !isFullDataSalon){
            
            indexPageSearchSalon ++;
            [self loadMoreSalon];
        }
    }
    else{
    
        if(indexPath.row == self.arrUser.count - 1 && !isLoadingData && !isFullDataAll){
            
            indexPageSearchAll ++;
            [self loadMoreAll];

        }
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
#pragma mark - UserCellDelegate
-(void)touchButtonAddUser:(SessionUser *)user{

    [self addUserForSalon:user];
}

@end
