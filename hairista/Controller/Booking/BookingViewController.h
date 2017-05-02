//
//  BookingViewController.h
//  hairista
//
//  Created by Dong Vo on 2/9/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Salon;

@interface BookingViewController : UIViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Salon:(Salon *)salon;
@end
