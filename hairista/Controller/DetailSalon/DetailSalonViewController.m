//
//  DetailSalonViewController.m
//  hairista
//
//  Created by Dong Vo on 2/2/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

// Dong vo

#import "DetailSalonViewController.h"
#import "Salon.h"

@interface DetailSalonViewController (){

    Salon *salon;
}

@end

@implementation DetailSalonViewController

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salon:(Salon *)aSalon{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        salon = aSalon;
    }
    
    return self;
}

#pragma mark - CircleView
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Method
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
