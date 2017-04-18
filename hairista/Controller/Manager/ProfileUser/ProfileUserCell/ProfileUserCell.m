//
//  ProfileUserCell.m
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ProfileUserCell.h"

@interface ProfileUserCell ()
@property (weak, nonatomic) IBOutlet UIView *viewDateBooking;

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

@end
