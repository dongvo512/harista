//
//  ManageCategoriesCell.m
//  hairista
//
//  Created by Dong Vo on 5/11/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ManageCategoriesCell.h"
#import "Category.h"


@interface ManageCategoriesCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoriyName;

@end

@implementation ManageCategoriesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataForCell:(Category *)categories{

    self.lblCategoriyName.text = categories.name;
    [self.imgView setImage:[UIImage imageNamed:categories.image]];
}

@end
