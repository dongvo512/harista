//
//  CategoriesManageCell.h
//  hairista
//
//  Created by Dong Vo on 5/24/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Category;
@interface CategoriesManageCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblCategoriesName;
@property (nonatomic, weak) id delegate;
@property (nonatomic, weak) Category *catCurr;
@end
@protocol CategoriesManageCellDelegate <NSObject>

-(void)touchButtonEdit:(Category *)cat;

@end
