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
#import "PopupCteateServiceViewController.h"
#import "SalonManage.h"
#import "Category.h"

@interface ListManageServiceViewController (){

    Category *catCurr;
    Service *serviceSelected;
    BOOL isCreateService;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrServices;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation ListManageServiceViewController

#pragma mark - Init

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cat:(Category *)aCate{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        catCurr = aCate;
        self.arrServices = [NSMutableArray arrayWithArray:aCate.arrServices];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.lblTitle.text = self.titleCategories;
    
   // [self createListService];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)touchBtnCreateService:(id)sender {
    
    PopupCteateServiceViewController *vcPopupService = [[PopupCteateServiceViewController alloc] initWithNibName:@"PopupCteateServiceViewController" bundle:nil edit:NO service:nil];
    
    vcPopupService.delegate = self;
    [vcPopupService presentInParentViewController:self];
}

- (IBAction)touchBtnBack:(id)sender {
    
    if(isCreateService){
        
        if([[self delegate] respondsToSelector:@selector(finishCreateService)]){
            
            [[self delegate] performSelector:@selector(finishCreateService) withObject:nil afterDelay:0.0f];
        }
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - PopupCteateServiceViewControllerDelegate
-(void)touchButtonFinish:(Service *)service edit:(BOOL)isEdit{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if(isEdit){
    
        [[SalonManage sharedInstance] updateService:catCurr.idCategory service:service dataApiResult:^(NSError *error, id idObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if(error){
            
                [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
            }
            else{
                
                [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.arrServices indexOfObject:service] inSection:0]]];
            }
        }];
    }
    else{
    
        [[SalonManage sharedInstance] createServiceByIdCat:catCurr.idCategory service:service dataApiResult:^(NSError *error, id idObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if(error){
                
                [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
            }
            else{
                
                [self.arrServices addObject:service];
                
                [self.collectionView insertItemsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.arrServices indexOfObject:service] inSection:0]]];
                
                isCreateService = YES;
            }
        }];
    }
}
#pragma mark - Method

-(void)getListServiceByCategory{

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

    serviceSelected = [self.arrServices objectAtIndex:indexPath.row];
    
    PopupCteateServiceViewController *vcPopupService = [[PopupCteateServiceViewController alloc] initWithNibName:@"PopupCteateServiceViewController" bundle:nil edit:YES service:serviceSelected];
    
    vcPopupService.delegate = self;
    [vcPopupService presentInParentViewController:self];
}
@end
