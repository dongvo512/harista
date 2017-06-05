//
//  BookingOfMeCell.m
//  hairista
//
//  Created by Dong Vo on 5/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "BookingOfMeCell.h"
#import "Booking.h"

#define STATUS_PENDING @"pending"
#define STATUS_DONE @"done"
#define STATUS_CANCEL @"cancel"

@interface BookingOfMeCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;
@property (weak, nonatomic) IBOutlet UILabel *lblStartDate;
@property (weak, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintPin;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingContraintPin;
@property (weak, nonatomic) IBOutlet UIImageView *imgPin;
@property (nonatomic, weak) Booking *bookingCurr;

@property (weak, nonatomic) IBOutlet UIImageView *imgState;

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
 
    self.bookingCurr = booking;
    
    if([booking.status isEqualToString:STATUS_PENDING]){
        
        [self.imgState setHidden:NO];
        [self.imgState setImage:[UIImage imageNamed:@"ic_note_booking"]];
    }
    
    if([booking.status isEqualToString:STATUS_CANCEL]){
        
        
        [self.imgState setHidden:NO];
        [self.imgState setImage:[UIImage imageNamed:@"ic_delete_booking"]];
    }
    
    if([booking.status isEqualToString:STATUS_DONE]){
        
        [self.imgState setHidden:NO];
        [self.imgState setImage:[UIImage imageNamed:@"ic_checked_booking"]];
    }
    
    
    NSDate *dateCurr = [Common getDateFromStringFormat:booking.startDate format:@"yyyy-MM-dd HH:mm:ss"];
    
    if([dateCurr compare:[NSDate date]] == NSOrderedDescending)
    {
      
        [self.lblSalonName setAlpha:1.0];
        [self.lblStartDate setAlpha:1.0];
        [self.lblTotalPrice setAlpha:1.0];
        
        [self.imgPin setHidden:NO];
        self.widthContraintPin.constant = 30;
        self.leadingContraintPin.constant = 8;
    }
    else{
    

        [self.lblSalonName setAlpha:0.5];
        [self.lblStartDate setAlpha:0.5];
        [self.lblTotalPrice setAlpha:0.5];
        
         [self.imgPin setHidden:YES];
        self.widthContraintPin.constant = 0;
        self.leadingContraintPin.constant = 0;
    }
    
    
    
    self.lblSalonName.text = [NSString stringWithFormat:@"Tại %@",booking.salon.name];
    
    self.lblStartDate.text = [Common formattedDateTimeWithDateString:booking.startDate inputFormat:@"yyyy-MM-dd HH:mm:ss" outputFormat:@"dd/MM/yyyy HH:mm"];
    
    NSString *totalPrice = [Common getString3DigitsDot:booking.totalPrice.integerValue];
    self.lblTotalPrice.text = [NSString stringWithFormat:@"%@ đ",totalPrice];
}
- (IBAction)touchBtnGo:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(touchBtnGo:)]){
    
        [[self delegate] touchBtnGo:self.bookingCurr];
    }
}


@end
