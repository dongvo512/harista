//
//  PopupTimeViewController.h
//  hairista
//
//  Created by Dong Vo on 5/29/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopupTimeViewController : UIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dateSelected:(NSDate *)aDateSelected;

@property (nonatomic, weak) id delegate;
- (void)presentInParentViewController:(UIViewController *)parentViewController;

- (void)dismissFromParentViewController;

@end
@protocol PopupTimeViewControllerDelegate <NSObject>

-(void)touchButtonFinish:(NSDate *)dateSelected controller:(PopupTimeViewController *)controller;

@end
