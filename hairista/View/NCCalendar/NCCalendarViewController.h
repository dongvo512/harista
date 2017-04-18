//
//  NCCalendarViewController.h
//  Demo_NCCalendar
//
//  Created by Macboook MD102 on 5/28/15.
//  Copyright (c) 2015 com.DongVo.Swift. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCCalendarViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *viewCalendar;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;

@property (weak, nonatomic) IBOutlet UIButton *btnToday;

@property (strong, nonatomic) UIPopoverController *popoverPresentCurr;
@property (nonatomic, strong) NSString *strCalendarName;
@property (weak, nonatomic) IBOutlet UIPickerView *pickerViewTimer;
-(id)initWithDate:(NSDate *)dateCurr andType:(NSInteger)type;
@property (weak, nonatomic) IBOutlet UIView *viewBackground;
@property (strong) id delegate;
@property BOOL shouldDimBackground;             //Default: YES
@property BOOL shouldAnimateOnAppear;           //Default: YES
@property BOOL shouldAnimateOnDisappear;         //Default: YES
@property BOOL allowSwipeToDismiss;               //Default: YES
- (void)presentInParentViewController:(UIViewController *)parentViewController;
- (void)dismissFromParentViewController;
@end
@protocol NCCalendarViewControllerDelegate
@optional
-(void)selectedCalendar:(NSDate *)date andCalendarName:(NSString *)strCalendarName andType:(NSInteger)type;

-(void)selectedCalendar:(NSDate *)date andCalendar:(NCCalendarViewController *)canlendarCurr andType:(NSInteger)type;
@end
