//
//  ServiceBookingSelectCell.m
//  hairista
//
//  Created by Dong Vo on 2/5/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServiceBookingSelectCell.h"
#import "Service.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ServiceBookingSelectCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgService;
@property (weak, nonatomic) IBOutlet UIImageView *imgSelect;
@property (nonatomic, strong) Service *serviceCurr;
@end

@implementation ServiceBookingSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lblPrice.layer.cornerRadius = 2;
    
}
-(void)setDataForCell:(Service *)service{

    self.serviceCurr = service;
    
    [self.imgSelect setHidden:(service.isSelected)?NO:YES];
    
    [self.imgService sd_setImageWithURL:[NSURL URLWithString:service.image] placeholderImage:IMG_DEFAULT];
    self.lblPrice.text = service.price.stringValue;
  
    self.lblServiceName.text = service.name;
 
}

@end
