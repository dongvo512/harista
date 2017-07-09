//
//  ServicesViewController.m
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServicesViewController.h"
#import "GroupService.h"
#import "Service.h"
#import "ServiceCell.h"
#import "CommonDefine.h"
#import "ServiceHeaderView.h"
#import "HairFullView.h"
#import "Hair.h"
#import "SalonManage.h"
#import "Category.h"


#define NUM_ITEM 2
#define MARGIN 8

@interface ServicesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    BOOL isSelectedItem;

    NSMutableArray *arrSelected;
    
    NSString *salonCurrID;
}
@property (nonatomic, strong) NSMutableArray *arrGroupService;
@property (weak, nonatomic) IBOutlet UICollectionView *cllService;
@property (weak, nonatomic) IBOutlet UIButton *btnChecked;

@end

@implementation ServicesViewController

#pragma mark - Init

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isSelectItem:(BOOL)isSelectItem arrSelected:(NSArray *)aArrSelected salon:(NSString *)salonId{

    self = [super init];
    
    if(self){
    
        isSelectedItem = isSelectItem;
        
        arrSelected = [NSMutableArray arrayWithArray:aArrSelected];
        
        salonCurrID = salonId;
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
    
    [self.cllService registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceCell"];
    
     [self.cllService registerNib:[UINib nibWithNibName:@"ServiceHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ServiceHeader"];
    
    [self.btnChecked setHidden:!isSelectedItem];
    
    
   // [self checkSelected];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

-(void)getListService{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListServiceBySalonID:salonCurrID dataApiResult:^(NSError *error, id idObject, NSString *strError) {
       
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
        
            NSArray *arrService = idObject;
            
            if(arrService.count > 0){
            
                self.arrGroupService = [NSMutableArray arrayWithArray:arrService];
                
                [self.cllService reloadData];
            }
            
        }
    }];
}

-(void)checkSelected{

    if(arrSelected.count > 0){
        
        for(Service *serviceSelected in arrSelected){
            
            for(GroupService *group in self.arrGroupService){
                
                for(Service *service in group.arrSerives){
                
                    if([service.name isEqualToString:serviceSelected.name]){
                    
                        service.isSelected = YES;
                    }
                }
            }
        }
    }

}

- (IBAction)check:(id)sender {
    
    NSMutableArray *arrItemSelected = [NSMutableArray array];
    
    for(GroupService *group in self.arrGroupService){
    
        for(Service *service in group.arrSerives){
        
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
    
    ServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceCell" forIndexPath:indexPath];
    
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
@end


