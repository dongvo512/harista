//
//  HeaderBannerCell.m
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "HeaderBannerCell.h"
#import "Salon.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface HeaderBannerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonTimeOpen;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewRating;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingStar;

@end

@implementation HeaderBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataForCell:(Salon *)salon{

  //  self.imgViewBanner.image = [UIImage imageNamed:salon.strSalonUrl];
    
   // salon.avgRate = @"3";
    
    [self.imgViewBanner sd_setImageWithURL:[NSURL URLWithString:salon.avatar] placeholderImage:IMG_DEFAULT];
    self.lblSalonName.text = salon.name;
    self.lblSalonPhone.text = salon.phone;
    
    self.widthContraint.constant = (80/5)*salon.avgRate.integerValue;
    
    self.trailingStar.constant = (80 - (80/5)*salon.avgRate.integerValue) + 8;
    
    self.lblSalonTimeOpen.text = [NSString stringWithFormat:@"%@ - %@",salon.openTime,salon.closeTime];
}

@end
