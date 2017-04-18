//
//  ServicesViewController.h
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServicesViewController : UIViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil isSelectItem:(BOOL)isSelectItem arrSelected:(NSArray *)aArrSelected;

@property (nonatomic, weak) id delegate;
@end
@protocol ServicesViewControllerDelegate <NSObject>

-(void)selectedItems:(NSMutableArray *)arrItems controller:(ServicesViewController *)controller;

@end
