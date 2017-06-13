//
//  SalonAdminCell.h
//  hairista
//
//  Created by Dong Vo on 6/8/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Salon;

@interface SalonAdminCell : UITableViewCell

@property (nonatomic, weak) id delegate;

-(void)setDataForCell:(Salon *)salon;
@end
@protocol SalonAdminCellDelegate <NSObject>

-(void)touchBtnToUser:(Salon *)salon;

@end
