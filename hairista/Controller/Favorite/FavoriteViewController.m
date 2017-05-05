//
//  FavoriteViewController.m
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "FavoriteViewController.h"
#import "SlideMenuViewController.h"
#import "SalonManage.h"
#import "SalonCell.h"
#import "Salon.h"
#import "DetailSalonViewController.h"

#define LIMIT_ITEM @"14"

@interface FavoriteViewController (){

    NSInteger indexPage;
    
    BOOL isFullData;
}

@property (weak, nonatomic) IBOutlet UITableView *tblView;

@property (nonatomic, strong) NSMutableArray *arrFavorite;
@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    indexPage = 0;
  
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 59;
   
    [self.tblView registerNib:[UINib nibWithNibName:@"SalonCell" bundle:nil] forCellReuseIdentifier:@"SalonCell"];
    // Do any additional setup after loading the view from its nib.

    [self getListFavouriteSalon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CallData

-(void)loadMoreSalon{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListFavoriteSalon:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                [self.arrFavorite addObjectsFromArray:arrData];
                
                [self.tblView reloadData];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
        }
        
    }];

}

-(void)getListFavouriteSalon{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListFavoriteSalon:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }else{
        
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
            
                self.arrFavorite = [NSMutableArray arrayWithArray:arrData];
                
                [self.tblView reloadData];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
        }
        
    }];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrFavorite.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalonCell"];
    Salon *salon = [self.arrFavorite objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataForCell:salon];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Salon *salon = [self.arrFavorite objectAtIndex:indexPath.row];
    
    DetailSalonViewController *vcDetail = [[DetailSalonViewController alloc] initWithNibName:@"DetailSalonViewController" bundle:nil salon:salon];
    
    [self.navigationController pushViewController:vcDetail animated:YES];
    
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.arrFavorite.count - 1 &&!isFullData){
        
        indexPage ++;
        [self loadMoreSalon];
    }
    
}
#pragma mark - Method
- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}



@end
