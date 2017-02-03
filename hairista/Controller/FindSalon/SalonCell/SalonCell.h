//
//  SalonCell.h
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Salon;

@interface SalonCell : UITableViewCell

-(void)setDataForCell:(Salon *)salon;

@end
