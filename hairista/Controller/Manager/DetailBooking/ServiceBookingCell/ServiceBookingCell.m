//
//  ServiceBookingCell.m
//  hairista
//
//  Created by Dong Vo on 2/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServiceBookingCell.h"
#import "Service.h"

@interface ServiceBookingCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblSerivceName;
@property (weak, nonatomic) IBOutlet UILabel *lblServicePrice;

@end

@implementation ServiceBookingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataForCell:(Service *)service{

    self.lblSerivceName.text = service.name;
    
    self.lblServicePrice.text = [Common getString3DigitsDot:service.price.integerValue];
}
@end
