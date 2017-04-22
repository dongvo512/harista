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
#import "UserInfoViewController.h"
#import "ChangePassword.h"
#import "AuthenticateManage.h"
#import "MenuLeftView.h"
#import "ImgurAnonymousAPIClient.h"
#import <SDWebImage/UIImageView+WebCache.h>


@interface UserInfoViewController ()<ImagePickerViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{

    ImagePickerViewController *vcImagePicker;
    
    BOOL isUploadedAvatar;
    NSString *strUrlAvart;
    BOOL isTouchBtnUpdate;
}

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UITextField *tfFullName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;


@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    vcImagePicker = [[ImagePickerViewController alloc] init];
    vcImagePicker.delegateImg = self;
    vcImagePicker.vcParent = self;
    
    [self loadDataForUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)touchBtnShowMenu:(id)sender {
    
     [[SlideMenuViewController sharedInstance] toggle];
}

- (IBAction)touchBtnChangePassword:(id)sender {
    
    ChangePassword *vcChangePassword = [[ChangePassword alloc] initWithNibName:@"ChangePassword" bundle:nil];
    [self.navigationController pushViewController:vcChangePassword animated:YES];
}

- (IBAction)touchBtnUpdateUserInfo:(id)sender {
    
    isTouchBtnUpdate = YES;
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    
    if(self.tfFullName.text.length > 0){
    
        [dic setObject:self.tfFullName.text forKey:@"name"];
    }
    else{
    
         [dic setObject:Appdelegate_hairista.sessionUser.name forKey:@"name"];
    }
    
    if (self.tfEmail.text.length > 0){
    
        [dic setObject:self.tfEmail.text forKey:@"email"];
    }
    
    if (self.tfAddress.text.length > 0){
    
        [dic setObject:self.tfAddress.text forKey:@"homeAddress"];
    }
    
    if(isUploadedAvatar && strUrlAvart){
    
       [dic setObject:strUrlAvart forKey:@"avatar"];
    }
    
    if(self.tfFullName.text.length == 0 && self.tfEmail.text.length == 0 && self.tfAddress.text.length == 0 && !isUploadedAvatar){
    
        [Common showAlert:self title:@"Thông báo" message:@"Bạn phải nhập vào ít nhất một thông tin" buttonClick:nil];
        
        dic = nil;
        
        return;
    }
    
    
    [self.view endEditing:YES];
    
    if(dic){
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [[AuthenticateManage sharedInstance] updateUserInfo:dic dataResult:^(NSError *error, id idObject) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            
            if(error){
                
                [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
            }
            else{
            
                [self loadDataForUI];
                
                isUploadedAvatar = NO;
                strUrlAvart = nil;
                
                [Common showAlert:self title:@"Thông báo" message:@"Cập nhật thông tin cá nhân thành công" buttonClick:nil];
            }
            
            
        }];

    }
    
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

#pragma mark - Method

- (void)clearText{
    
    self.tfAddress.text = @"";
    self.tfEmail.text = @"";
    self.tfFullName.text = @"";
    
}

-(void)loadDataForUI{

    self.lblName.text = Appdelegate_hairista.sessionUser.name;
    self.lblEmail.text = Appdelegate_hairista.sessionUser.email;
    self.lblPhone.text = Appdelegate_hairista.sessionUser.phone;
    self.lblAddress.text = Appdelegate_hairista.sessionUser.homeAddress;
    [self.imgAvatar sd_setImageWithURL:[NSURL URLWithString:Appdelegate_hairista.sessionUser.avatar] placeholderImage:IMG_DEFAULT];
    [self clearText];
    
    [[[SlideMenuViewController sharedInstance] viewMenuLeft] loadUserInfo];
}

#pragma mark - ImagePickerViewControllerDelegate

- (void)finishGetImage:(NSString *)fileName
                 image:(UIImage *)image{
    
    self.imgAvatar.image = image;
    
    NSData *data= nil;
   float imgValue = MAX(image.size.width, image.size.height);
    
    if(imgValue > 3000){
    
        data = UIImageJPEGRepresentation(image, 0.1);
    }
    
    else if(imgValue > 2000){
    
        data = UIImageJPEGRepresentation(image, 0.3);
    }
    else{
    
        data = UIImagePNGRepresentation(image);
    }
    
   Appdelegate_hairista.progressCurr =  [[ImgurAnonymousAPIClient client] uploadImageData:data
                                         withFilename:@"image.jpg"
                                                                        completionHandler:^(NSURL *imgurURL, NSError *error) {
                                                                            
                                                                            [Appdelegate_hairista closeProgress];
                                                                            
                                                                            strUrlAvart = imgurURL.absoluteString;
                                                                            
                                                                            isUploadedAvatar = YES;
                                                                            
                                                                            if(isTouchBtnUpdate){
                                                                                
                                                                                [self updateAvatar];
                                                                            }
                                                                            
                                                                            
                                                                            //  [self uploadImagUrl:strUrlAvart];
                                                                            
                                                                        }];
    [Appdelegate_hairista showProcessBar:image];
    
    
    //[progress cancel];

}

//-(void)uploadImagUrl:(NSString *)imgUrl{
//
//    
//    [[AuthenticateManage sharedInstance] uploadUrlImage:imgUrl dataResult:^(NSError *error, id idObject) {
//        
//        if(error){
//        
//            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
//        }
//        else{
//        
//            idImage = (NSString *)idObject;
//            
//            if(idImage){
//                
//                isUploadedAvatar = YES;
//                
//                if(isTouchBtnUpdate){
//                    
//                    [self updateAvatar];
//                }
//            }
//        }
//    }];
//    
//}

-(void)updateAvatar{

    NSMutableDictionary *dic = nil;

    if(isUploadedAvatar && strUrlAvart){
        
       dic = [[NSMutableDictionary alloc] init];
        
        [dic setObject:strUrlAvart forKey:@"avatar"];
        
        if(self.tfFullName.text.length > 0){
            
            [dic setObject:self.tfFullName.text forKey:@"name"];
        }
        else{
            
            [dic setObject:Appdelegate_hairista.sessionUser.name forKey:@"name"];
        }
    }
    
    if(dic){
        
        [[AuthenticateManage sharedInstance] updateUserInfo:dic dataResult:^(NSError *error, id idObject) {
            
            if(error){
                
                [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
            }
            else{
                
                isUploadedAvatar = NO;
                strUrlAvart = nil;
                
            }
            
        }];
        
    }

}



@end
