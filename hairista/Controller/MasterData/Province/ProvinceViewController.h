//
//  ProvinceViewController.h
//  hairista
//
//  Created by Dong Vo on 2/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Province;

@interface ProvinceViewController : UIViewController

@property (nonatomic, weak) id delegate;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil provinceSelected:(Province *)aProvinceSelected;

@end
@protocol ProvinceViewControllerDelegte <NSObject>

-(void)selectedProvince:(Province *)province controller:(ProvinceViewController *)controller;

@end
