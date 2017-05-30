//
//  PopupCteateServiceViewController.m
//  hairista
//
//  Created by Dong Vo on 5/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "PopupCteateServiceViewController.h"
#import "Service.h"
#import "ImagePickerViewController.h"
#import "ImgurAnonymousAPIClient.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface PopupCteateServiceViewController ()<ImagePickerViewControllerDelegate>{

    ImagePickerViewController *vcImagePicker;
    NSString *strUrlService;
    
    BOOL isEditCurr;
    Service *serviceCurr;
    
    BOOL isUploadingImage;
}

@property (weak, nonatomic) IBOutlet UITextField *tfServiceName;
@property (weak, nonatomic) IBOutlet UITextField *tfServicePrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgService;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;

@end

@implementation PopupCteateServiceViewController

#pragma mark - Init

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil edit:(BOOL)isEdit service:(Service *)service{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        isEditCurr = isEdit;
        serviceCurr = service;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if(isEditCurr){
    
        self.lblTitle.text = @"Chỉnh sửa dịch vụ";
        strUrlService = serviceCurr.image;
        if(serviceCurr){
        
            self.tfServiceName.text = serviceCurr.name;
            self.tfServicePrice.text = serviceCurr.price.stringValue;
             [self.imgService sd_setImageWithURL:[NSURL URLWithString:serviceCurr.image] placeholderImage:IMG_DEFAULT];
        }
    }
    else{
    
        self.lblTitle.text = @"Tạo dịch vụ";
    }
    
    vcImagePicker = [[ImagePickerViewController alloc] init];
    vcImagePicker.delegateImg = self;
    vcImagePicker.vcParent = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action

- (IBAction)tapBackGround:(id)sender {
    
    [self dismissFromParentViewController];
}

- (IBAction)tapImage:(id)sender {
    
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


- (IBAction)touchBtnFinish:(id)sender {
    
    if(self.tfServiceName.text.length == 0){
        
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Bạn chưa nhập tên cho dịch vụ mới" buttonClick:nil];
        
        return;
    }
    
    if(self.tfServicePrice.text.length == 0){
        
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Bạn chưa nhập giá cho dịch vụ mới" buttonClick:nil];
        
        return;
    }
    
    if(strUrlService.length == 0){
    
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Bạn chưa chọn hình cho dịch vụ" buttonClick:nil];
        
        return;
    }
    
    if(isUploadingImage){
    
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Đang upload hình ảnh vui lòng đợi trong giây lát" buttonClick:nil];
        
        return;
    }
    
    if(!serviceCurr){
    
         serviceCurr  = [[Service alloc] init];
    }
    
    serviceCurr.name = self.tfServiceName.text;
    serviceCurr.price = [NSNumber numberWithInteger:self.tfServicePrice.text.integerValue];
    serviceCurr.image = strUrlService;
   // service
    
    if([[self delegate] respondsToSelector:@selector(touchButtonFinish:edit:)]){
        
        [[self delegate] touchButtonFinish:serviceCurr edit:isEditCurr];
    }
    
    [self dismissFromParentViewController];
}
- (void)presentInParentViewController:(UIViewController *)parentViewController {
    //[self.view removeFromSuperview];
    
    self.view.frame = parentViewController.view.bounds;
    [parentViewController.view addSubview:self.view];
    self.view.center = parentViewController.view.center;
    [parentViewController addChildViewController:self];
    
}

- (void)dismissFromParentViewController {
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
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
    
    self.imgService.image = image;
    
    isUploadingImage = YES;
    
    NSData *data= nil;
    
    image = [self fixrotation:image];
    
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
                                                                             
                                                                             strUrlService = imgurURL.absoluteString;
                                                                             
                                                                             isUploadingImage = NO;
                                                                             
                                                                         }];
    
    
    [Appdelegate_hairista showProcessBar:image progress:Appdelegate_hairista.progressCurr];
    
}
@end
