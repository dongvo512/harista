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
    
    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((SW -24)/2, (SW -24)/2);
}

#pragma mark - Header
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc] initWithFrame:CGRectZero];
    
    if ([kind isEqualToString:CHTCollectionElementKindSectionHeader]) {
      
        HeaderSalonView *headerSalonView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderSalonView" forIndexPath:indexPath];
        
        reusableview = headerSalonView;
    }
   
    return reusableview;
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
