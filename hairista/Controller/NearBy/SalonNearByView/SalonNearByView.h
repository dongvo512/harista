//
//  SalonNearByView.h
//  hairista
//
//  Created by Dong Vo on 4/28/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Salon;


@interface SalonNearByView : UIView
@property (strong, nonatomic) IBOutlet UIView *view;
-(void)setDataForView:(Salon *)salon;
@end
