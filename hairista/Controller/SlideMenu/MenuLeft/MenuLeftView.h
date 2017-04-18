//
//  MenuLeftView.h
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuLeftView : UIView

- (id) init:(BOOL)isUserManager;

- (id)initWithFrame:(CGRect)frame isUserManager:(BOOL)isUserManager;

- (void)loadUserInfo;

@property (nonatomic) BOOL isUserManager;
@property (strong, nonatomic) IBOutlet UIView *view;
@end
