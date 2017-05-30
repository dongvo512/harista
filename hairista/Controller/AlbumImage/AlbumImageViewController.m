//
//  AlbumImageViewController.m
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "AlbumImageViewController.h"
#import "AuthenticateManage.h"
#import "SlideMenuViewController.h"
#import "Image.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "HairFullView.h"
#import "ImageCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "SalonManage.h"

#define LIMIT_ITEM @"14"


@interface AlbumImageViewController ()<CHTCollectionViewDelegateWaterfallLayout>{

    NSInteger indexPage;
    
    BOOL isFullData;
    
    BOOL isLoading;
}
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrImages;
@end

@implementation AlbumImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    indexPage = 1;
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    layout.headerHeight = 0;
    layout.footerHeight = 0;
    layout.columnCount = 2;
    layout.minimumColumnSpacing = 8;
    layout.minimumInteritemSpacing = 8;
    
    self.collectionView.collectionViewLayout = layout;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageCell" bundle:nil] forCellWithReuseIdentifier:@"ImageCell"];
    
    self.arrImages = [NSMutableArray array];
    
    //[self getListSalonUpdated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}
#pragma mark - GetData


-(void)getListSalonUpdated{

    [[SalonManage sharedInstance] getListSalonUpdateImage:^(NSError *error, id idObject) {
        
        
    }];
}

-(void)getListImageUser{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoading = YES;
    
    [[AuthenticateManage sharedInstance] getListImageUser:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        isLoading = NO;
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
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
#pragma mark - UICollectionViewDataSource - Delegate

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
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:img.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        img.heightImage = (SW -24)/2 * image.size.height/image.size.width;
      //  [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]]];
        [self.collectionView.collectionViewLayout invalidateLayout];
    }];
    
    if(indexPath.row == self.arrImages.count - 1 && !isFullData && !isLoading){
    
        indexPage ++;
        
        [self getListImageUser];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Image *img = [self.arrImages objectAtIndex:indexPath.row];
    
    CGFloat heightImgName = [Common findHeightForText:img.name havingWidth:(SW - 36)/2 andFont:[UIFont fontWithName:FONT_ROBOTO_REGULAR size:15.0f]];
    
    return CGSizeMake((SW -24)/2, (img.heightImage == 0)?(SW -24)/2 + heightImgName:img.heightImage + heightImgName);
}
@end
