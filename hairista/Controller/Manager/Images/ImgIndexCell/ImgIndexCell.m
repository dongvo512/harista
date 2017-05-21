//
//  ImgIndexCell.m
//  hairista
//
//  Created by Dong Vo on 5/21/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ImgIndexCell.h"
#import "Image.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ImgIndexCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblImageName;

@end

@implementation ImgIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataForCell:(Image *)img{

     [self.imgView sd_setImageWithURL:[NSURL URLWithString:img.url] placeholderImage:IMG_DEFAULT];
    self.lblImageName.text = img.name;
}
@end
