//
//  UserInfoView.m
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "UserInfoView.h"
#import "SessionUser.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface UserInfoView (){

    SessionUser *user;
}
@property (weak, nonatomic) IBOutlet UILabel *lblHomeAddress;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;

@end

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame User:(SessionUser *)aUser{
    
    if(self = [super initWithFrame:frame]){
        
        user = aUser;
        [self setup];
    }
    return self;
}
- (void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"UserInfoView" owner:self options:nil].firstObject;
    
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    [self loadDataForUI];
    
}
-(void)loadDataForUI{
    
    [self.imgAvatar sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:IMG_USER_DEFAULT];
    self.lblName.text = user.name;
    self.lblEmail.text = user.email;
    self.lblPhone.text = [Common convertPhone84:user.phone];
    self.lblHomeAddress.text = user.homeAddress;
}

@end
