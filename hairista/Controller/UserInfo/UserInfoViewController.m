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
#import "CommonDefine.h"
#import "GetLocationViewController.h"
#import "NCComboboxNewView.h"
#import "PopupTimeViewController.h"


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
@property (weak, nonatomic) IBOutlet UIView *viewLocaltion;
@property (weak, nonatomic) IBOutlet UITextField *tfLaitude;
@property (weak, nonatomic) IBOutlet UITextField *tflongitude;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraintLocation;
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboOpenTime;
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboCloseTime;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cboOpenTime.view setBackgroundColor:[UIColor whiteColor]];
    [self.cboOpenTime setPlaceHolder:@"Chọn giờ mở cửa"];
    self.cboOpenTime.delegate = self;
    
    [self.cboCloseTime.view setBackgroundColor:[UIColor whiteColor]];
    [self.cboCloseTime setPlaceHolder:@"Chọn giờ đóng cửa"];
    self.cboCloseTime.delegate = self;
    
    vcImagePicker = [[ImagePickerViewController alloc] init];
    vcImagePicker.delegateImg = self;
    vcImagePicker.vcParent = self;
    
    if(![Appdelegate_hairista.sessionUser.role isEqualToString:@"salon"]){
    
        self.heightContraintLocation.constant = 0;
        
        [self.viewLocaltion setHidden:YES];
    }
    
    [self loadDataForUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NCComboboxNewViewDelegate
- (void)didSelect:(CGRect)frame inView:(UIView *)vieParent andType:(NSInteger)type andCombobox:(NCComboboxNewView*)comboboxCurr{

    PopupTimeViewController *vcPopupTime = [[PopupTimeViewController alloc] initWithNibName:@"PopupTimeViewController" bundle:nil];
    
    [vcPopupTime presentInParentViewController:self];
}

- (void)clearCombobox:(NCComboboxNewView *)comboboxCurr{

    
}

#pragma mark - Action
- (IBAction)touchBtnGetLocation:(id)sender {
    
    GetLocationViewController *vcGetLocation = [[GetLocationViewController alloc] initWithNibName:@"GetLocationViewController" bundle:nil aLat:Appdelegate_hairista.sessionUser.lastLat aLong:Appdelegate_hairista.sessionUser.lastLng];
    
    vcGetLocation.delegate = self;
    [self.navigationController pushViewController:vcGetLocation animated:YES];

}

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
    
    if(self.tfLaitude.text.length > 0){
    
        [dic setObject:self.tfLaitude.text forKey:@"lastLat"];
    }
    
    if(self.tflongitude.text.length > 0){
        
        [dic setObject:self.tflongitude.text forKey:@"lastLng"];
    }
    
    
    if(self.tfFullName.text.length == 0 && self.tfEmail.text.length == 0 && self.tfAddress.text.length == 0 && !isUploadedAvatar && self.tfLaitude.text.length == 0 && self.tflongitude.text.length == 0){
    
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
            
                if(self.tfLaitude.text.length > 0 && self.tflongitude.text.length > 0){
                
                    Appdelegate_hairista.sessionUser.lastLat = self.tfLaitude.text;
                    Appdelegate_hairista.sessionUser.lastLng = self.tflongitude.text;
                }
               
                
                NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:Appdelegate_hairista.sessionUser];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:encodedObject forKey:@"FirstRun"];
                [defaults synchronize];

                
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

#pragma mark - GetLocationViewControllerDelegate
-(void)touchButtonCheck:(CGFloat)laitude longitude:(CGFloat)longitude{

    self.tfLaitude.text = [NSString stringWithFormat:@"%f",laitude];
    
    self.tflongitude.text = [NSString stringWithFormat:@"%f",longitude];
    
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
    self.lblPhone.text = [Common convertPhone84:Appdelegate_hairista.sessionUser.phone];
    self.lblAddress.text = Appdelegate_hairista.sessionUser.homeAddress;
    [self.imgAvatar sd_setImageWithURL:[NSURL URLWithString:Appdelegate_hairista.sessionUser.avatar] placeholderImage:IMG_USER_DEFAULT];
    [self clearText];
    
    [[[SlideMenuViewController sharedInstance] viewMenuLeft] loadUserInfo];
}

#pragma mark - ImagePickerViewControllerDelegate

- (UIImage *)fixrotation:(UIImage *)image{
    
    if (image.imageOrientation == UIImageOrientationUp) return image;
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (image.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, image.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, image.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (image.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, image.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, image.size.width, image.size.height,
                                             CGImageGetBitsPerComponent(image.CGImage), 0,
                                             CGImageGetColorSpace(image.CGImage),
                                             CGImageGetBitmapInfo(image.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (image.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.height,image.size.width), image.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,image.size.width,image.size.height), image.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}


- (void)finishGetImage:(NSString *)fileName
                 image:(UIImage *)image{
    
    self.imgAvatar.image = image;
    
    image = [self fixrotation:image];
    
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
    
  //  [Appdelegate_hairista showProcessBar:image];
    
    [Appdelegate_hairista showProcessBar:image progress:Appdelegate_hairista.progressCurr];
    //[progress cancel];

}

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
