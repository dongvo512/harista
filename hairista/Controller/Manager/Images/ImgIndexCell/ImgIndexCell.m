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
#import "UIColor+Method.h"

#define MAX_INDEX 10

@interface ImgIndexCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *lblImageName;
@property (weak, nonatomic) IBOutlet UIView *viewIndex;
@property (weak, nonatomic) IBOutlet UILabel *lblIndex;

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
-(void)setDataForCell:(Image *)img indexCurr:(NSInteger)index{

     [self.imgView sd_setImageWithURL:[NSURL URLWithString:img.url] placeholderImage:IMG_DEFAULT];
    self.lblImageName.text = img.name;
    
    if(index < MAX_INDEX && img.index != -1){
    
        [self.contentView setBackgroundColor:[UIColor colorFromHexString:@"FFF2E6"]];
        [self.viewIndex setHidden:NO];
        self.lblIndex.text = [NSString stringWithFormat:@"%ld",img.index];
    }
    else{
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
        [self.viewIndex setHidden:YES];
    }
}
@end
