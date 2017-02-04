//
//  CatagoriesHairViewController.m
//  hairista
//
//  Created by Dong Vo on 2/3/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CatagoriesHairViewController.h"
#import "Catagories.h"
#import "CatagoriesCell.h"
#import "CommonDefine.h"
#import "ListHairViewController.h"

#define MARGIN 12
#define NUM_ITEM 2

@interface CatagoriesHairViewController ()

@property (nonatomic, strong) NSMutableArray *arrCatagories;
@property (weak, nonatomic) IBOutlet UICollectionView *cllCatagoriesHair;

@end

@implementation CatagoriesHairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.arrCatagories = [NSMutableArray array];
    
    [self.cllCatagoriesHair registerNib:[UINib nibWithNibName:@"CatagoriesCell" bundle:nil] forCellWithReuseIdentifier:@"CatagoriesCell"];
    
    [self createDataTemp];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)createDataTemp{

    Catagories *catagorie_1 = [[Catagories alloc] init];
    catagorie_1.nameGroup = @"Tóc ngắn";
    catagorie_1.idGroup = @"123";
    catagorie_1.imgNameGroup = @"bg_toc_ngan";
    [self.arrCatagories addObject:catagorie_1];
    
    Catagories *catagorie_2 = [[Catagories alloc] init];
    catagorie_2.nameGroup = @"Tóc xoăn";
    catagorie_2.idGroup = @"124";
    catagorie_2.imgNameGroup = @"bg_toc_xoan";
    [self.arrCatagories addObject:catagorie_2];
    
    Catagories *catagorie_3 = [[Catagories alloc] init];
    catagorie_3.nameGroup = @"Tóc dài";
    catagorie_3.idGroup = @"125";
    catagorie_3.imgNameGroup = @"bg_toc_dai";
    [self.arrCatagories addObject:catagorie_3];
    
    Catagories *catagorie_4 = [[Catagories alloc] init];
    catagorie_4.nameGroup = @"Tóc xù";
    catagorie_4.idGroup = @"126";
    catagorie_4.imgNameGroup = @"bg_toc_xu";
    [self.arrCatagories addObject:catagorie_4];
    
}

#pragma mark - UICollectionView Datasource - Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
   return self.arrCatagories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Catagories *catagories = [self.arrCatagories objectAtIndex:indexPath.row];
    
    CatagoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CatagoriesCell" forIndexPath:indexPath];
    [cell setDataForCell:catagories];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (SW - ((NUM_ITEM + 1) *MARGIN ))/NUM_ITEM;
    
    return CGSizeMake(width, width + 34);
}

/*- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}*/

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 12;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListHairViewController *vcListHair = [[ListHairViewController alloc] initWithNibName:@"ListHairViewController" bundle:nil];
    
    [self.navigationController pushViewController:vcListHair animated:YES];
}


@end
