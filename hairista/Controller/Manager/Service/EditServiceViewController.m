//
//  EditServiceViewController.m
//  hairista
//
//  Created by Dong Vo on 5/6/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "EditServiceViewController.h"
#import "ManageCategoriesCell.h"
#import "Category.h"
#import "ListManageServiceViewController.h"

@interface EditServiceViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrCategories;

@end

@implementation EditServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ManageCategoriesCell" bundle:nil] forCellWithReuseIdentifier:@"ManageCategoriesCell"];
    
    [self createCategories];
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

-(void)createCategories{

    self.arrCategories = [NSMutableArray array];
    
    Category *cat_1 = [[Category alloc] init];
    cat_1.name = @"Cắt";
    cat_1.image = @"ngan_1";
    [self.arrCategories addObject:cat_1];
    
    Category *cat_2 = [[Category alloc] init];
    cat_2.name = @"Nhuộm";
    cat_2.image = @"ngan_2";
    [self.arrCategories addObject:cat_2];
    
    Category *cat_3 = [[Category alloc] init];
    cat_3.name = @"Nối";
    cat_3.image = @"ngan_3";
    [self.arrCategories addObject:cat_3];
    
    Category *cat_4 = [[Category alloc] init];
    cat_4.name = @"Sấy";
    cat_4.image = @"ngan_4";
    [self.arrCategories addObject:cat_4];
    
    Category *cat_5 = [[Category alloc] init];
    cat_5.name = @"Duỗi";
    cat_5.image = @"ngan_5";
    [self.arrCategories addObject:cat_5];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrCategories.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Category *cat = [self.arrCategories objectAtIndex:indexPath.row];
    
    ManageCategoriesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ManageCategoriesCell" forIndexPath:indexPath];
    
    [cell setDataForCell:cat];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (SW - 24)/2;
    
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(8, 8, 8, 8);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Category *cat = [self.arrCategories objectAtIndex:indexPath.row];
    ListManageServiceViewController *manageServices = [[ListManageServiceViewController alloc] initWithNibName:@"ListManageServiceViewController" bundle:nil];
    manageServices.titleCategories = cat.name;
    [self.navigationController pushViewController:manageServices animated:YES];
}
@end
