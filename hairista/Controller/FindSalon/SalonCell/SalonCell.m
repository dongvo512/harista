//
//  SalonCell.m
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SalonCell.h"
#import "Salon.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SalonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgSalon;
@property (weak, nonatomic) IBOutlet UILabel *lblOpenTime;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingStar;

@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonPhone;

@property (weak, nonatomic) IBOutlet UILabel *lblSalonAddress;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintStart;

@end

@implementation SalonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataForCell:(Salon *)salon{
    
    [self.imgSalon sd_setImageWithURL:[NSURL URLWithString:salon.avatar] placeholderImage:IMG_DEFAULT];
    self.lblSalonPhone.text = salon.phone;
    self.lblSalonName.text = salon.name;
    self.lblSalonAddress.text = salon.homeAddress;
    
    if(salon.openTime.length > 0 && salon.closeTime.length > 0){
        
        NSString *openTime = [salon.openTime substringWithRange:NSMakeRange(0, salon.openTime.length - 3)];
        
        NSString *closeTime = [salon.closeTime substringWithRange:NSMakeRange(0, salon.closeTime.length - 3)];
        
        self.lblOpenTime.text = [NSString stringWithFormat:@"%@ - %@", openTime, closeTime];
    }
    else{
        
        self.lblOpenTime.text = @"";
    }

    self.widthContraintStart.constant = (80/5)*salon.avgRate.integerValue;
    
    self.trailingStar.constant = (80 - (80/5)*salon.avgRate.integerValue) + 8;

}

@end
