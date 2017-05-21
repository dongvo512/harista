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

#define LIMIT_ITEM @"14"

@interface ImagesViewController ()<UITableViewDelegate>{
    
    NSInteger indexPage;
    
    BOOL isFullData;
    
    BOOL isLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrImages;
@end

@implementation ImagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    indexPage = 1;
   
    
    [self.tblView registerNib:[UINib nibWithNibName:@"ImgIndexCell" bundle:nil] forCellReuseIdentifier:@"ImgIndexCell"];
   
    [self.tblView setEditing:YES animated:YES];

    self.arrImages = [NSMutableArray array];
    
    [self getListImageSalon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

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
            
            [self.tblView reloadData];
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
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
                [self.tblView setEditing:YES animated:YES];
                [self.tblView reloadData];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
        }
    }];
}

#pragma mark - UITableview DataSource - Delegate
#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.arrImages.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
     static NSString *CellIdentifier = @"DragCell";
      UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.showsReorderControl = YES;
    }

    
    
//    ImgIndexCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ImgIndexCell"];
//    
//    
//    Image *img = [self.arrImages objectAtIndex:indexPath.row];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
   // cell.showsReorderControl = YES;
   // [cell setDataForCell:img];
   
    
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//     Image *img = [self.arrImages objectAtIndex:indexPath.row];
//    
//    //[self.navigationController pushViewController:vcDetail animated:YES];
//    
//}
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewCellEditingStyleNone;
}

- (BOOL) tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
  
    return YES;
}
- (BOOL)tableView:(UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}
- (void)moveRowAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath{

    NSInteger sourceRow = indexPath.row;
    NSInteger destRow = newIndexPath.row;
    Image *object = [self.arrImages objectAtIndex:sourceRow];
    
    [self.arrImages removeObjectAtIndex:sourceRow];
    [self.arrImages insertObject:object atIndex:destRow];

}
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    return self.arrImages.count;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    Image *image = [self.arrImages objectAtIndex:indexPath.row];
//    
//    HairFullView *hairFull = [[HairFullView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) imgName:image.url title:image.name];
//    
//    [UIView transitionWithView:self.view duration:0.5
//                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
//                    animations:^ { [[[SlideMenuViewController sharedInstance] view] addSubview:hairFull];
//                        
//                    }
//                    completion:nil];
//    
//    
//}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
//    
//    Image *img = [self.arrImages objectAtIndex:indexPath.row];
//    
//    cell.lblImageName.text = img.name;
//    
//    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:img.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        
//        img.heightImage = (SW -24)/2 * image.size.height/image.size.width;
//        //  [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]]];
//        [self.collectionView.collectionViewLayout invalidateLayout];
//    }];
//    
//    if(indexPath.row == self.arrImages.count - 1 && !isFullData && !isLoading){
//        
//        indexPage ++;
//        
//        [self getListImageSalon];
//    }
//    
//    return cell;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    Image *img = [self.arrImages objectAtIndex:indexPath.row];
//    
//    CGFloat heightImgName = [Common findHeightForText:img.name havingWidth:(SW - 36)/2 andFont:[UIFont fontWithName:FONT_ROBOTO_REGULAR size:15.0f]];
//    
//    return CGSizeMake((SW -24)/2, (img.heightImage == 0)?(SW -24)/2 + heightImgName:img.heightImage + heightImgName);
//}
@end
