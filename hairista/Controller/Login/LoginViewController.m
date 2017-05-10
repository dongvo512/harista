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
#import "FindSalonViewController.h"
#import "AlbumImageViewController.h"
#import "FavoriteViewController.h"
#import "BookingsViewController.h"
#import "UIColor+Method.h"
#import "RegisterViewController.h"
#import "AuthenticateManage.h"


@interface LoginViewController (){

    BOOL isUserManger;
    
    FindSalonViewController *vcFindSalon;
    AlbumImageViewController *vcAlbumImage;
    FavoriteViewController *vcFavorite;
    BookingsViewController *vcBookings;
    UITabBarController *vcTabbar;
}


@property (weak, nonatomic) IBOutlet UITextField *txtPhone;
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
    
   // self.txtPhone.text = @"0908123456";
   // self.txtPassword.text = @"123456";
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)regis:(id)sender {
    
    RegisterViewController *vcRegister = [[RegisterViewController alloc] init];
    [self presentViewController:vcRegister animated:YES completion:nil];
    
}


- (IBAction)dismissKeyboard:(id)sender {
    
     [self.view endEditing:YES];
    
}

-(BOOL)checkValidateLogin{

    BOOL isValidate = NO;
    
    if(self.txtPhone.text.length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Bạn chưa nhập số điện thoại" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.txtPhone becomeFirstResponder];
        }];
        
        isValidate = YES;
    }
    else if (self.txtPassword.text.length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Bạn chưa nhập mật khẩu" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.txtPassword becomeFirstResponder];
        }];
        
        isValidate = YES;
    }
    
    return isValidate;
}

- (IBAction)login:(id)sender {
    
    if([self checkValidateLogin]){
    
        return;
    }
    
    [self.view endEditing:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AuthenticateManage sharedInstance] login:self.txtPhone.text password:self.txtPassword.text dataResult:^(NSError *error, id idObject) {
        
         [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];

        }
        else{
            
            NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:idObject];
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            [defaults setObject:encodedObject forKey:@"FirstRun"];
            [defaults synchronize];
            
            if([Appdelegate_hairista.sessionUser.role isEqualToString:@"salon"]){
            
                isUserManger = YES;
            }
        
            SlideMenuViewController *vcSlideMenu = [SlideMenuViewController sharedInstance];
            vcSlideMenu.isUserManager = isUserManger;
            [self presentViewController:vcSlideMenu animated:YES completion:nil];
            
        }
        
    }];
    
 
//    
//    UITabBarController *vcTabbar = [[UITabBarController alloc] initWithNibName:@"TabBarViewController" bundle:nil];
//    
//    vcFindSalon = [FindSalonViewController sharedInstance];
//    UINavigationController *ngvFindSalon = [[UINavigationController alloc] initWithRootViewController:vcFindSalon];
//    ngvFindSalon.navigationBarHidden = YES;
//   
//    vcAlbumImage = [[AlbumImageViewController alloc] initWithNibName:@"AlbumImageViewController" bundle:nil];
//    UINavigationController *ngvAlbumImage = [[UINavigationController alloc] initWithRootViewController:vcAlbumImage];
//    ngvAlbumImage.navigationBarHidden = YES;
//
//    
//    vcFavorite = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:nil];
//    UINavigationController *ngvFavorite = [[UINavigationController alloc] initWithRootViewController:vcFavorite];
//    ngvFavorite.navigationBarHidden = YES;
//
//    vcBookings = [[BookingsViewController alloc] initWithNibName:@"BookingsViewController" bundle:nil];
//    UINavigationController *ngvBookings = [[UINavigationController alloc] initWithRootViewController:vcBookings];
//    ngvBookings.navigationBarHidden = YES;
//
//    [vcTabbar setViewControllers:@[ngvFindSalon, ngvAlbumImage, ngvFavorite, ngvBookings]];
//    
//    UITabBar *tabBar = vcTabbar.tabBar;
//    [tabBar setTintColor:[UIColor colorFromHexString:@"BF0A6A"]];
//    
//    UITabBarItem *item0 = [tabBar.items objectAtIndex:0];
//    item0.title = @"Salon tóc";
//    item0.image = [UIImage imageNamed:@"ic_salon"];
//    item0.selectedImage = [UIImage imageNamed:@"ic_salon"];
//    
//    UITabBarItem *item_1 = [tabBar.items objectAtIndex:1];
//    item_1.title = @"Hình ảnh";
//    item_1.image = [UIImage imageNamed:@"ic_hair"];
//    item_1.selectedImage = [UIImage imageNamed:@"ic_hair"];
//    
//    UITabBarItem *item_2 = [tabBar.items objectAtIndex:2];
//    item_2.title = @"Salon yêu thích";
//    item_2.image = [UIImage imageNamed:@"ic_favorite"];
//    item_2.selectedImage = [UIImage imageNamed:@"ic_favorite"];
//    
//    UITabBarItem *item_3 = [tabBar.items objectAtIndex:3];
//    item_3.title = @"Lịch hẹn";
//    item_3.image = [UIImage imageNamed:@"ic_booking"];
//    item_3.selectedImage = [UIImage imageNamed:@"ic_booking"];
//    
//    
//    [self presentViewController:vcTabbar animated:YES completion:nil];
    
}

@end
