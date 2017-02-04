//
//  ListHairViewController.m
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ListHairViewController.h"
#import "Hair.h"
#import "HairCell.h"
#import "Hair.h"
#import "CommonDefine.h"
#import "HairFullView.h"


#define NUM_ITEM 3
#define MARGIN 8

@interface ListHairViewController (){

    HairFullView *hairFull;
}

@property (nonatomic, strong) NSMutableArray *arrData;
@property (weak, nonatomic) IBOutlet UICollectionView *cllHairs;

@end

@implementation ListHairViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createDataTemp];
    
    [self.cllHairs registerNib:[UINib nibWithNibName:@"HairCell" bundle:nil] forCellWithReuseIdentifier:@"HairCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Method

-(void)createDataTemp{

    self.arrData = [NSMutableArray array];
    
    Hair *hair_1 = [[Hair alloc] init];
    hair_1.hairName = @"Kiểu 1";
    hair_1.imgName = @"ngan_1";
    [self.arrData addObject:hair_1];
    
    Hair *hair_2 = [[Hair alloc] init];
    hair_2.hairName = @"Kiểu 2";
    hair_2.imgName = @"ngan_2";
    [self.arrData addObject:hair_2];
    
    Hair *hair_3 = [[Hair alloc] init];
    hair_3.hairName = @"Kiểu 3";
    hair_3.imgName = @"ngan_3";
    [self.arrData addObject:hair_3];
    
    Hair *hair_4 = [[Hair alloc] init];
    hair_4.hairName = @"Kiểu 4";
    hair_4.imgName = @"ngan_4";
    [self.arrData addObject:hair_4];
    
    Hair *hair_5 = [[Hair alloc] init];
    hair_5.hairName = @"Kiểu 5";
    hair_5.imgName = @"ngan_5";
    [self.arrData addObject:hair_5];
    
    Hair *hair_6 = [[Hair alloc] init];
    hair_6.hairName = @"Kiểu 6";
    hair_6.imgName = @"ngan_6";
    [self.arrData addObject:hair_6];
    
    
    Hair *hair_7 = [[Hair alloc] init];
    hair_7.hairName = @"Kiểu 7";
    hair_7.imgName = @"ngan_7";
    [self.arrData addObject:hair_7];
    
    Hair *hair_8 = [[Hair alloc] init];
    hair_8.hairName = @"Kiểu 8";
    hair_8.imgName = @"ngan_8";
    [self.arrData addObject:hair_8];
    
    Hair *hair_9 = [[Hair alloc] init];
    hair_9.hairName = @"Kiểu 9";
    hair_9.imgName = @"ngan_9";
    [self.arrData addObject:hair_9];
    
    Hair *hair_10 = [[Hair alloc] init];
    hair_10.hairName = @"Kiểu 10";
    hair_10.imgName = @"ngan_10";
    [self.arrData addObject:hair_10];
    
    Hair *hair_11 = [[Hair alloc] init];
    hair_11.hairName = @"Kiểu 11";
    hair_11.imgName = @"ngan_11";
    [self.arrData addObject:hair_11];
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UICollectionView Datasource - Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
    return self.arrData.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    Hair *hair = [self.arrData objectAtIndex:indexPath.row];
    
    HairCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HairCell" forIndexPath:indexPath];
    [cell setDataForCell:hair];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (SW - ((NUM_ITEM + 1) *MARGIN ))/NUM_ITEM;
    
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
 
    return UIEdgeInsetsMake(8, 8, 8, 8);
 }


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Hair *hair = [self.arrData objectAtIndex:indexPath.row];
    
    hairFull = [[HairFullView alloc] initWithFrame:self.view.bounds hair:hair];
    
    [UIView transitionWithView:self.view duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
                    animations:^ { [self.view addSubview:hairFull];
                        
                    }
                    completion:nil];
    //  [self.view addSubview:hairFull];
    
   
 }
@end
