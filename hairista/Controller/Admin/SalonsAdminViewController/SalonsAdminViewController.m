//
//  SalonsAdminViewController.m
//  hairista
//
//  Created by Dong Vo on 6/7/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SalonsAdminViewController.h"
#import "SalonManage.h"
#import "UIColor+Method.h"
#import "SalonAdminCell.h"
#import "Salon.h"
#import "DetailSalonViewController.h"
#import "SalonManage.h"

#define LIMIT_ITEM @"14"

@interface SalonsAdminViewController (){

    NSInteger pageIndex;
    
    BOOL isLoadingData;
    
    BOOL isFullData;
    
    NSString *keyword;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrSalon;
@property (weak, nonatomic) IBOutlet UISearchBar *searchbar;


@end

@implementation SalonsAdminViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 103;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"SalonAdminCell" bundle:nil] forCellReuseIdentifier:@"SalonAdminCell"];
    keyword = @"";
    pageIndex = 1;
    
    [self getListSalon];
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

-(void)updateSalonToUser:(Salon *)salon{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] updateSalonToUser:salon dataApiResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
             [Common showAlert:self title:@"Thông báo" message:@"Cập nhật Salon thành người dùng thành công" buttonClick:nil];
            
            NSInteger indexSalon = [self.arrSalon indexOfObject:salon];
            
            [self.arrSalon removeObject:salon];
            
            [self.tblView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexSalon inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];

}

-(void)updateSalon:(Salon *)salon{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] updateSalonOnBoard:salon dataApiResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            [Common showAlert:self title:@"Thông báo" message:@"Cập nhật Salon thành công" buttonClick:nil];
            
            [self.tblView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.arrSalon indexOfObject:salon] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
    
}

-(void)loadMoreSalon{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    isLoadingData = YES;
    
    [[SalonManage sharedInstance] getListSalonNearBy:@"" longLocation:@"" pageindex:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM provinceid:@"" district:@"" name:keyword dataApiResult:^(NSError *error, id idObject) {
        
        isLoadingData = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            [self.arrSalon addObjectsFromArray:arrData];
            
            if(arrData.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
            
            [self.tblView reloadData];
        }
    }];
}

-(void)getListSalon{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoadingData = YES;
    
    [[SalonManage sharedInstance] getListSalonNearBy:@"" longLocation:@"" pageindex:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM provinceid:@"" district:@"" name:keyword dataApiResult:^(NSError *error, id idObject) {
        
        isLoadingData = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            self.arrSalon = [NSMutableArray arrayWithArray:idObject];
            
            if(self.arrSalon.count == 0){
                
                [Common showAlert:self title:@"Thông báo" message:@"Không tìm thấy Salon nào" buttonClick:nil];
            }
            
            if(self.arrSalon.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
            
            [self.tblView reloadData];
            
        }
    }];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrSalon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalonAdminCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalonAdminCell"];
    Salon *salon = [self.arrSalon objectAtIndex:indexPath.row];
    cell.delegate = self;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataForCell:salon];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Salon *salon = [self.arrSalon objectAtIndex:indexPath.row];
    
    [self performSelector:@selector(showPopup:) withObject:salon afterDelay:0.01];
}

-(void)showPopup:(Salon *)salon{

    if(![salon.isShowOnBoard boolValue]){
        
        [Common showAlertCancel:self title:@"Thông báo" message:[NSString stringWithFormat:@"Bạn có chắc muốn chọn salon %@ lên TOP",salon.name] buttonClick:^(UIAlertAction *alertAction) {
            
            salon.isShowOnBoard = @(1);
            
            [self updateSalon:salon];
            
        } buttonClickCancel:nil];
        
    }
    else{
        
        [Common showAlertCancel:self title:@"Thông báo" message:[NSString stringWithFormat:@"Bạn có chắc muốn chọn salon %@ trở về bình thường",salon.name] buttonClick:^(UIAlertAction *alertAction) {
            
            salon.isShowOnBoard = @(0);
            
            [self updateSalon:salon];
            
        } buttonClickCancel:nil];
    }
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.arrSalon.count - 1 && !isLoadingData &&!isFullData){
        
        pageIndex ++;
        [self loadMoreSalon];
    }
    
}

#pragma mark - SalonAdminCellDelegate
-(void)touchBtnToUser:(Salon *)salon{

    [self performSelector:@selector(popupChangeSalonToUser:) withObject:salon afterDelay:0.01];
}

-(void)popupChangeSalonToUser:(Salon *)salon{

   [Common showAlertCancel:self title:@"Thông báo" message:[NSString stringWithFormat:@"Bạn có chắc muốn chuyển salon %@ này thành người dùng bình thường",salon.name] buttonClick:^(UIAlertAction *alertAction) {
       
       [self updateSalonToUser:salon];
       
   } buttonClickCancel:nil];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    keyword = searchText;
    
    if(searchText.length == 0){
        
        isFullData = NO;
        pageIndex = 1;
        
        [self getListSalon];
        
    }
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    [self.view endEditing:YES];
    
    pageIndex = 1;
    
    [self getListSalon];
}
@end
