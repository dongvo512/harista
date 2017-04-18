//
//  ServiceCell.m
//  hairista
//
//  Created by Dong Vo on 2/5/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServiceCell.h"
#import "Service.h"


@interface ServiceCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lblPrice;
@property (weak, nonatomic) IBOutlet UIImageView *imgService;


@end

@implementation ServiceCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDataForCell:(Service *)service{

    [self.imgSelected setHidden:!service.isSelected];
    self.lblPrice.text = service.price;
    self.lblServiceName.text = service.name;
    self.imgService.image = [UIImage imageNamed:service.imgNameService];
}
@end
