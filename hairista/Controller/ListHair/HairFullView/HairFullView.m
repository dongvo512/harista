//
//  HairFullView.m
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "HairFullView.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HairFullView (){

    NSString *imgName;
    NSString *title;
}

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lblName;


@end

@implementation HairFullView

- (id)initWithFrame:(CGRect)frame imgName:(NSString *)aImgName title:(NSString *)aTitle{
   
    if(self = [super initWithFrame:frame]){
        
        imgName = aImgName;
        title = aTitle;
        [self setup];
    }
    return self;
}
- (void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"HairFullView" owner:self options:nil].firstObject;
    
    self.view.frame = self.bounds;
    self.alpha = 0;
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.alpha = 1.0;
                     }
                     completion:nil];
    
    [self addSubview:self.view];
    
    [self.imgViewHair sd_setImageWithURL:[NSURL URLWithString:imgName] placeholderImage:IMG_DEFAULT];
    self.lblName.text = title;
}
- (IBAction)tapView:(id)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{self.alpha = 0.0;}
                     completion:^(BOOL finished){ [self removeFromSuperview]; }];
    
    
}
- (IBAction)touchBtnSave:(id)sender {
   
    if(self.imgViewHair.image){
    
        UIImageWriteToSavedPhotosAlbum(self.imgViewHair.image, nil, nil, nil);
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Đã lưu hình và máy của bạn" buttonClick:nil];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
