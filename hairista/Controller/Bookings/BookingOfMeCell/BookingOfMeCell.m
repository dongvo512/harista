//
//  BookingOfMeCell.m
//  hairista
//
//  Created by Dong Vo on 5/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "BookingOfMeCell.h"
#import "Booking.h"

@interface BookingOfMeCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblBookingName;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintPin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingContraintPin;
@property (weak, nonatomic) IBOutlet UIImageView *imgPin;

@end

@implementation BookingOfMeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataForCell:(Booking *)booking{
 
    NSDate *dateCurr = [Common getDateFromStringFormat:booking.startDate format:@"yyyy-MM-dd HH:mm:ss"];
    
    if([dateCurr compare:[NSDate date]] == NSOrderedDescending)
    {
        [self.lblBookingName setAlpha:1.0];
        [self.lblSalonName setAlpha:1.0];
        [self.lblStartDate setAlpha:1.0];
        [self.lblTotalPrice setAlpha:1.0];
        
        [self.imgPin setHidden:NO];
        self.widthContraintPin.constant = 30;
        self.leadingContraintPin.constant = 8;
    }
    else{
    
        [self.lblBookingName setAlpha:0.5];
        [self.lblSalonName setAlpha:0.5];
        [self.lblStartDate setAlpha:0.5];
        [self.lblTotalPrice setAlpha:0.5];
        
         [self.imgPin setHidden:YES];
        self.widthContraintPin.constant = 0;
        self.leadingContraintPin.constant = 0;
    }
    
    
    self.lblBookingName.text = booking.name;
    
    self.lblSalonName.text = [NSString stringWithFormat:@"Tại:%@",booking.salon.name];
    
    self.lblStartDate.text = [Common formattedDateTimeWithDateString:booking.startDate inputFormat:@"yyyy-MM-dd HH:mm:ss" outputFormat:@"dd/MM/yyyy HH:mm"];
    
    NSString *totalPrice = [Common getString3DigitsDot:booking.totalPrice.integerValue];
    self.lblTotalPrice.text = [NSString stringWithFormat:@"%@ đ",totalPrice];
}
@end
