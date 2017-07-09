//
//  UserAdminViewController.m
//  hairista
//
//  Created by Dong Vo on 6/7/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "UserAdminViewController.h"
#import "AuthenticateManage.h"
#import "UserCell.h"
#import "SalonManage.h"

#define LIMIT_ITEM @"14"

@interface UserAdminViewController (){

    BOOL isLoadingData;
    
    BOOL isFullData;
    
    NSString *keyword;
    
    NSInteger indexPage;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrUser;

@end

@implementation UserAdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 80;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    keyword = @"";
    indexPage = 1;
    [self getListUser];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action
- (IBAction)showButtonmenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}

#pragma mark - Method

-(void)updateUserToAdmin:(SessionUser *)user{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] updateUserToSalon:user dataApiResult:^(NSError *error, id idObject, NSString *strError) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
        
            [Common showAlert:self title:@"Thông báo" message:[NSString stringWithFormat:@"Cập nhật người dùng %@ thành salon thành công",user.name] buttonClick:nil];
            
            NSInteger indexUser = [self.arrUser indexOfObject:user];
            
            [self.arrUser removeObject:user];
            
            [self.tblView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexUser inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
        
    }];
    
}

-(void)loadMore{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    [[AuthenticateManage sharedInstance] searchListUser:keyword pageIndex:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject, NSString *strError) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isLoadingData = NO;
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
            
            [self.arrUser addObjectsFromArray:arrData];
            
            [self.tblView reloadData];
        }
        
    }];

}

-(void)getListUser{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    [[AuthenticateManage sharedInstance] searchListUser:keyword pageIndex:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject, NSString *strError) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isLoadingData = NO;
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
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
#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrUser.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.btnAddUser setHidden:YES];
    
    cell.widthContraintButtonAdd.constant = 0;
    
    SessionUser *user = [self.arrUser objectAtIndex:indexPath.row];
    cell.delegate = self;
    [cell setDataForCell:user];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.arrUser.count - 1 && !isLoadingData && !isFullData){
        
        indexPage ++;
        [self loadMore];
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SessionUser *user = [self.arrUser objectAtIndex:indexPath.row];
    
    [self performSelector:@selector(popUpdateUserToSalon:) withObject:user afterDelay:0.01];
    
}

-(void)popUpdateUserToSalon:(SessionUser *)user{

    [Common showAlertCancel:self title:@"Thông báo" message:@"Bạn có chắc muốn chuyển ngừoi dùng này thành Salon" buttonClick:^(UIAlertAction *alertAction) {
        
        [self updateUserToAdmin:user];
        
    } buttonClickCancel:nil];
    
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    keyword = searchText;
    
    if(searchText.length == 0){
     
        isFullData = NO;
        
        indexPage = 1;
        
        [self getListUser];
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.view endEditing:YES];
    
    isFullData = NO;
    
    indexPage = 1;
    
    [self getListUser];
}


@end
