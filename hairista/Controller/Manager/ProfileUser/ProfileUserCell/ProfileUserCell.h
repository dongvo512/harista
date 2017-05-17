//
//  ProfileUserCell.h
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Booking;

@interface ProfileUserCell : UITableViewCell
-(void)setDataForCell:(Booking *)booking;
@end
