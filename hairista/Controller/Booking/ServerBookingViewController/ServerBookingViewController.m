//
//  ServerBookingViewController.m
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServerBookingViewController.h"
#import "Service.h"
#import "ServiceBookingSelectCell.h"
#import "CommonDefine.h"
#import "ServiceHeaderView.h"
#import "HairFullView.h"
#import "Hair.h"
#import "SalonManage.h"
#import "Category.h"


#define NUM_ITEM 2
#define MARGIN 8

@interface ServerBookingViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *arrSelected;
}
@property (nonatomic, strong) NSMutableArray *arrGroupService;
@property (weak, nonatomic) IBOutlet UICollectionView *cllService;
@property (weak, nonatomic) IBOutlet UIButton *btnChecked;

@end

@implementation ServerBookingViewController

#pragma mark - Init

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrSelected:(NSArray *)aArrSelected{

    self = [super init];
    
    if(self){
        
        arrSelected = [NSMutableArray arrayWithArray:aArrSelected];
        
        
    }
    
    return self;
}

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.cllService setContentInset:UIEdgeInsetsMake(8, 0, 0, 0)];
    
    [self getListService];
    
    //[self createDataTemp];
    
    [self.cllService registerNib:[UINib nibWithNibName:@"ServiceBookingSelectCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceBookingSelectCell"];
    
     [self.cllService registerNib:[UINib nibWithNibName:@"ServiceHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ServiceHeader"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
- (IBAction)touchBtnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getListService{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListCategoriesProduct:^(NSError *error, id idObject) {
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            NSArray *arrService = idObject;
            
            if(arrService.count > 0){
            
                self.arrGroupService = [NSMutableArray arrayWithArray:arrService];
                [self checkSelected];
                [self.cllService reloadData];
            }
            
        }
    }];
}

-(void)checkSelected{

    if(arrSelected.count > 0){
        
        for(Service *serviceSelected in arrSelected){
            
            for(Category *group in self.arrGroupService){
                
                for(Service *service in group.arrServices){
                
                    if(service.idService.integerValue == serviceSelected.idService.integerValue){
                    
                        service.isSelected = YES;
                    }
                }
            }
        }
    }

}

- (IBAction)check:(id)sender {
    
    NSMutableArray *arrItemSelected = [NSMutableArray array];
    
    for(Category *group in self.arrGroupService){
    
        for(Service *service in group.arrServices){
        
            if(service.isSelected){
                
                [arrItemSelected addObject:service];
            }
        }
    }
    
    if(arrItemSelected.count > 0){
    
        if([[self delegate] respondsToSelector:@selector(selectedItems:controller:)]){
        
            [[self delegate] selectedItems:arrItemSelected controller:self];
        }
    }
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.arrGroupService.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    Category *cat = [self.arrGroupService objectAtIndex:section];
    
    return cat.arrServices.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    Category *cat = [self.arrGroupService objectAtIndex:indexPath.section];
    
    Service *serice = [cat.arrServices objectAtIndex:indexPath.row];
    
    ServiceBookingSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceBookingSelectCell" forIndexPath:indexPath];
    cell.delegate = self;
    [cell setDataForCell:serice];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = (SW - ((NUM_ITEM + 1) *MARGIN ))/NUM_ITEM;
    
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = [[UICollectionReusableView alloc] initWithFrame:CGRectZero];
    
    if (kind == UICollectionElementKindSectionHeader) {
       
        ServiceHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ServiceHeader" forIndexPath:indexPath];
        Category *cate = [self.arrGroupService objectAtIndex:indexPath.section];
        headerView.lblTitle.text = cate.name;
        
        reusableview = headerView;
    }
    
    return reusableview;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    Category *group = [self.arrGroupService objectAtIndex:indexPath.section];
    
    Service *service = [group.arrServices objectAtIndex:indexPath.row];
    service.isSelected = !service.isSelected;
    
    [self.cllService reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section]]];

}

#pragma mark - ServiceBookingSelectCellDelegate
-(void)selectItem:(Service *)service{

    }
@end


