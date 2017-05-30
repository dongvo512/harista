//
//  ListManageServiceViewController.h
//  hairista
//
//  Created by Dong Vo on 5/11/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Category;

@interface ListManageServiceViewController : UIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil cat:(Category *)aCate;
@property (nonatomic, weak) id delegate;

@property (nonatomic, strong) NSString *titleCategories;

@end
@protocol ListManageServiceViewControllerDelegate  <NSObject>

-(void)finishCreateService;

@end
