//
//  ServerSelectedCell.m
//  hairista
//
//  Created by Dong Vo on 4/30/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServerSelectedCell.h"
#import "Service.h"

@interface ServerSelectedCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblServiceName;
@property (weak, nonatomic) IBOutlet UILabel *lblServicePrice;

@end

@implementation ServerSelectedCell

-(void)setDataForCell:(Service *)service{

    self.lblServiceName.text = service.name;
    
    self.lblServicePrice.text = service.price;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
