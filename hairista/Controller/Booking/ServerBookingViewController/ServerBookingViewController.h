//
//  ServerBookingViewController.h
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ServerBookingViewController : UIViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrSelected:(NSArray *)aArrSelected salonID:(NSString *)aSalonID;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil arrSelected:(NSArray *)aArrSelected salonID:(NSString *)aSalonID arrNoneSelect:(NSArray *)aArrNoneSelect;

@property (nonatomic, weak) id delegate;
@end
@protocol ServerBookingViewControllerDelegate <NSObject>

-(void)selectedItems:(NSMutableArray *)arrItems controller:(ServerBookingViewController *)controller;

@end
