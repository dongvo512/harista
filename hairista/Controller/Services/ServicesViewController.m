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


#define NUM_ITEM 3
#define MARGIN 8

@interface ServicesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
{
    BOOL isSelectedItem;

    NSMutableArray *arrSelected;
}
@property (nonatomic, strong) NSMutableArray *arrGroupService;
@property (weak, nonatomic) IBOutlet UICollectionView *cllService;
@property (weak, nonatomic) IBOutlet UIButton *btnChecked;

@end

@implementation ServicesViewController

#pragma mark - Init

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isSelectItem:(BOOL)isSelectItem arrSelected:(NSArray *)aArrSelected{

    self = [super init];
    
    if(self){
    
        isSelectedItem = isSelectItem;
        
        arrSelected = [NSMutableArray arrayWithArray:aArrSelected];
        
        
    }
    
    return self;
}

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createDataTemp];
    
    [self.cllService registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceCell"];
    
     [self.cllService registerNib:[UINib nibWithNibName:@"ServiceHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ServiceHeader"];
    
    [self.btnChecked setHidden:!isSelectedItem];
    
    
    [self checkSelected];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

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

-(void)createDataTemp{

    self.arrGroupService = [NSMutableArray array];
    
    // Group 1
    GroupService *group_1 = [[GroupService alloc] init];
    group_1.groupServiceName = @"Cắt tóc";
    
    Service *service_1_1 = [[Service alloc] init];
    service_1_1.name = @"tóc hàn quốc";
    service_1_1.price = @"100K";
    service_1_1.imgNameService = @"toc_hanquoc";
    service_1_1.isSelected = NO;
    
    Service *service_1_2 = [[Service alloc] init];
    service_1_2.name = @"tóc mái ngố";
    service_1_2.price = @"120K";
    service_1_2.imgNameService = @"toc_mai_ngo";
    service_1_2.isSelected = NO;
    
    Service *service_1_3 = [[Service alloc] init];
    service_1_3.name = @"tóc tầng";
    service_1_3.price = @"150K";
    service_1_3.imgNameService = @"toc_tang";
    service_1_3.isSelected = NO;
    
    group_1.arrSerives = [NSArray arrayWithObjects:service_1_1,service_1_2, service_1_3, nil];
    [self.arrGroupService addObject:group_1];
    
    // Group 2
    GroupService *group_2 = [[GroupService alloc] init];
    group_2.groupServiceName = @"Nhuộm tóc";
    
    Service *service_2_1 = [[Service alloc] init];
    service_2_1.name = @"Nâu";
    service_2_1.price = @"300K";
    service_2_1.imgNameService = @"nhuom_nau";
    service_2_1.isSelected = NO;
    
    Service *service_2_2 = [[Service alloc] init];
    service_2_2.name = @"Bạch kim";
    service_2_2.price = @"230K";
    service_2_2.imgNameService = @"nhuom_bach_kim";
    service_2_2.isSelected = NO;
    
    Service *service_2_3 = [[Service alloc] init];
    service_2_3.name = @"bóc lai";
    service_2_3.price = @"110K";
    service_2_3.imgNameService = @"nhuom_boc_lai";
    service_2_3.isSelected = NO;
    
    group_2.arrSerives = [NSArray arrayWithObjects:service_2_1,service_2_2, service_2_3, nil];
    [self.arrGroupService addObject:group_2];
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.arrGroupService.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    GroupService *group = [self.arrGroupService objectAtIndex:section];
    
    return group.arrSerives.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    GroupService *group = [self.arrGroupService objectAtIndex:indexPath.section];
    
    Service *serice = [group.arrSerives objectAtIndex:indexPath.row];
    
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
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader) {
       
        ServiceHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ServiceHeader" forIndexPath:indexPath];
        GroupService *group = [self.arrGroupService objectAtIndex:indexPath.section];
        headerView.lblTitle.text = group.groupServiceName;
        
        reusableview = headerView;
    }
    
    return reusableview;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    if(isSelectedItem){
    
        ServiceCell *cell = (ServiceCell *)[collectionView cellForItemAtIndexPath:indexPath];
        
        GroupService *group = [self.arrGroupService objectAtIndex:indexPath.section];
        
        Service *service = [group.arrSerives objectAtIndex:indexPath.row];
        service.isSelected = !service.isSelected;
        [cell.imgSelected setHidden:!service.isSelected];
    }
    else{
    
        GroupService *group = [self.arrGroupService objectAtIndex:indexPath.section];
        
        Service *serice = [group.arrSerives objectAtIndex:indexPath.row];
        
        HairFullView *hairFull = [[HairFullView alloc] initWithFrame:self.view.bounds imgName:serice.imgNameService title:serice.name];
        
        [UIView transitionWithView:self.view duration:0.5
                           options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
                        animations:^ { [self.view addSubview:hairFull];
                            
                        }
                        completion:nil];

    }
}
@end


