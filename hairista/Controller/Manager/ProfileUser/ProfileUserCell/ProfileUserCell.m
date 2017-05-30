//
//  ProfileUserCell.m
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ProfileUserCell.h"
#import "Booking.h"

@interface ProfileUserCell ()

@property (weak, nonatomic) IBOutlet UIView *viewDateBooking;
@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lblThuAndTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;

@end

@implementation ProfileUserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.viewDateBooking.layer.masksToBounds = NO;
    self.viewDateBooking.layer.shadowOffset = CGSizeMake(0, 3);
    self.viewDateBooking.layer.shadowRadius = 3;
    self.viewDateBooking.layer.shadowOpacity = 0.1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataForCell:(Booking *)booking{

    self.lblSalonName.text = booking.salon.name;
    
    NSString *dayName = [Common getDayInWeekVietNamese:[Common getDateFromStringFormat:booking.startDate format:@"yyyy-MM-dd HH:mm:ss"]];
    
    NSString *strStartTime = [Common formattedDateTimeWithDateString:booking.startDate inputFormat:@"yyyy-MM-dd HH:mm:ss" outputFormat:@"HH:mm"];
    
    self.lblThuAndTime.text = [NSString stringWithFormat:@"%@ lúc %@",dayName,strStartTime];
    
    NSString *strDay = [Common formattedDateTimeWithDateString:booking.startDate inputFormat:@"yyyy-MM-dd HH:mm:ss" outputFormat:@"dd"];

    self.lblDay.text = strDay;
    
    self.lblDate.text = [Common formattedDateTimeWithDateString:booking.startDate inputFormat:@"yyyy-MM-dd HH:mm:ss" outputFormat:@"dd/MM/yyyy"];
    
    NSString *totalPrice = [Common getString3DigitsDot:booking.totalPrice.integerValue];
    
    self.lblTotalPrice.text = [NSString stringWithFormat:@"%@ đ",totalPrice];
}
@end
