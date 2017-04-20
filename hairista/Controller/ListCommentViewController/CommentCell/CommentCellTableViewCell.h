//
//  CommentCellTableViewCell.h
//  hairista
//
//  Created by Dong Vo on 2/7/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Comment;

@interface CommentCellTableViewCell : UITableViewCell

-(void)setDataForCell:(Comment *)comment;

@end
