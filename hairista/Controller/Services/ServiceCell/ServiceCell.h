//
//  ServiceCell.h
//  hairista
//
//  Created by Dong Vo on 2/5/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Service;

@interface ServiceCell : UICollectionViewCell
-(void)setDataForCell:(Service *)service;
@end
