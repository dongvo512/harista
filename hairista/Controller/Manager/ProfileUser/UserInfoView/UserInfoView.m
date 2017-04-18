//
//  UserInfoView.m
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "UserInfoView.h"
#import "User.h"


@interface UserInfoView (){

    User *user;
}
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation UserInfoView

- (id)initWithFrame:(CGRect)frame User:(User *)aUser{
    
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
    
}

@end
