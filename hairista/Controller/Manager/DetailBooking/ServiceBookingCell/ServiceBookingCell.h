//
//  ServiceBookingCell.h
//  hairista
//
//  Created by Dong Vo on 2/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Service;

@interface ServiceBookingCell : UITableViewCell

-(void)setDataForCell:(Service *)service;

@end
