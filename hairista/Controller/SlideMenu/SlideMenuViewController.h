//
//  SlideMenuViewController.h
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuLeftView.h"

@interface SlideMenuViewController : UIViewController

+ (id)sharedInstance;
+ (void)resetSharedInstance;
@property (nonatomic, strong) MenuLeftView *viewMenuLeft;
@property (nonatomic) BOOL isUserManager;
// nhấn nút menu.
-(void)toggle;

// set tỉ lệ menu trái với màn hình.
-(void)setRatioWidthMenuLeft:(CGFloat)ratio;

// thay root Viewcontroller cho navigationcontroller với danh sách items trên Menu.
- (void)selectedItemInMenu:(NSInteger )index;

@end
