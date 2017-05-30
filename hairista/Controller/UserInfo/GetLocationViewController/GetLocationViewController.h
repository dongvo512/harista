//
//  GetLocationViewController.h
//  hairista
//
//  Created by Dong Vo on 5/25/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GetLocationViewController : UIViewController

@property (nonatomic, weak) id delegate;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil aLat:(NSString *)laitude aLong:(NSString *)longitude;
@end
@protocol GetLocationViewControllerDelegate <NSObject>

-(void)touchButtonCheck:(CGFloat)laitude longitude:(CGFloat)longitude;

@end
