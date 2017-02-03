//
//  SalonCell.m
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SalonCell.h"
#import "Salon.h"


@interface SalonCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgSalon;

@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonPhone;

@property (weak, nonatomic) IBOutlet UILabel *lblSalonAddress;

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

    self.imgSalon.image = [UIImage imageNamed:salon.strSalonUrl];
    
    self.lblSalonPhone.text = salon.strPhone;
    
    self.lblSalonName.text = salon.strSalonName;
    
    self.lblSalonAddress.text = salon.strAddress;
}

@end
