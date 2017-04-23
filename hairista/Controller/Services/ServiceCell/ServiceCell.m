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

@end

@implementation ServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lblPrice.layer.cornerRadius = 2;
    
}
-(void)setDataForCell:(Service *)service{

   
    [self.imgService sd_setImageWithURL:[NSURL URLWithString:service.image] placeholderImage:IMG_DEFAULT];
    self.lblPrice.text = service.price;
    self.lblPrice.text = service.price;
    self.lblServiceName.text = service.name;
 
}
@end
