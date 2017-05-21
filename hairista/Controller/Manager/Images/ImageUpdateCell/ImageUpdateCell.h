//
//  ImageUpdateCell.h
//  hairista
//
//  Created by Dong Vo on 5/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBCircularProgressBarView.h"
@class ImageUploadObject;

@interface ImageUpdateCell : UICollectionViewCell

-(void)setDataForCell:(ImageUploadObject *)image;
-(void)updatingProgress:(NSInteger)value;
-(void)showError;
@end
