//
//  SalonAdminCell.m
//  hairista
//
//  Created by Dong Vo on 6/8/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SalonAdminCell.h"
#import "Salon.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SalonAdminCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgSalon;

@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonPhone;

@property (weak, nonatomic) IBOutlet UILabel *lblSalonAddress;

@property (weak, nonatomic) IBOutlet UILabel *lblHot;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintHot;

@property (nonatomic, weak) Salon *salonCurr;
@end

@implementation SalonAdminCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(void)setDataForCell:(Salon *)salon{
    
    self.salonCurr = salon;
    
    if([salon.isShowOnBoard boolValue]){
    
        [self.lblHot setHidden:NO];
        self.widthContraintHot.constant = 55;
    }
    else{
        
        [self.lblHot setHidden:YES];
        self.widthContraintHot.constant = 0;
    }
    
    [self.imgSalon sd_setImageWithURL:[NSURL URLWithString:salon.avatar] placeholderImage:IMG_DEFAULT];
    self.lblSalonPhone.text = [Common convertPhone84:salon.phone];
    self.lblSalonName.text = salon.name;
    self.lblSalonAddress.text = salon.homeAddress;
}

- (IBAction)touchBtnUser:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(touchBtnToUser:)]){
    
        [[self delegate] touchBtnToUser:self.salonCurr];
    }
}


@end
