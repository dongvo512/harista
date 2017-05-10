//
//  ListUserViewController.m
//  hairista
//
//  Created by Dong Vo on 2/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ListUserViewController.h"
#import "UserCell.h"
#import "User.h"
#import "UIScrollView+BottomRefreshControl.h"
#import "ProfileUserViewController.h"
#import "SlideMenuViewController.h"
#import "AuthenticateManage.h"


@interface ListUserViewController ()
    <UISearchBarDelegate>
{
    UIRefreshControl *refreshControl;
    UIRefreshControl *refreshControlBottom;
    NSString *strSearchKey;
}

@property (nonatomic, strong) NSMutableArray *arrUser;
@property (nonatomic, strong) NSArray *arrDataSearch;


@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ListUserViewController

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self configUI];
    
    [self searchListUser];
    
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

-(void)searchListUser{

    [[AuthenticateManage sharedInstance] searchListUser:@"" pageIndex:@"1" limit:@"14" dataResult:^(NSError *error, id idObject) {
        
        
        
    }];
}
-(void)configUI{

    refreshControl = [[UIRefreshControl alloc]init];
    [self.tblView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    refreshControlBottom = [[UIRefreshControl alloc]init];
    refreshControlBottom.triggerVerticalOffset = 100.;
    [refreshControlBottom addTarget:self action:@selector(refreshTableBottom) forControlEvents:UIControlEventValueChanged];
    self.tblView.bottomRefreshControl = refreshControlBottom;
    
    
    for (UIView *subview in self.searchBar.subviews)
    {
        for (UIView *subSubview in subview.subviews)
        {
            if ([subSubview conformsToProtocol:@protocol(UITextInputTraits)])
            {
                UITextField *textField = (UITextField *)subSubview;
                [textField setKeyboardAppearance: UIKeyboardAppearanceAlert];
                textField.returnKeyType = UIReturnKeyDone;
                break;
            }
        }
    }
    
    self.searchBar.placeholder = @"Tìm kiếm khách hàng...";
    
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 80;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"UserCell" bundle:nil] forCellReuseIdentifier:@"UserCell"];
    
}

