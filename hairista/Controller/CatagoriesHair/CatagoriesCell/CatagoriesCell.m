//
//  CatagoriesCell.m
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CatagoriesCell.h"
#import "CommonDefine.h"
#import "Catagories.h"

#define NUM_ITEM 2
#define MARGIN 8

@interface CatagoriesCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgCatagories;
@property (weak, nonatomic) IBOutlet UILabel *lblCatagoriesName;

@end
@implementation CatagoriesCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    CGFloat width = (SW - ((NUM_ITEM + 1) *MARGIN ))/2;
    self.imgCatagories.layer.cornerRadius = width/2;
    
    
}

-(void)setDataForCell:(Catagories *)catagories{

    self.lblCatagoriesName.text = catagories.nameGroup;
    self.imgCatagories.image = [UIImage imageNamed:catagories.imgNameGroup];
    
}
@end
