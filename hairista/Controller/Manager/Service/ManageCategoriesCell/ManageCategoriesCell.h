//
//  ManageCategoriesCell.h
//  hairista
//
//  Created by Dong Vo on 5/11/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category;

@interface ManageCategoriesCell : UICollectionViewCell

-(void)setDataForCell:(Category *)categories;

@end
