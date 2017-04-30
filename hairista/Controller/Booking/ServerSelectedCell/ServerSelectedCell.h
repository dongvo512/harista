//
//  ServerSelectedCell.h
//  hairista
//
//  Created by Dong Vo on 4/30/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Service;

@interface ServerSelectedCell : UITableViewCell

-(void)setDataForCell:(Service *)service;

@end
