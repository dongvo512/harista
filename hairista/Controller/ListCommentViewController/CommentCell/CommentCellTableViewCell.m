//
//  CommentCellTableViewCell.m
//  hairista
//
//  Created by Dong Vo on 2/7/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CommentCellTableViewCell.h"
#import "Comment.h"


@interface CommentCellTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblComment;

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

    self.lblName.text = comment.strName;
    self.lblComment.text = comment.comment;
}
@end
