//
//  EditServiceViewController.m
//  hairista
//
//  Created by Dong Vo on 5/6/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "EditServiceViewController.h"


@interface EditServiceViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrCategories;

@end

@implementation EditServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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


#pragma mark - UICollectionViewDataSource

//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
//    
//    return self.arrGroupService.count;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    
//    Category *cat = [self.arrGroupService objectAtIndex:section];
//    
//    return cat.arrServices.count;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    Category *cat = [self.arrGroupService objectAtIndex:indexPath.section];
//    
//    Service *serice = [cat.arrServices objectAtIndex:indexPath.row];
//    
//    ServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceCell" forIndexPath:indexPath];
//    
//    [cell setDataForCell:serice];
//    return cell;
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    CGFloat width = (SW - ((NUM_ITEM + 1) *MARGIN ))/NUM_ITEM;
//    
//    return CGSizeMake(width, width);
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    return UIEdgeInsetsMake(8, 8, 8, 8);
//}

@end
