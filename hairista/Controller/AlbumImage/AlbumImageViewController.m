//
//  AlbumImageViewController.m
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "AlbumImageViewController.h"

#import "SlideMenuViewController.h"

@interface AlbumImageViewController ()

@end

@implementation AlbumImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}


@end
