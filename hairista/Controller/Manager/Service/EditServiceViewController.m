//
//  EditServiceViewController.m
//  hairista
//
//  Created by Dong Vo on 5/6/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "EditServiceViewController.h"
#import "CategoriesManageCell.h"
#import "Category.h"
#import "ListManageServiceViewController.h"
#import "SalonManage.h"

@interface EditServiceViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrCategories;

@end

@implementation EditServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tblView registerNib:[UINib nibWithNibName:@"CategoriesManageCell" bundle:nil] forCellReuseIdentifier:@"CategoriesManageCell"];
    
    [self getListCategories];
  //  [self createCategories];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)showMenu:(id)sender {
    [[SlideMenuViewController sharedInstance] toggle];
}

#pragma mark - Method
-(void)getListCategories{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListCategoriesProduct:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                self.arrCategories = [NSMutableArray array];
                
                [self.tblView reloadData];
            }
        }
    }];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrCategories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CategoriesManageCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoriesManageCell"];
    Category *category = [self.arrCategories objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblCategoriesName.text = category.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    Salon *salon = [self.arrSalons objectAtIndex:indexPath.row];
//    
//    DetailSalonViewController *vcDetail = [[DetailSalonViewController alloc] initWithNibName:@"DetailSalonViewController" bundle:nil salon:salon];
//    
//    [self.navigationController pushViewController:vcDetail animated:YES];
    
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    if(indexPath.row == self.arrSalons.count - 1 && !isLoadingData &&!isFullData){
//        
//        pageIndex ++;
//        [self loadMoreSalon];
//    }
    
}


//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    Category *cat = [self.arrCategories objectAtIndex:indexPath.row];
//    ListManageServiceViewController *manageServices = [[ListManageServiceViewController alloc] initWithNibName:@"ListManageServiceViewController" bundle:nil];
//    manageServices.titleCategories = cat.name;
//    [self.navigationController pushViewController:manageServices animated:YES];
//}
@end
