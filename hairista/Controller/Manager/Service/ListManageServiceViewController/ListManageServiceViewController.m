//
//  ListManageServiceViewController.m
//  hairista
//
//  Created by Dong Vo on 5/11/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ListManageServiceViewController.h"
#import "Service.h"
#import "ServiceCell.h"


@interface ListManageServiceViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrServices;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation ListManageServiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lblTitle.text = self.titleCategories;
    
    [self createListService];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
-(void)createListService{

    self.arrServices = [NSMutableArray array];
    
    Service *service_1 = [[Service alloc] init];
    service_1.name = @"Nhuộm đen";
    service_1.image = @"ngan_9";
    service_1.price = @"100,000,000 đ";
    [self.arrServices addObject:service_1];
    
    Service *service_2 = [[Service alloc] init];
    service_2.name = @"Nhuộm trắng";
    service_2.image = @"ngan_10";
    service_2.price = @"9,000,000 đ";
    [self.arrServices addObject:service_2];
    
    Service *service_3 = [[Service alloc] init];
    service_3.name = @"Nhuộm đỏ";
    service_3.image = @"ngan_11";
    service_3.price = @"11,000,000 đ";
    [self.arrServices addObject:service_3];
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource - UICollectionViewDelegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrServices.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Service *service = [self.arrServices objectAtIndex:indexPath.row];
    
    ServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceCell" forIndexPath:indexPath];
    
    [cell setDataForCell:service];
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

    
}
@end
