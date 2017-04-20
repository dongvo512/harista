//
//  CommentCellTableViewCell.m
//  hairista
//
//  Created by Dong Vo on 2/7/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CommentCellTableViewCell.h"
#import "Comment.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CommentCellTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgAvatar;
@property (weak, nonatomic) IBOutlet UILabel *lblNumStar;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;
@property (weak, nonatomic) IBOutlet UILabel *lblDateComment;

@property (weak, nonatomic) IBOutlet UILabel *lblName;

@end

@implementation CommentCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataForCell:(Comment *)comment{

    self.lblName.text = comment.user.name;
    self.lblComment.text = comment.message;
    
    [self.imgAvatar sd_setImageWithURL:[NSURL URLWithString:comment.user.avatar] placeholderImage:IMG_USER_DEFAULT];
    self.lblNumStar.text = comment.rate;
    self.lblDateComment.text = [Common formattedDateTimeWithDateString:comment.createdAt inputFormat:@"yyyy-MM-dd HH:mm:ss" outputFormat:@"dd/MM/yyyy"];
    
}
@end
