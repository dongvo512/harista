//
//  ImgIndexCell.h
//  hairista
//
//  Created by Dong Vo on 5/21/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Image;

@interface ImgIndexCell : UITableViewCell

-(void)setDataForCell:(Image *)img indexCurr:(NSInteger)index;

@end
