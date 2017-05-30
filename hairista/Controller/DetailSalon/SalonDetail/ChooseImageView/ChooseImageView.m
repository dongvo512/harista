//
//  ChooseImageView.m
//  hairista
//
//  Created by Dong Vo on 4/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ChooseImageView.h"
#import "ImgurAnonymousAPIClient.h"
#import "SalonManage.h"
#import "Salon.h"

@interface ChooseImageView (){

    UIImage *imgCurr;
    NSString *title;
    Salon *salonCurr;
}

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextField *tfImageName;

@end

@implementation ChooseImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame imgName:(NSString *)aImgName image:(UIImage *)image salon:(Salon *)salon{
    
    if(self = [super initWithFrame:frame]){
      
        salonCurr = salon;
        imgCurr = image;
        title = aImgName;
        
        [self setup];
    }
    return self;
}
- (void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"ChooseImageView" owner:self options:nil].firstObject;
    
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
    [self.imgView setImage:imgCurr];
    
}

#pragma mark - Action
- (IBAction)touchBtnBack:(id)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{self.alpha = 0.0;}
                     completion:^(BOOL finished){ [self removeFromSuperview];
                     }];
    
}

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

- (IBAction)touchBtnShare:(id)sender {
    
    if(self.tfImageName.text.length == 0){
    
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Bạn chưa nhập tên hình ảnh" buttonClick:nil];
        
        return;
    }
    
        NSData *data= nil;
    
        imgCurr = [self fixrotation:imgCurr];
    
        float imgValue = MAX(imgCurr.size.width, imgCurr.size.height);
    
        if(imgValue > 3000){
    
            data = UIImageJPEGRepresentation(imgCurr, 0.1);
        }
    
        else if(imgValue > 2000){
    
            data = UIImageJPEGRepresentation(imgCurr, 0.3);
        }
        else{
    
            data = UIImagePNGRepresentation(imgCurr);
        }
    
    Appdelegate_hairista.progressCurr =  [[ImgurAnonymousAPIClient client] uploadImageData:data
                                                                              withFilename:[NSString stringWithFormat:@"%@.jpg",title]
                                                                         completionHandler:^(NSURL *imgurURL, NSError *error) {
                                                                             
                                                                             if(error){
                                                                             
                                                                             [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:^(UIAlertAction *alertAction) {
                                                                                 
                                                                             [Appdelegate_hairista closeProgress];
                                                                             
                                                                             }];
                                                                    }
                                                                    else{
                                                                             
                                                                        [self uploadImageForSalon:imgurURL.absoluteString];
                                                                        
                                                                    }
                           }];
    [Appdelegate_hairista showProcessBar:imgCurr progress: Appdelegate_hairista.progressCurr];
    
    [UIView animateWithDuration:0.5
                     animations:^{self.alpha = 0.0;}
                     completion:^(BOOL finished){ [self removeFromSuperview];
                     }];

}
-(void)uploadImageForSalon:(NSString *)urlImage{

    [[SalonManage sharedInstance] uploadUrlImageForSalon:urlImage name:self.tfImageName.text idSalon:salonCurr.idSalon dataResult:^(NSError *error, id idObject) {
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
            
        }else{
            NSString *mesg = [NSString stringWithFormat:@"Hình ảnh của bạn đã được chia sẽ trên Salon %@",salonCurr.name];
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:mesg buttonClick:nil];
        }
        
        [Appdelegate_hairista closeProgress];
    
    }];
}

@end
