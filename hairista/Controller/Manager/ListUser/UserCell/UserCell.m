//
//  UserCell.m
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "UserCell.h"
#import "SessionUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@end

@implementation UserCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - Method

-(void)setDataForCell:(SessionUser *)user{
    
     [self.imgUser sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:IMG_USER_DEFAULT];
    
    self.lblAddress.text = user.homeAddress;
    self.lblFullName.text = user.name;
    self.lblPhone.text = user.phone;
    
}


@end
