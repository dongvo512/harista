//
//  NCNotificationView.h
//  hairista
//
//  Created by Dong Vo on 10/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Notification;

@interface NCNotificationView : UIView

- (id)initWithFrame:(CGRect)frame notification:(Notification *)aNotification;

@end
