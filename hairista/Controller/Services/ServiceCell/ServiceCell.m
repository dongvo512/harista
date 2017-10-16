//
//  ServiceCell.m
//  hairista
//
//  Created by Dong Vo on 2/5/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServiceCell.h"
#import "Service.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ServiceCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgService;
@property (nonatomic, strong) Service *serviceCurr;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;

@end

@implementation ServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lblPrice.layer.cornerRadius = 2;
    
}
-(void)setDataForCell:(Service *)service{

    self.serviceCurr = service;
        
    [self.btnDelete setHidden:(self.isManager)?NO:YES];
    
    [self.imgService sd_setImageWithURL:[NSURL URLWithString:service.image] placeholderImage:IMG_DEFAULT];
    
    self.lblPrice.text = [NSString stringWithFormat:@"%@ đ",[Common getString3DigitsDot:service.price.integerValue]];
    
    self.lblServiceName.text = service.name;
 
}
- (IBAction)touchBtnDelete:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(deleteService:)]){
        
        [[self delegate] deleteService:self.serviceCurr];
    }
    
}

@end
