//
//  UserCell.m
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "UserCell.h"
#import "User.h"


@interface UserCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UILabel *lblFullName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

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

-(void)setDataForCell:(User *)user{

    self.imgUser.image = [UIImage imageNamed:user.strImgAvatar];
    self.lblAddress.text = user.strAddress;
    self.lblFullName.text = user.strFullName;
    
}


@end
