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
    
    [self.imgViewBanner sd_setImageWithURL:[NSURL URLWithString:salon.avatar] placeholderImage:IMG_DEFAULT];
    self.lblSalonName.text = salon.name;
    self.lblSalonPhone.text = [Common convertPhone84:salon.phone];
    
    self.widthContraint.constant = (80/5)*salon.avgRate.integerValue;
    
    self.trailingStar.constant = (80 - (80/5)*salon.avgRate.integerValue) + 8;
    
    if(salon.openTime.length > 0 && salon.closeTime.length > 0){
        
        NSString *openTime = [salon.openTime substringWithRange:NSMakeRange(0, salon.openTime.length - 3)];
        
        NSString *closeTime = [salon.closeTime substringWithRange:NSMakeRange(0, salon.closeTime.length - 3)];
        
        self.lblSalonTimeOpen.text = [NSString stringWithFormat:@"%@ - %@", openTime, closeTime];
    }
    else{
    
        self.lblSalonTimeOpen.text = @"";
    }
}

@end
