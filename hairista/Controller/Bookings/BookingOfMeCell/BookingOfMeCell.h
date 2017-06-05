//
//  BookingOfMeCell.h
//  hairista
//
//  Created by Dong Vo on 5/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Booking;

@interface BookingOfMeCell : UITableViewCell

@property (nonatomic, weak) id delegate;
-(void)setDataForCell:(Booking *)booking;

@end
@protocol  BookingOfMeCellDelegate <NSObject>

-(void)touchBtnGo:(Booking *)booking;

@end
