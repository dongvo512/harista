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
- (IBAction)touchBtnShare:(id)sender {
    
        NSData *data= nil;
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
                                                                             
                                                          //                   [Appdelegate_hairista closeProgress];
                                                                             
                                                                             //                                                                             strUrlAvart = imgurURL.absoluteString;
                                                                             //
                                                                             //                                                                             [self uploadImagUrl:strUrlAvart];
                                                                             
                                                                         }];
    [Appdelegate_hairista showProcessBar:imgCurr];
    
    [UIView animateWithDuration:0.5
                     animations:^{self.alpha = 0.0;}
                     completion:^(BOOL finished){ [self removeFromSuperview];
                     }];

}
-(void)uploadImageForSalon:(NSString *)urlImage{

    [[SalonManage sharedInstance] uploadUrlImageForSalon:urlImage idSalon:salonCurr.idSalon dataResult:^(NSError *error, id idObject) {
        
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
