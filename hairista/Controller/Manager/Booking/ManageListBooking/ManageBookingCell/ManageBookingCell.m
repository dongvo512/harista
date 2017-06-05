//
//  ManageBookingCell.m
//  hairista
//
//  Created by Dong Vo on 2/12/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ManageBookingCell.h"
#import "Booking.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define STATUS_PENDING @"pending"
#define STATUS_DONE @"done"
#define STATUS_CANCEL @"cancel"

@interface ManageBookingCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgViewAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblUserName;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblUserPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblTimeBooking;
@property (weak, nonatomic) IBOutlet UIImageView *imgStatus;

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

    if([booking.status isEqualToString:STATUS_PENDING]){
    
        [self.imgStatus setHidden:NO];
        [self.imgStatus setImage:[UIImage imageNamed:@"ic_note_booking"]];
    }
    
    if([booking.status isEqualToString:STATUS_CANCEL]){
    
        
        [self.imgStatus setHidden:NO];
        [self.imgStatus setImage:[UIImage imageNamed:@"ic_delete_booking"]];
    }
    
    if([booking.status isEqualToString:STATUS_DONE]){
       
        [self.imgStatus setHidden:NO];
        [self.imgStatus setImage:[UIImage imageNamed:@"ic_checked_booking"]];
    }
    
     [self.imgViewAvatar sd_setImageWithURL:[NSURL URLWithString:booking.user.avatar] placeholderImage:IMG_USER_DEFAULT];
    
    self.lblUserName.text = booking.name;
    
    self.lblUserPhone.text = [Common convertPhone84:booking.user.phone];
    
    if(booking.totalPrice.length > 0){
    
        NSString *strTotal = [Common getString3DigitsDot:booking.totalPrice.integerValue];
        self.lblTotalPrice.text = [NSString stringWithFormat:@"%@ đ",strTotal];
    }
    
    NSString *dayName = [Common getDayInWeekVietNamese:[Common getDateFromStringFormat:booking.startDate format:@"yyyy-MM-dd HH:mm:ss"]];
    
    NSString *strStartTime = [Common formattedDateTimeWithDateString:booking.startDate inputFormat:@"yyyy-MM-dd HH:mm:ss" outputFormat:@"dd/MM/yyyy HH:mm"];
    
    self.lblTimeBooking.text = [NSString stringWithFormat:@"%@, %@",dayName,strStartTime];
    
}

@end
