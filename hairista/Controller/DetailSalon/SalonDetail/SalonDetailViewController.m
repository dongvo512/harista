//
//  SalonDetailViewController.m
//  hairista
//
//  Created by Dong Vo on 4/13/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SalonDetailViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "ImageCell.h"
#import "HeaderSalonView.h"
#import "SalonManage.h"
#import "Salon.h"
#import "Image.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "HairFullView.h"
#import "MapDetailSalonViewController.h"
#import "APIRequestHandler.h"

#define LIMIT_ITEM @"14"

@interface SalonDetailViewController ()<CHTCollectionViewDelegateWaterfallLayout>{

    Salon *salonCurr;
    
    HeaderSalonView *headerSalonView;
    
    BOOL isFullData;
    BOOL isLoading;
    
    NSInteger indexPage;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrImages;
@end

@implementation SalonDetailViewController


-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salon:(Salon *)salon{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
        
        salonCurr = salon;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    indexPage = 1;
    
    self.arrImages = [NSMutableArray array];
    
    [self getDetailSalon];
    [self getListImageSalon];
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    layout.headerHeight = 457;
    layout.footerHeight = 0;
    layout.columnCount = 2;
    layout.minimumColumnSpacing = 8;
    layout.minimumInteritemSpacing = 8;
    
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];
    
     [self.collectionView registerNib:[UINib nibWithNibName:@"HeaderSalonView" bundle:nil] forSupplementaryViewOfKind:CHTCollectionElementKindSectionHeader withReuseIdentifier:@"HeaderSalonView"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get data

- (void)updateComent{

    if(headerSalonView){
    
        NSInteger newComment = headerSalonView.lblTotalComment.text.integerValue +1;
        
        headerSalonView.lblTotalComment.text = [NSString stringWithFormat:@"%ld bình luận",newComment];
    }
}

-(void)getDetailSalon{

    NSString *url = [NSString stringWithFormat:@"%@%@",URL_GET_DETAIL_SALON,salonCurr.idSalon];
    
    isLoading = YES;
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        isLoading = NO;
        
        if(isError){
            
            [Common showAlert:self title:@"Thông báo" message:stringError buttonClick:nil];
           
        }
        else{
            
            salonCurr.isFavorite = [responseDataObject objectForKey:@"isFavorite"];
            
            [headerSalonView.btnFavourite setHidden:NO];
            [headerSalonView.btnFavourite setImage:[UIImage imageNamed:([salonCurr.isFavorite boolValue])?@"ic_favorite":@"ic_favorite_none"] forState:UIControlStateNormal];

        }
    }];

}

-(void)loadMore{

    isLoading = YES;
    
    [[SalonManage sharedInstance] getListImageSalon:salonCurr.idSalon page:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject, NSString *strError) {
        
        isLoading = NO;
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                [self.arrImages addObjectsFromArray:arrData];
                
                [self.collectionView reloadData];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
        }
    }];
}

-(void)getListImageSalon{

    isLoading = YES;
    indexPage = 1;
    [[SalonManage sharedInstance] getListImageSalon:salonCurr.idSalon page:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject, NSString *strError) {
        
        isLoading = NO;
        
        if(error){
        
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
           
            self.arrImages = [NSMutableArray arrayWithArray:arrData];
            
            [self.collectionView reloadData];
            
            if(arrData.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
        }
    }];
}

#pragma mark - UICollectionViewDataSource - Delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
      return self.arrImages.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Image *image = [self.arrImages objectAtIndex:indexPath.row];
    
   HairFullView *hairFull = [[HairFullView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) imgName:image.url title:image.name];
    
    [UIView transitionWithView:self.view duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
                    animations:^ { [[[SlideMenuViewController sharedInstance] view] addSubview:hairFull];
                        
                    }
                    completion:nil];

    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    Image *img = [self.arrImages objectAtIndex:indexPath.row];
    
    if(img.name.length == 0){
    
        cell.lblImageName.text = @"Hình của khách";
    }
    else{
    
        cell.lblImageName.text = img.name;
    }
    

    if(!img.heightImage){
    
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:img.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            
            img.heightImage = (SW -24)/2 * image.size.height/image.size.width;
            
            [self.collectionView.collectionViewLayout invalidateLayout];
        }];

    }
    else{
    
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:img.url] completed:nil];
    }
    
    if(indexPath.row == self.arrImages.count - 1 && !isFullData && !isLoading){
        
        indexPage ++;
        
        [self loadMore];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Image *img = [self.arrImages objectAtIndex:indexPath.row];
    
    CGFloat heightImgName = [Common findHeightForText:img.name havingWidth:(SW - 36)/2 andFont:[UIFont fontWithName:FONT_ROBOTO_REGULAR size:15.0f]];
    
    return CGSizeMake((SW -24)/2, (img.heightImage == 0)?(SW -24)/2 + heightImgName:img.heightImage + heightImgName);
}

#pragma mark - Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc] initWithFrame:CGRectZero];
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
      
        headerSalonView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderSalonView" forIndexPath:indexPath];
        headerSalonView.delegate = self;
        [headerSalonView setDataForView:salonCurr];
        reusableview = headerSalonView;
    }
   
    return reusableview;
}
#pragma mark - HeaderSalonViewDelegate
-(void)selectFavorite:(UIButton *)btnCurr{
    
    
    if([salonCurr.isFavorite boolValue]){
    
        [btnCurr setEnabled:NO];
        
        [btnCurr setImage:[UIImage imageNamed:@"ic_favorite_none"] forState:UIControlStateNormal];
        
        [[SalonManage sharedInstance] deleteFavorite:salonCurr.idSalon dataApiResult:^(NSError *error, id idObject, NSString *strError) {
            
            if(error){
            
                [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
            }
            else{
            
                salonCurr.isFavorite = @(0);
                
                [btnCurr setEnabled:YES];
            }
        }];
    }
    else{
        
         [btnCurr setEnabled:NO];
         [btnCurr setImage:[UIImage imageNamed:@"ic_favorite"] forState:UIControlStateNormal];
        
        [[SalonManage sharedInstance] favorite:salonCurr.idSalon dataApiResult:^(NSError *error, id idObject, NSString *strError) {
            
            if(error){
                
                [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
            }
            else{
                
                salonCurr.isFavorite = @(1);
                
                [btnCurr setEnabled:YES];
            }
        }];

    }
}
-(void)selectLocation{

    if(salonCurr.lastLat.length == 0 && salonCurr.lastLng.length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Salon vẫn chưa cập nhật vị trí trên bản đồ" buttonClick:nil];
    }
    else{
    
        MapDetailSalonViewController *vcMapDetailSalon = [[MapDetailSalonViewController alloc] initWithNibName:@"MapDetailSalonViewController" bundle:nil Salon:salonCurr];
        
        [self.rootVC.navigationController pushViewController:vcMapDetailSalon animated:YES];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
