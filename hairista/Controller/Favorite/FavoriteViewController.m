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


#define LIMIT_ITEM @"14"

@interface FavoriteViewController (){

    NSInteger indexPage;
}

@end

@implementation FavoriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    indexPage = 0;
    
    // Do any additional setup after loading the view from its nib.
   // [self favourite];
    [self getListFavouriteSalon];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CallData

-(void)getListFavouriteSalon{

    [[SalonManage sharedInstance] getListFavoriteSalon:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        
        
    }];
}

-(void)favourite{

    [[SalonManage sharedInstance] calFavourite:@"4" dataApiResult:^(NSError *error, id idObject) {
        
        
    }];
}

#pragma mark - Method
- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}



@end
