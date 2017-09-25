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
#import "ProvinceViewController.h"
#import "DistrictViewController.h"
#import "Province.h"
#import "District.h"


@interface UserInfoViewController ()<ImagePickerViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{

    ImagePickerViewController *vcImagePicker;
    
    BOOL isUploadedAvatar;
    NSString *idImageCurr;
    BOOL isTouchBtnUpdate;
    
    PopupTimeViewController *popupTimeOpen;
    
    PopupTimeViewController *popupTimeClose;
    
    NSDate *dateOpenTime;
    NSDate *dateCloseTime;
    
    Province *provinceSelected;
    District *districtSelected;
}
@property (weak, nonatomic) IBOutlet UILabel *lblOpenTime;

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
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboProvince;
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboDistrict;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cboOpenTime.view setBackgroundColor:[UIColor whiteColor]];
    self.cboOpenTime.layer.cornerRadius = 6;
    self.cboOpenTime.view.layer.cornerRadius = 6;
    [self.cboOpenTime setPlaceHolder:@"Chọn giờ mở cửa"];
    self.cboOpenTime.delegate = self;
    
    [self.cboCloseTime.view setBackgroundColor:[UIColor whiteColor]];
    self.cboCloseTime.layer.cornerRadius = 6;
    self.cboCloseTime.view.layer.cornerRadius = 6;
    [self.cboCloseTime setPlaceHolder:@"Chọn giờ đóng cửa"];
    self.cboCloseTime.delegate = self;
    
    [self.cboProvince.view setBackgroundColor:[UIColor whiteColor]];
    self.cboProvince.layer.cornerRadius = 6;
    self.cboProvince.view.layer.cornerRadius = 6;
    [self.cboProvince setPlaceHolder:@"Chọn tỉnh thành"];
    self.cboProvince.delegate = self;

    
    [self.cboDistrict.view setBackgroundColor:[UIColor whiteColor]];
    self.cboDistrict.layer.cornerRadius = 6;
    self.cboDistrict.view.layer.cornerRadius = 6;
    [self.cboDistrict setPlaceHolder:@"Chọn quận huyện"];
    self.cboDistrict.delegate = self;

    
    vcImagePicker = [[ImagePickerViewController alloc] init];
    vcImagePicker.delegateImg = self;
    vcImagePicker.vcParent = self;
    
    if(![Appdelegate_hairista.sessionUser.role isEqualToString:@"salon"]){
    
        self.heightContraintLocation.constant = 0;
        
        [self.viewLocaltion setHidden:YES];
        
        [self.lblOpenTime setHidden:YES];
    }
    
    [self loadDataForUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - NCComboboxNewViewDelegate
- (void)didSelect:(CGRect)frame inView:(UIView *)vieParent andType:(NSInteger)type andCombobox:(NCComboboxNewView*)comboboxCurr{

    if([comboboxCurr isEqual:self.cboOpenTime]){
    
        popupTimeOpen = [[PopupTimeViewController alloc] initWithNibName:@"PopupTimeViewController" bundle:nil dateSelected:dateOpenTime];
        popupTimeOpen.delegate = self;
        [popupTimeOpen presentInParentViewController:self];
    }
    
    if([comboboxCurr isEqual:self.cboCloseTime]){
    
        popupTimeClose = [[PopupTimeViewController alloc] initWithNibName:@"PopupTimeViewController" bundle:nil dateSelected:dateCloseTime];
        popupTimeClose.delegate = self;
        [popupTimeClose presentInParentViewController:self];
    }
    
    if([comboboxCurr isEqual:self.cboProvince]){
        
        ProvinceViewController *vcProvince = [[ProvinceViewController alloc] initWithNibName:@"ProvinceViewController" bundle:nil provinceSelected:provinceSelected];
        vcProvince.delegate = self;
        [self.navigationController pushViewController:vcProvince animated:YES];
    }
    
    if([comboboxCurr isEqual:self.cboDistrict]){
        
        DistrictViewController *vcDistrict = [[DistrictViewController alloc] initWithNibName:@"DistrictViewController" bundle:nil districtSelected:districtSelected province:provinceSelected.idProvince.stringValue];
        vcDistrict.delegate = self;
        [self.navigationController pushViewController:vcDistrict animated:YES];
    }
}

- (void)clearCombobox:(NCComboboxNewView *)comboboxCurr{

    if([self.cboOpenTime isEqual:comboboxCurr]){
    
        dateOpenTime = nil;
        [self.cboOpenTime setTextName:@""];
    }
    
    if([self.cboCloseTime isEqual:comboboxCurr]){
        
        dateCloseTime = nil;
        [self.cboCloseTime setTextName:@""];
    }
    
    if([self.cboProvince isEqual:comboboxCurr]){
        
        provinceSelected = nil;
        [self.cboProvince setTextName:@""];
        
        districtSelected = nil;
        
        [self.cboDistrict setTextName:@""];
    }
    
    if([self.cboDistrict isEqual:comboboxCurr]){
    
        districtSelected = nil;
        
        [self.cboDistrict setTextName:@""];
    }
}

#pragma mark - ProvinceViewControllerDelegte
-(void)selectedProvince:(Province *)province controller:(ProvinceViewController *)controller{

    [controller.navigationController popViewControllerAnimated:YES];
    
    if(provinceSelected.idProvince.integerValue == province.idProvince.integerValue){
        
        return;
    }
    
    provinceSelected = province;
    
    [self.cboProvince setTextName:provinceSelected.provinceName];
    districtSelected = nil;
    [self.cboDistrict setTextName:@""];
}

#pragma mark - DistrictViewControllerDelegte
-(void)selectedDistrict:(District *)district controller:(DistrictViewController *)controller{

    [controller.navigationController popViewControllerAnimated:YES];
    
    if(districtSelected.idProvince.integerValue == district.idProvince.integerValue){
    
        return;
    }
    
    districtSelected = district;
    
    [self.cboDistrict setTextName:districtSelected.name];
}

#pragma mark - PopupTimeViewControllerDelegate
-(void)touchButtonFinish:(NSDate *)dateSelected controller:(PopupTimeViewController *)controller{

    if([controller isEqual:popupTimeOpen]){
    
        [self.cboOpenTime setTextName:[Common getStringDisplayFormDate:dateSelected andFormatString:@"HH:mm"]];
        
        dateOpenTime = dateSelected;
    }
    
    if([controller isEqual:popupTimeClose]){
    
        [self.cboCloseTime setTextName:[Common getStringDisplayFormDate:dateSelected andFormatString:@"HH:mm"]];
      
        dateCloseTime = dateSelected;
    }
}
#pragma mark - Action
- (IBAction)touchBtnGetLocation:(id)sender {
    
    GetLocationViewController *vcGetLocation = [[GetLocationViewController alloc] initWithNibName:@"GetLocationViewController" bundle:nil aLat:self.tfLaitude.text aLong:self.tflongitude.text];
    
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
    
    if(isUploadedAvatar && idImageCurr){
    
       [dic setObject:idImageCurr forKey:@"avatarId"];
    }
    
    if(self.tfLaitude.text.length > 0){
    
        [dic setObject:self.tfLaitude.text forKey:@"lastLat"];
    }
    
    if(self.tflongitude.text.length > 0){
        
        [dic setObject:self.tflongitude.text forKey:@"lastLng"];
    }
    
    if(dateOpenTime){
    
        [dic setObject:[Common getStringDisplayFormDate:dateOpenTime andFormatString:@"HH:mm:ss"] forKey:@"openTime"];

    }
    
    if(dateCloseTime){
        
        [dic setObject:[Common getStringDisplayFormDate:dateCloseTime andFormatString:@"HH:mm:ss"] forKey:@"closeTime"];
        
    }
    
    if(provinceSelected){
    
        [dic setObject:provinceSelected.idProvince.stringValue forKey:@"provinceId"];
    }
    
    if(districtSelected){
    
         [dic setObject:districtSelected.idDistrict.stringValue forKey:@"districtId"];
    }
    
    if(self.tfFullName.text.length == 0 && self.tfEmail.text.length == 0 && self.tfAddress.text.length == 0 && !isUploadedAvatar && self.tfLaitude.text.length == 0 && self.tflongitude.text.length == 0 && [self.cboOpenTime getText].length == 0 && [self.cboCloseTime getText].length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Bạn phải nhập vào ít nhất một thông tin" buttonClick:nil];
        
        dic = nil;
        
        return;
    }
    
    if(![Common validateEmailAddress:self.tfEmail.text] && self.tfEmail.text.length > 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Email không đúng định dạng (ví dụ: abc@gmail.com)" buttonClick:nil];
        
        dic = nil;
        
        return;

    }
    
    
    [self.view endEditing:YES];
    
    if(dic){
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
        [[AuthenticateManage sharedInstance] updateUserInfo:dic dataResult:^(NSError *error, id idObject, NSString *strError) {
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            if(error){
                
                [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
            }
            
            else{
            
                NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:Appdelegate_hairista.sessionUser];
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:encodedObject forKey:@"FirstRun"];
                [defaults synchronize];

                [self loadDataForUI];
                
                isUploadedAvatar = NO;
                idImageCurr = nil;
                
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
    
   // [self.cboOpenTime setTextName:@""];
  //  [self.cboCloseTime setTextName:@""];
}

-(void)loadDataForUI{

    self.lblName.text = Appdelegate_hairista.sessionUser.name;
    self.lblEmail.text = Appdelegate_hairista.sessionUser.email;
    self.lblPhone.text = [Common convertPhone84:Appdelegate_hairista.sessionUser.phone];
    self.lblAddress.text = Appdelegate_hairista.sessionUser.homeAddress;
    [self.imgAvatar sd_setImageWithURL:[NSURL URLWithString:Appdelegate_hairista.sessionUser.avatar] placeholderImage:IMG_USER_DEFAULT];
    
    if(Appdelegate_hairista.sessionUser.lastLat.length > 0){
    
        self.tfLaitude.text = Appdelegate_hairista.sessionUser.lastLat;
    }
    
    if(Appdelegate_hairista.sessionUser.lastLng.length > 0){
    
        self.tflongitude.text = Appdelegate_hairista.sessionUser.lastLng;
    }
    
    if(Appdelegate_hairista.sessionUser.district){
    
        districtSelected = Appdelegate_hairista.sessionUser.district;
        [self.cboDistrict setTextName:districtSelected.name];
    }
    
    if(Appdelegate_hairista.sessionUser.province){
        
        provinceSelected = Appdelegate_hairista.sessionUser.province;
        [self.cboProvince setTextName:provinceSelected.provinceName];
    }

    
    if(Appdelegate_hairista.sessionUser.openTime.length > 0 && Appdelegate_hairista.sessionUser.closeTime.length > 0){
    
        NSString *openTime = [Appdelegate_hairista.sessionUser.openTime substringWithRange:NSMakeRange(0, Appdelegate_hairista.sessionUser.openTime.length - 3)];
        
        NSString *closeTime = [Appdelegate_hairista.sessionUser.closeTime substringWithRange:NSMakeRange(0, Appdelegate_hairista.sessionUser.closeTime.length - 3)];
        
        self.lblOpenTime.text = [NSString stringWithFormat:@"Giờ mở cửa: %@ - %@",openTime,closeTime];
        
        [self.cboOpenTime setTextName:openTime];
        
        [self.cboCloseTime setTextName:closeTime];
        
        dateOpenTime = [Common getDateFromStringFormat:Appdelegate_hairista.sessionUser.openTime format:@"HH:mm:ss"];
        
        dateCloseTime = [Common getDateFromStringFormat:Appdelegate_hairista.sessionUser.closeTime format:@"HH:mm:ss"];
    }
    else{
    
        dateOpenTime = nil;
        
        dateCloseTime = nil;
        
        self.lblOpenTime.text = @"";
    }
    
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
    
        data = UIImageJPEGRepresentation(image, 0.8);
    }
   
    
    NSString *base64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    base64 = [NSString stringWithFormat:@"%@%@",@"data:image/jpeg;base64,",base64];
    
    NSDictionary *dic = @{@"images":base64};
    
    [APIRequestHandler uploadImageWithURLString:URL_POST_UPLOAD_IMAGE withHttpMethod:kHTTP_METHOD_POST withRequestBody:dic uploadAPIResult:^(BOOL isError, NSString *stringError, id responseDataObject, NSProgress *progress) {
        
        Appdelegate_hairista.progressCurr = progress;
    
        if(responseDataObject && !isError){
        
            [Appdelegate_hairista closeProgress];
            
            NSDictionary *data = [responseDataObject objectForKey:@"data"];
            
            idImageCurr = [data objectForKey:@"id"];
            
            isUploadedAvatar = YES;
            
            if(isTouchBtnUpdate){
                
                [self updateAvatar];
            }

        }
    }];
    
    [Appdelegate_hairista showProcessBar:image progress:Appdelegate_hairista.progressCurr];
}

-(void)updateAvatar{

    NSMutableDictionary *dic = nil;

    if(isUploadedAvatar && idImageCurr){
        
       dic = [[NSMutableDictionary alloc] init];
        
        [dic setObject:idImageCurr forKey:@"avatarId"];
        
        if(self.tfFullName.text.length > 0){
            
            [dic setObject:self.tfFullName.text forKey:@"name"];
        }
        else{
            
            [dic setObject:Appdelegate_hairista.sessionUser.name forKey:@"name"];
        }
    }
    
    if(dic){
        
        [[AuthenticateManage sharedInstance] updateUserInfo:dic dataResult:^(NSError *error, id idObject, NSString *strError) {
            
            if(error){
                
                [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
            }
            else{
                
                isUploadedAvatar = NO;
                idImageCurr = nil;
                
            }
            
        }];
        
    }

}
@end
