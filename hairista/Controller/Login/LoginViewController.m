//
//  LoginViewController.m
//  hairista
//
//  Created by Dong Vo on 1/13/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "LoginViewController.h"
#import "UserInfoViewController.h"
#import "CommonDefine.h"
#import "SlideMenuViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;

@property (weak, nonatomic) IBOutlet UIView *viewUserName;
@property (weak, nonatomic) IBOutlet UIView *viewPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnRegister;

@end

@implementation LoginViewController


#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    CGFloat parrent = SH - 72;
    
    CGFloat logo = parrent/3;
    
    CGFloat heightCurr = logo/4;
    
    self.viewUserName.layer.cornerRadius = heightCurr/2;
    
    self.viewPassword.layer.cornerRadius = heightCurr/2;
    
    self.btnLogin.layer.cornerRadius = heightCurr/2;
    
    self.btnRegister.layer.cornerRadius = heightCurr/2;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)dismissKeyboard:(id)sender {
    
     [self.view endEditing:YES];
    
}
- (IBAction)login:(id)sender {
    
    SlideMenuViewController *vcSlideMenu = [SlideMenuViewController sharedInstance];
    
    [self presentViewController:vcSlideMenu animated:YES completion:nil];
    
   /* UserInfoViewController *vcUserInfo = [[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil];
    [self.navigationController pushViewController:vcUserInfo animated:YES];

    
    UINavigationController *nvg = [[UINavigationController alloc] initWithRootViewController:vcUserInfo];
    nvg.navigationBarHidden = TRUE;
 
    [self presentViewController:nvg animated:YES completion:nil];*/
}

@end
