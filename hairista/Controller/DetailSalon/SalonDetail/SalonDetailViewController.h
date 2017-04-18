//
//  SalonDetailViewController.h
//  hairista
//
//  Created by Dong Vo on 4/13/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Salon;

@interface SalonDetailViewController : UIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salon:(Salon *)salon;

@end
