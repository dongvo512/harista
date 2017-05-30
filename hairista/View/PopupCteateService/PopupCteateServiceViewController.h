//
//  PopupCteateServiceViewController.h
//  hairista
//
//  Created by Dong Vo on 5/27/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Service;

@interface PopupCteateServiceViewController : UIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil edit:(BOOL)isEdit service:(Service *)service;

@property (nonatomic, weak) id delegate;

- (void)presentInParentViewController:(UIViewController *)parentViewController;

- (void)dismissFromParentViewController ;

@end

@protocol  PopupCteateServiceViewControllerDelegate <NSObject>

-(void)touchButtonFinish:(Service *)service edit:(BOOL)isEdit;

@end
