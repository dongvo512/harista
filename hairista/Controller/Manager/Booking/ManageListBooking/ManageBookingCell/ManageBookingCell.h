//
//  ManageBookingCell.h
//  hairista
//
//  Created by Dong Vo on 2/12/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Booking;

@interface ManageBookingCell : UITableViewCell

-(void)setDataForCell:(Booking *)booking;

@end
