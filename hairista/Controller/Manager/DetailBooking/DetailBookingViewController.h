//
//  DetailBookingViewController.h
//  hairista
//
//  Created by Dong Vo on 2/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Booking;

@interface DetailBookingViewController : UIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil booking:(Booking *)aBooking editing:(BOOL)aEdit;
@property (nonatomic, weak) id delegate;

@end
@protocol DetailBookingViewControllerDelegate <NSObject>

-(void)finishAceptBooking:(Booking *)booking;
-(void)finishCancelBooking:(Booking *)booking;

@end
