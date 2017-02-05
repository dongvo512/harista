//
//  HairFullView.h
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Hair;

@interface HairFullView : UIView
- (id)initWithFrame:(CGRect)frame hair:(Hair *)hair;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewHair;;
@end