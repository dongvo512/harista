//
//  HeaderBannerCell.h
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Salon;
@interface HeaderBannerCell : UICollectionViewCell
-(void)setDataForCell:(Salon *)salon;
@end
