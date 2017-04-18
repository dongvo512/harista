//
//  ManageBookingCell.m
//  hairista
//
//  Created by Dong Vo on 2/12/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ManageBookingCell.h"
#import "Booking.h"


@interface ManageBookingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lblUserPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeBooking;

@end

@implementation ManageBookingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataForCell:(Booking *)booking{

    self.imgViewAvatar.image = [UIImage imageNamed:booking.imgAvtarName];
    
    self.lblUserName.text = booking.strUserNameBooking;
    
    self.lblUserPhone.text = booking.strUserPhone;
    
    self.lblServiceName.text = booking.strListService;
    
    self.lblTimeBooking.text = booking.strDate;
    
}

@end
