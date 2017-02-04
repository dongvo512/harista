//
//  HairCell.m
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "HairCell.h"
#import "Hair.h"

@interface HairCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgHair;

@end

@implementation HairCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setDataForCell:(Hair *)hair{

    self.imgHair.image = [UIImage imageNamed:hair.imgName];
}
@end
