//
//  HeaderSalonView.m
//  hairista
//
//  Created by Dong Vo on 4/15/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "HeaderSalonView.h"
#import "Salon.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define WIDTH_STAR 16

@interface HeaderSalonView ()

@property (weak, nonatomic) IBOutlet UIImageView *imgSalon;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;
@property (weak, nonatomic) IBOutlet UIButton *btnFavourite;
@property (weak, nonatomic) IBOutlet UIButton *btnLocation;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblOpenTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalComment;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintStar;
@property (nonatomic, strong) Salon *salonCurr;
@end

@implementation HeaderSalonView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)clickBtnLocation:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(selectLocation)]){
    
        [[self delegate] selectLocation];
    }
}
- (IBAction)clickFavorite:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(selectFavorite)]){
        
        [[self delegate] selectFavorite];
    }
}

-(void)setDataForView:(Salon *)salon{

    self.salonCurr = salon;
    
    [self.imgSalon sd_setImageWithURL:[NSURL URLWithString:salon.avatar] placeholderImage:IMG_DEFAULT];
    self.lblSalonName.text = salon.name;
    
    self.lblAddress.text = salon.homeAddress;
    
    self.lblPhone.text = salon.phone;
    
    self.lblOpenTime.text = [NSString stringWithFormat:@"Mở cửa: %@ - %@", salon.openTime, salon.closeTime];
    
    self.widthContraintStar.constant = salon.avgRate.integerValue *WIDTH_STAR;
    
    self.lblTotalComment.text = [NSString stringWithFormat:@"%@ bình luận",salon.totalComment];
    
  //  self.btnFavourite setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal
    
}

@end
