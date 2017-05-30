//
//  PopupCreateCategoryViewController.h
//  hairista
//
//  Created by Dong Vo on 5/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupCreateCategoryViewController : UIViewController

@property (nonatomic, weak) id delegate;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil edit:(BOOL)isEdit cateName:(NSString *)catName;

- (void)presentInParentViewController:(UIViewController *)parentViewController;

- (void)dismissFromParentViewController ;

@end

@protocol  PopupCreateCategoryViewControllerDelegate <NSObject>

-(void)touchButtonFinish:(NSString *)catName edit:(BOOL)isEdit;

@end
