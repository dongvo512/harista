//
//  CommentViewController.h
//  hairista
//
//  Created by Dong Vo on 2/7/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Salon;

@interface CommentViewController : UIViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salon:(Salon *)salon;
@property (nonatomic, weak) id delegate;
@end
@protocol CommentViewControllerDelegate <NSObject>

-(void)finishCommented;

@end