-(void)reloadDataUser{

    if(self.arrUser.count > 0){
        
        [self.arrUser removeAllObjects];
        
        User *user_1 = [[User alloc] init];
        user_1.strFullName = @"Võ Nguyên Đông";
        
        user_1.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
        user_1.strNumberPhone = @"0932188608";
        user_1.strImgAvatar = @"bg_toc_ngan";
        
        [self.arrUser addObject:user_1];
        
        User *user_2 = [[User alloc] init];
        user_2.strFullName = @"Tăng Thanh Hà";
        user_2.strAddress = @"150 Nguyễn Thị Mình Khai, Phường Đa Khao, Quận 1, TP.Hồ chí Mình";
        user_2.strNumberPhone = @"0932457382";
        user_2.strImgAvatar = @"bg_toc_xoan";
        
        [self.arrUser addObject:user_2];
        
        User *user_3 = [[User alloc] init];
        user_3.strFullName = @"Hồ Ngọc Hà";
        user_3.strAddress = @"234 Võ Văn Tần, Phường 2, Quận 3, TP.Hồ chí Mình";
        user_3.strNumberPhone = @"096421233";
        user_3.strImgAvatar = @"ngan_1";
        
        [self.arrUser addObject:user_3];
        
        User *user_4 = [[User alloc] init];
        user_4.strFullName = @"Đông Nhi";
        user_4.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
        user_4.strNumberPhone = @"0911123231";
        user_4.strImgAvatar = @"ngan_3";
        
        [self.arrUser addObject:user_4];
        
        User *user_5 = [[User alloc] init];
        user_5.strFullName = @"Thu Phương";
        user_5.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
        user_5.strNumberPhone = @"0123123";
        user_5.strImgAvatar = @"ngan_4";
        
        [self.arrUser addObject:user_5];
        
        User *user_6 = [[User alloc] init];
        user_6.strFullName = @"Tiên cookie";
        user_6.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
        user_6.strNumberPhone = @"12234312";
        user_6.strImgAvatar = @"ngan_5";
        
        [self.arrUser addObject:user_6];
        
        User *user_7 = [[User alloc] init];
        user_7.strFullName = @"Bùi Thị Thuỷ";
        user_7.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
        user_7.strNumberPhone = @"09344232";
        user_7.strImgAvatar = @"ngan_6";
        
        [self.arrUser addObject:user_7];
        
        User *ngan_7 = [[User alloc] init];
        ngan_7.strFullName = @"Sobin Hoàng Sơn";
        ngan_7.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
        ngan_7.strNumberPhone = @"09567567";
        ngan_7.strImgAvatar = @"ngan_8";
        
        [self.arrUser addObject:ngan_7];
        
        self.arrDataSearch = [NSMutableArray arrayWithArray:self.arrUser];
        
        [self.tblView reloadData];
        
        [refreshControl endRefreshing];
        
    }
}
-(void)loadMoreItem{

    User *user_1 = [[User alloc] init];
    user_1.strFullName = @"Võ Nguyên Đông";
    
    user_1.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_1.strNumberPhone = @"0932188608";
    user_1.strImgAvatar = @"bg_toc_ngan";
    
    [self.arrUser addObject:user_1];
    
    User *user_2 = [[User alloc] init];
    user_2.strFullName = @"Tăng Thanh Hà";
    user_2.strAddress = @"150 Nguyễn Thị Mình Khai, Phường Đa Khao, Quận 1, TP.Hồ chí Mình";
    user_2.strNumberPhone = @"0932457382";
    user_2.strImgAvatar = @"bg_toc_xoan";
    
    [self.arrUser addObject:user_2];
    
    User *user_3 = [[User alloc] init];
    user_3.strFullName = @"Hồ Ngọc Hà";
    user_3.strAddress = @"234 Võ Văn Tần, Phường 2, Quận 3, TP.Hồ chí Mình";
    user_3.strNumberPhone = @"096421233";
    user_3.strImgAvatar = @"ngan_1";
    
    [self.arrUser addObject:user_3];
    
    User *user_4 = [[User alloc] init];
    user_4.strFullName = @"Đông Nhi";
    user_4.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_4.strNumberPhone = @"0911123231";
    user_4.strImgAvatar = @"ngan_3";
    
    [self.arrUser addObject:user_4];
    
    User *user_5 = [[User alloc] init];
    user_5.strFullName = @"Thu Phương";
    user_5.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_5.strNumberPhone = @"0123123";
    user_5.strImgAvatar = @"ngan_4";
    
    [self.arrUser addObject:user_5];
    
    User *user_6 = [[User alloc] init];
    user_6.strFullName = @"Tiên cookie";
    user_6.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_6.strNumberPhone = @"12234312";
    user_6.strImgAvatar = @"ngan_5";
    
    [self.arrUser addObject:user_6];
    
    User *user_7 = [[User alloc] init];
    user_7.strFullName = @"Bùi Thị Thuỷ";
    user_7.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_7.strNumberPhone = @"09344232";
    user_7.strImgAvatar = @"ngan_6";
    
    [self.arrUser addObject:user_7];
    
    User *ngan_7 = [[User alloc] init];
    ngan_7.strFullName = @"Sobin Hoàng Sơn";
    ngan_7.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    ngan_7.strNumberPhone = @"09567567";
    ngan_7.strImgAvatar = @"ngan_8";
    
    [self.arrUser addObject:ngan_7];
    
    self.arrDataSearch = [NSMutableArray arrayWithArray:self.arrUser];
    
    [self.tblView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    [refreshControlBottom endRefreshing];

}
-(void)refreshTable{

    [self performSelector:@selector(reloadDataUser) withObject:nil afterDelay:2];
}

-(void)refreshTableBottom{

    [self performSelector:@selector(loadMoreItem) withObject:nil afterDelay:2];
}

-(void)createDataTemp{

     self.arrUser = [NSMutableArray array];
    
    User *user_1 = [[User alloc] init];
    user_1.strFullName = @"Võ Nguyên Đông";
   
    user_1.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_1.strNumberPhone = @"0932188608";
    user_1.strImgAvatar = @"bg_toc_ngan";
    
    [self.arrUser addObject:user_1];
    
    User *user_2 = [[User alloc] init];
    user_2.strFullName = @"Tăng Thanh Hà";
    user_2.strAddress = @"150 Nguyễn Thị Mình Khai, Phường Đa Khao, Quận 1, TP.Hồ chí Mình";
    user_2.strNumberPhone = @"0932457382";
    user_2.strImgAvatar = @"bg_toc_xoan";
    
    [self.arrUser addObject:user_2];
    
    User *user_3 = [[User alloc] init];
    user_3.strFullName = @"Hồ Ngọc Hà";
    user_3.strAddress = @"234 Võ Văn Tần, Phường 2, Quận 3, TP.Hồ chí Mình";
    user_3.strNumberPhone = @"096421233";
    user_3.strImgAvatar = @"ngan_1";
    
    [self.arrUser addObject:user_3];
    
    User *user_4 = [[User alloc] init];
    user_4.strFullName = @"Đông Nhi";
    user_4.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_4.strNumberPhone = @"0911123231";
    user_4.strImgAvatar = @"ngan_3";
    
    [self.arrUser addObject:user_4];
    
    User *user_5 = [[User alloc] init];
    user_5.strFullName = @"Thu Phương";
    user_5.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_5.strNumberPhone = @"0123123";
    user_5.strImgAvatar = @"ngan_4";
    
    [self.arrUser addObject:user_5];
    
    User *user_6 = [[User alloc] init];
    user_6.strFullName = @"Tiên cookie";
    user_6.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_6.strNumberPhone = @"12234312";
    user_6.strImgAvatar = @"ngan_5";
    
    [self.arrUser addObject:user_6];
    
    User *user_7 = [[User alloc] init];
    user_7.strFullName = @"Bùi Thị Thuỷ";
    user_7.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    user_7.strNumberPhone = @"09344232";
    user_7.strImgAvatar = @"ngan_6";
    
    [self.arrUser addObject:user_7];
    
    User *ngan_7 = [[User alloc] init];
    ngan_7.strFullName = @"Sobin Hoàng Sơn";
    ngan_7.strAddress = @"58/150 Âu Cơ, Phường 9, Quận Tân Bình, TP.Hồ chí Mình";
    ngan_7.strNumberPhone = @"09567567";
    ngan_7.strImgAvatar = @"ngan_8";
    
    [self.arrUser addObject:ngan_7];
    
    self.arrDataSearch = [NSMutableArray arrayWithArray:self.arrUser];
}


-(void)filter{
    
    
    strSearchKey = [strSearchKey stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    if(strSearchKey.length == 0){
    
        self.arrDataSearch = [NSArray arrayWithArray:self.arrUser];
        
        [self.tblView reloadData];
        return;
    }
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"strFullName contains[cd] %@ OR strNumberPhone contains[cd] %@ OR strAddress contains[cd] %@", strSearchKey, strSearchKey, strSearchKey];
    
    self.arrDataSearch = [self.arrUser filteredArrayUsingPredicate:predicate];
    
    [self.tblView reloadData];
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{

    strSearchKey = searchText;
    
    [self performSelector:@selector(filter) withObject:nil afterDelay:0.0];
    
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
     [self.view endEditing:YES];
}


#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrDataSearch.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    User *user = [self.arrDataSearch objectAtIndex:indexPath.row];
    [cell setDataForCell:user];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    User *user = [self.arrDataSearch objectAtIndex:indexPath.row];
    
    ProfileUserViewController *vcProfile = [[ProfileUserViewController alloc] initWithNibName:@"ProfileUserViewController" bundle:nil User:user];
    
    [self.navigationController pushViewController:vcProfile animated:YES];
    
}

/*- (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return 60;
 }*/


@end
