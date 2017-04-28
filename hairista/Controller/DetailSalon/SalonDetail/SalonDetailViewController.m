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

#define LIMIT_ITEM @"14"

@interface SalonDetailViewController ()<CHTCollectionViewDelegateWaterfallLayout>{

    Salon *salonCurr;
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
    
    self.arrImages = [NSMutableArray array];
    
    [self getListImageSalon];
    
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(8, 8, 8, 8);
    layout.headerHeight = 256;
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
-(void)getListImageSalon{

    [[SalonManage sharedInstance] getListImageSalon:salonCurr.idSalon page:@"1" limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        if(error){
        
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
           
            if(arrData.count > 0){
            
                [self.arrImages addObjectsFromArray:arrData];
                
                [self.collectionView reloadData];
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
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:img.url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        img.heightImage = (SW -24)/2 * image.size.height/image.size.width;
        [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:0]]];
    }];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Image *img = [self.arrImages objectAtIndex:indexPath.row];
    
    return CGSizeMake((SW -24)/2, (img.heightImage == 0)?(SW -24)/2:img.heightImage);
}

#pragma mark - Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc] initWithFrame:CGRectZero];
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
      
        HeaderSalonView *headerSalonView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderSalonView" forIndexPath:indexPath];
        headerSalonView.delegate = self;
        [headerSalonView setDataForView:salonCurr];
        reusableview = headerSalonView;
    }
   
    return reusableview;
}
#pragma mark - HeaderSalonViewDelegate
-(void)selectFavorite:(Salon *)salon{

    
}
-(void)selectLocation{

    MapDetailSalonViewController *vcMapDetailSalon = [[MapDetailSalonViewController alloc] initWithNibName:@"MapDetailSalonViewController" bundle:nil Salon:salonCurr];
    
    [self.rootVC.navigationController pushViewController:vcMapDetailSalon animated:YES];
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
