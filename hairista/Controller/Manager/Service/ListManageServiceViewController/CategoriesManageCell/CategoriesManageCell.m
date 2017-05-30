//
//  CategoriesManageCell.m
//  hairista
//
//  Created by Dong Vo on 5/24/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CategoriesManageCell.h"
#import "Category.h"

@interface CategoriesManageCell ()

@end

@implementation CategoriesManageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)touchBtnEdit:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(touchButtonEdit:)]){
    
        [[self delegate] touchButtonEdit:self.catCurr];
    }
}

@end
