//
//  ManageListBookingViewController.h
//  hairista
//
//  Created by Dong Vo on 2/12/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ManageBookingViewController;

@interface ManageListBookingViewController : UIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil type:(NSInteger)type;

@property (nonatomic, weak) ManageBookingViewController *vcManageBooking;

@end
