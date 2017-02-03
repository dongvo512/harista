//
//  UserInfoViewController.m
//  hairista
//
//  Created by Dong Vo on 1/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ImagePickerViewController.h"
#import "AlbumImageViewController.h"
#import "FindSalonViewController.h"
#import "UpdateUserInfoViewController.h"

@interface UserInfoViewController ()<ImagePickerViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{

    ImagePickerViewController *vcImagePicker;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vcImagePicker = [[ImagePickerViewController alloc] init];
    vcImagePicker.delegateImg = self;
    vcImagePicker.vcParent = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)updateInfoUser:(id)sender {
    
    UpdateUserInfoViewController *vcUpdateUserInfo = [[UpdateUserInfoViewController alloc] initWithNibName:@"UpdateUserInfoViewController" bundle:nil];
    [self.navigationController pushViewController:vcUpdateUserInfo animated:YES];
    
}
- (IBAction)clickAlbum:(id)sender {
    
    AlbumImageViewController *vcAlbum = [[AlbumImageViewController alloc] initWithNibName:@"AlbumImageViewController" bundle:nil];
    [self.navigationController pushViewController:vcAlbum animated:YES];
}
- (IBAction)findSaloHair:(id)sender {
    
    FindSalonViewController *vcFindSalon = [[FindSalonViewController alloc] initWithNibName:@"FindSalonViewController" bundle:nil];
    [self.navigationController pushViewController:vcFindSalon animated:YES];
}

- (IBAction)logOut:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickAvatar:(id)sender {
    
    UIAlertController *vcAlert = [UIAlertController alertControllerWithTitle:@"Hình ảnh" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [vcImagePicker takeAPickture:self];
        
    }];
    
    UIAlertAction *photoLibrary = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [vcImagePicker cameraRoll:self];
    }];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [vcAlert dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [vcAlert addAction:camera];
    [vcAlert addAction:photoLibrary];
    [vcAlert addAction:cancel];
    
    [self presentViewController:vcAlert animated:YES completion:nil];
}

#pragma mark - ImagePickerViewControllerDelegate

- (void)finishGetImage:(NSString *)fileName
                 image:(UIImage *)image{
    
    
    self.imgAvatar.image = image;
}


@end
