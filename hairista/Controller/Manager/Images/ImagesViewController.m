//
//  ImagesViewController.m
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ImagesViewController.h"
#import "SlideMenuViewController.h"
#import "Image.h"
#import "HairFullView.h"
#import "ImgIndexCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SalonManage.h"
#import "UploadImageViewController.h"
#import "BVReorderTableView.h"

#define LIMIT_ITEM @"14"

@interface ImagesViewController ()<ReorderTableViewDelegate, ReorderTableViewDelegate>{
    
    NSInteger indexPage;
    
    BOOL isFullData;
    
    BOOL isLoading;
}

@property (weak, nonatomic) IBOutlet BVReorderTableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrImages;
@end

@implementation ImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    indexPage = 1;
   
    [self.tblView registerNib:[UINib nibWithNibName:@"ImgIndexCell" bundle:nil] forCellReuseIdentifier:@"ImgIndexCell"];
  //  [self.tblView setEditing:YES animated:YES];
    
    
    [self reloadListSalon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)touchBtnPin:(id)sender {
    
    [self updateListImageWithIndex];
}

- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}

- (IBAction)touchBtnUpload:(id)sender {
    
    UploadImageViewController *vcUploadImage = [[UploadImageViewController alloc] initWithNibName:@"UploadImageViewController" bundle:nil];
    vcUploadImage.delegate = self;
    [self.navigationController pushViewController:vcUploadImage animated:YES];
}

#pragma mark - UploadImageViewControllerDelegate
-(void)finishUploadImages:(UploadImageViewController *)controller{

    [controller.navigationController popViewControllerAnimated:YES];
    indexPage = 1;
    [self reloadListSalon];
}
#pragma mark - GetData

-(NSDictionary *)createListIndexDic{

    NSMutableArray *arrDic = [NSMutableArray array];
    
    NSInteger totalItem = 0;
  
    if(self.arrImages.count < 10){
    
        totalItem = self.arrImages.count;
    }
    else{
    
        totalItem = 10;
    }
    
    for(int i = 0; i < totalItem; i++){
    
        Image *img = [self.arrImages objectAtIndex:i];
        NSDictionary *dic = @{@"id":img.idImage,@"order":[NSString stringWithFormat:@"%ld",(long)img.index]};
        [arrDic addObject:dic];
    }
    
    NSDictionary *dic = @{@"images":arrDic};
    
    return dic;
}

-(void)setUpIndexForList:(NSMutableArray *)listImage{

    NSInteger totalItem = 0;
    
    if(listImage.count < LIMIT_ITEM.integerValue){
    
        totalItem = listImage.count;
    }
    else{
    
        totalItem = LIMIT_ITEM.integerValue;
    }
    
    for(int i = 0; i < totalItem; i++){
    
        Image *image = [listImage objectAtIndex:i];
        
        image.index = i + 1;
    }
}

-(void)reloadListSalon{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoading = YES;
    
    [[SalonManage sharedInstance] getListImageSalon:Appdelegate_hairista.sessionUser.idUser page:@"1" limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isLoading = NO;
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            self.arrImages = [NSMutableArray arrayWithArray:arrData];
            [self setUpIndexForList:self.arrImages];
            [self.tblView reloadData];
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
        }
    }];
}

-(void)updateListImageWithIndex{

    if(self.arrImages.count == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Không có hình ảnh để sắp xếp, vui lòng upload thêm hình ảnh" buttonClick:nil];
        
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
   
    [[SalonManage sharedInstance] updateMultiIndexImage:[self createListIndexDic] dataApiResult:^(NSError *error, id idObject) {
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
      
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            [Common showAlert:self title:@"Thông báo" message:@"Cập nhật thứ tự hình ảnh thành công" buttonClick:nil];
        }
    }];
}

-(void)getListImageSalon{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoading = YES;
    
    [[SalonManage sharedInstance] getListImageSalon:Appdelegate_hairista.sessionUser.idUser page:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        isLoading = NO;
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                [self.arrImages addObjectsFromArray:arrData];
                [self.tblView reloadData];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
        }
    }];
}

-(void)deleteImage:(Image *)image{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[SalonManage sharedInstance] deleteImage:image.idImage dataApiResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
       
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
             [Common showAlert:self title:@"Thông báo" message:@"Xoá hình ảnh thành công" buttonClick:nil];
            NSInteger indexObj = [self.arrImages indexOfObject:image];
            
            [self.arrImages removeObject:image];
            [self.tblView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexObj inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrImages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    ImgIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImgIndexCell"];
    
    Image *img = [self.arrImages objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataForCell:img indexCurr:indexPath.row];
   
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.arrImages.count - 1 && !isFullData && !isLoading){
        
        indexPage ++;
        
        [self getListImageSalon];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 90;
}

- (id)saveObjectAndInsertBlankRowAtIndexPath:(NSIndexPath *)indexPath {
    
    id object = (NSMutableArray *)[self.arrImages objectAtIndex:indexPath.row];

    return object;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
       [Common showAlert:self title:@"Thông báo" message:@"Bạn có chắc muốn xoá hình này" buttonClick:^(UIAlertAction *alertAction) {
           
           Image *image = [self.arrImages objectAtIndex:indexPath.row];
           [self deleteImage:image];
           
       }];
        
    }
}
- (void)moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
    
    id object = [self.arrImages objectAtIndex:fromIndexPath.row];
    [self.arrImages removeObjectAtIndex:fromIndexPath.row];
    
    [self.arrImages insertObject:object atIndex:toIndexPath.row];
}
- (void)finishReorderingWithObject:(id)object atIndexPath:(NSIndexPath *)indexPath; {
    
    [self.arrImages replaceObjectAtIndex:indexPath.row withObject:object];
    [self setUpIndexForList:self.arrImages];
    [self.tblView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
   
}
@end
