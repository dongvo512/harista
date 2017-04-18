//
//  ChooseImageView.h
//  hairista
//
//  Created by Dong Vo on 4/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Salon;

@interface ChooseImageView : UIView

- (id)initWithFrame:(CGRect)frame imgName:(NSString *)aImgName image:(UIImage *)image salon:(Salon *)salon;

@end
