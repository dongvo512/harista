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
#import "PopupCreateCategoryViewController.h"

#define HEIGHT_CELL_CATEGORIES 70

@interface EditServiceViewController (){

    Category *catSelected;
}

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

- (IBAction)touchBtnInsertCategory:(id)sender {
    
    PopupCreateCategoryViewController *vcPopup = [[PopupCreateCategoryViewController alloc] initWithNibName:@"PopupCreateCategoryViewController" bundle:nil edit:NO cateName:@""];
    vcPopup.delegate = self;
    [vcPopup presentInParentViewController:self];
    
}
#pragma mark - PopupCreateCategoryViewControllerDelegate

-(void)touchButtonFinish:(NSString *)catName edit:(BOOL)isEdit{

    if(!self.arrCategories){
        
        self.arrCategories = [NSMutableArray array];
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if(!isEdit){
        
        [[SalonManage sharedInstance] createCategory:catName dataApiResult:^(NSError *error, id idObject, NSString *strError) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if(error){
                
                [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
            }
            else{
                
                Category *cat = idObject;
                
                [Common showAlert:self title:@"Thông báo" message:@"Tạo danh mục mới thành công" buttonClick:^(UIAlertAction *alertAction) {
                    
                    [self.arrCategories addObject:cat];
                    
                    [self.tblView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.arrCategories indexOfObject:idObject] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
                }];
            }
        }];
    }
    else{
    
        [[SalonManage sharedInstance] updateCategory:catSelected.idCategory nameCat:catName dataApiResult:^(NSError *error, id idObject, NSString *strError) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];

            if(error){
            
                [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
            }
            else{
            
                 Category *cat = idObject;
                
                [self.arrCategories replaceObjectAtIndex:[self.arrCategories indexOfObject:catSelected] withObject:cat];
                
                [self.tblView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.arrCategories indexOfObject:cat] inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            }
        }];
    }
    
}
- (IBAction)showMenu:(id)sender {
    [[SlideMenuViewController sharedInstance] toggle];
}

#pragma mark - Method

- (void)deleteCategories:(Category *)cat{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] deleteCategories:cat.idCategory dataApiResult:^(NSError *error, id idObject, NSString *strError) {
      
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Lỗi xoá danh mục" buttonClick:nil];
        }
        else{
            
            NSInteger indexDelete = [self.arrCategories indexOfObject:cat];
            
            [self.arrCategories removeObject:cat];
            
           [self.tblView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexDelete inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
            
        }
        
    }];
    
}

-(void)getListCategories{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListCategoriesProduct:^(NSError *error, id idObject, NSString *strError) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                self.arrCategories = [NSMutableArray arrayWithArray:arrData];
                
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
    cell.delegate = self;
    cell.catCurr = category;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lblCategoriesName.text = category.name;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Category *category = [self.arrCategories objectAtIndex:indexPath.row];
    
    ListManageServiceViewController *vcListService = [[ListManageServiceViewController alloc] initWithNibName:@"ListManageServiceViewController" bundle:nil cat:category];
    vcListService.delegate = self;
    vcListService.titleCategories = category.name;
    [self.navigationController pushViewController:vcListService animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return HEIGHT_CELL_CATEGORIES;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
   
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        [self deleteCategories:[self.arrCategories objectAtIndex:indexPath.row]];
    }
}

#pragma mark - CategoriesManageCellDelegate
-(void)touchButtonEdit:(Category *)cat{

    catSelected = cat;
    
    PopupCreateCategoryViewController *vcPopup = [[PopupCreateCategoryViewController alloc] initWithNibName:@"PopupCreateCategoryViewController" bundle:nil edit:YES cateName:cat.name];
    vcPopup.delegate = self;
    [vcPopup presentInParentViewController:self];
}
#pragma mark - ListManageServiceViewControllerDelegate

-(void)finishCreateService{

    [self getListCategories];
}

@end
