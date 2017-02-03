//
//  BookingsViewController.m
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "BookingsViewController.h"
#import "SlideMenuViewController.h"

@interface BookingsViewController ()

@end

@implementation BookingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}
@end
