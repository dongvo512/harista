//
//  NCCalendarViewController.m
//  Demo_NCCalendar
//
//  Created by Macboook MD102 on 5/28/15.
//  Copyright (c) 2015 com.DongVo.Swift. All rights reserved.
//

#import "NCCalendarViewController.h"
#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "AJRBackgroundDimmer.h"
#import "CommonDefine.h"
#import "Common.h"

typedef enum : NSInteger {
    Day = 0,
    Month = 1,
    Year = 2,
    Hour = 3,
    Minute = 4
} NCCAlendayType;

typedef enum : NSInteger {
    SingegleCalendar = 0,
    ComboCalendar = 1
} CalendarType;


@interface NCCalendarViewController ()<UIPickerViewDataSource,UIPickerViewDelegate
>
{
   
    
    NSMutableArray *arrDays;
    NSMutableArray *arrMonths;
    NSMutableArray *arrYears;
    NSMutableArray *arrHours;
    NSMutableArray *arrMinutes;
    
    NSMutableArray *arrDataPicker;
    
    NSCalendar* calendar;
    NSDateComponents *componentsDate;
    
    NSDate *dateSelected;
    NSInteger dayCurr;
    NSInteger monthCurr;
    NSInteger yearCurr;
    NSInteger hourCurr;
    NSInteger minuteCurr;
    NSInteger rangeDayWithMonth;
    NSInteger typeCurr;
    
    AJRBackgroundDimmer *backgroundGradientView;
    BOOL isSelectedDay;
    BOOL isSelectedMonth;
    BOOL isSelectedYear;
  
}
@end

@implementation NCCalendarViewController

-(id)initWithDate:(NSDate *)dateCurr andType:(NSInteger)type{
    
    typeCurr = type;
    NSString *nibNameOrNil = nil;
    
   
    switch (type) {
        case ComboCalendar:
        {
            if (IDIOM == IPAD){
                nibNameOrNil = @"NCCalendarViewController";
            }
            else{
                nibNameOrNil = @"NCCalendarViewController_iPhone";
            }
        }
            break;
        case SingegleCalendar:
        {
            if (IDIOM == IPAD){
                nibNameOrNil = @"NCCalendarSingleViewController";
            }
            else{
                nibNameOrNil = @"NCCalendarSingleViewController_iPhone";
            }
        }
            break;
        default:
            break;
    }
    
   /* if(type == ComboCalendar){
        
        if (IDIOM == IPAD){
            nibNameOrNil = @"NCCalendarViewController";
        }
        else{
            nibNameOrNil = @"NCCalendarViewController_iPhone";
        }
        
    }
    else{
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad){
            nibNameOrNil = @"NCCalendarSingleViewController";
        }
        else{
            nibNameOrNil = @"NCCalendarSingleViewController_iPhone";
        }
        
    }*/

    self = [super initWithNibName:nibNameOrNil bundle:nil];
    if(self){
        // create Days
        self.shouldDimBackground = YES;
        self.shouldAnimateOnAppear = YES;
        self.shouldAnimateOnDisappear = YES;
        self.allowSwipeToDismiss = YES;
        
        dateSelected = (dateCurr != nil)?dateCurr:[NSDate date];
        
        arrDataPicker = [NSMutableArray array];
        
        [self setValueFromDate:dateSelected];
       
        
        if(type == SingegleCalendar){
            // create Days
            [self createDays];
            
            // create Months
            [self createMonths];
            
            // create Years
            [self createYears];
        }
        else if (type == ComboCalendar){
            // create Days
            [self createDays];
            
            // create Months
            [self createMonths];
            
            // create Years
            [self createYears];
            // create Hour
            [self createHours];
            
            // create Minute
            [self createMinutes];
        }
        
        CGSize sizeContent = self.view.frame.size;
        self.preferredContentSize = sizeContent;
    }
    return self;
}
-(void)createDays{
    arrDays = [NSMutableArray array];
    
    [arrDays addObject:@"01"];
    [arrDays addObject:@"02"];
    [arrDays addObject:@"03"];
    [arrDays addObject:@"04"];
    [arrDays addObject:@"05"];
    [arrDays addObject:@"06"];
    [arrDays addObject:@"07"];
    [arrDays addObject:@"08"];
    [arrDays addObject:@"09"];
    
    for(int i= 10; i<= rangeDayWithMonth; i++){
        [arrDays addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [arrDataPicker addObject:arrDays];
}

-(void)createMonths{
    arrMonths = [NSMutableArray array];
    
    [arrMonths addObject:@"01"];
    [arrMonths addObject:@"02"];
    [arrMonths addObject:@"03"];
    [arrMonths addObject:@"04"];
    [arrMonths addObject:@"05"];
    [arrMonths addObject:@"06"];
    [arrMonths addObject:@"07"];
    [arrMonths addObject:@"08"];
    [arrMonths addObject:@"09"];
    [arrMonths addObject:@"10"];
    [arrMonths addObject:@"11"];
    [arrMonths addObject:@"12"];
    
    [arrDataPicker addObject:arrMonths];
}
-(void)createYears{
   
    arrYears = [NSMutableArray array];
    
    for(int i = 1900; i <= [Common getStringDisplayFormDate:[NSDate date] andFormatString:@"yyyy"].integerValue +15; i++){
        [arrYears addObject:[NSString stringWithFormat:@"%d",i]];
    }
     [arrDataPicker addObject:arrYears];

}
-(void)createHours{
    arrHours = [NSMutableArray array];
    [arrHours addObject:@"00"];
    [arrHours addObject:@"01"];
    [arrHours addObject:@"02"];
    [arrHours addObject:@"03"];
    [arrHours addObject:@"04"];
    [arrHours addObject:@"05"];
    [arrHours addObject:@"06"];
    [arrHours addObject:@"07"];
    [arrHours addObject:@"08"];
    [arrHours addObject:@"09"];
    
    for(int i = 10; i<= 23; i++){
        [arrHours addObject:[NSString stringWithFormat:@"%d",i]];
    }
    [arrDataPicker addObject:arrHours];
}
-(void)createMinutes{

    arrMinutes = [NSMutableArray array];
    [arrMinutes addObject:@"00"];
    [arrMinutes addObject:@"01"];
    [arrMinutes addObject:@"02"];
    [arrMinutes addObject:@"03"];
    [arrMinutes addObject:@"04"];
    [arrMinutes addObject:@"05"];
    [arrMinutes addObject:@"06"];
    [arrMinutes addObject:@"07"];
    [arrMinutes addObject:@"08"];
    [arrMinutes addObject:@"09"];

    for(int i = 10; i<= 59; i++){
        [arrMinutes addObject:[NSString stringWithFormat:@"%d",i]];
    }
     [arrDataPicker addObject:arrMinutes];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dateSelected == nil ? [NSDate date] : dateSelected;
    
    self.btnToday.layer.cornerRadius = 3.0f;
    
    self.viewCalendar.layer.cornerRadius = 7.0;
    
    self.btnSave.layer.cornerRadius = 5.0;
    self.btnSave.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.btnSave.layer.borderWidth = 1.0;
    
    
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
       
        self.viewBackground.layer.cornerRadius = 7.0f;
    }
   

}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    if(typeCurr == SingegleCalendar){
       
        [self.pickerViewTimer selectRow:(dayCurr -1) inComponent:Day animated:YES];
        [self.pickerViewTimer selectRow:(monthCurr - 1) inComponent:Month animated:YES];
        [self.pickerViewTimer selectRow:(yearCurr - 1900) inComponent:Year animated:YES];
    }else{
        
        [self.pickerViewTimer selectRow:(dayCurr -1) inComponent:Day animated:YES];
        [self.pickerViewTimer selectRow:(monthCurr - 1) inComponent:Month animated:YES];
        [self.pickerViewTimer selectRow:(yearCurr - 1900) inComponent:Year animated:YES];
        [self.pickerViewTimer selectRow:hourCurr inComponent:Hour animated:YES];
        [self.pickerViewTimer selectRow:minuteCurr inComponent:Minute animated:YES];
    }
    
    double delayInSeconds = 0.7;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
      
        [self changeFontAndColorForSelectedViewDate:(yearCurr - 1900) AndComponent:Year];
        [self changeFontAndColorForSelectedViewDate:(dayCurr -1) AndComponent:Day];
        [self changeFontAndColorForSelectedViewDate:(monthCurr - 1) AndComponent:Month];
        
    });
    
    
}
#pragma mark - Method

- (IBAction)selectedButtonToday:(id)sender {
    
    [self setValueFromDate:[NSDate date]];
    [self viewDidAppear:YES];
   
}

-(void)changeFontAndColorForSelectedViewDate:(NSInteger)row AndComponent:(NSInteger)component{
    // set FontSize and Corlor For UIlabel Selected
    
    UILabel *lblSelected = (UILabel *)[self.pickerViewTimer viewForRow:row forComponent:component];
    lblSelected.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:21.0f];
  //  lblSelected.textColor = [UIColor colorWithRed:82.0f/255.0f green:136.0f/255.0f blue:85.0f/255.0f alpha:1.0];
    lblSelected.textColor = [UIColor blackColor];
    
}

- (void) setValueFromDate:(NSDate *)date{
    
    if(date == nil)
        date = [NSDate date];
    
    calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    componentsDate = [calendar components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:date];
    rangeDayWithMonth = [self updateRangeDayWithMonthAndYear:date];
    dayCurr = [componentsDate day];
    monthCurr = [componentsDate month];
    yearCurr = [componentsDate year];
    hourCurr = [componentsDate hour];
    minuteCurr = [componentsDate minute];
    
}
-(NSInteger)updateRangeDayWithMonthAndYear:(NSDate*)dateCurr{
    
    NSInteger range;
    NSRange daysRange =
    [calendar
     rangeOfUnit:NSDayCalendarUnit
     inUnit:NSMonthCalendarUnit
     forDate:dateCurr];
    range = daysRange.length;
    return range;
}
-(void)checkDayCurrent{
    
    if(dayCurr > arrDays.count){
        
        dayCurr = arrDays.count;
    }
}
-(NSDate*)updateDate:(NSInteger)day andMonth:(NSInteger)month andYear:(NSInteger)year andHour:(NSInteger)hour andMinute:(NSInteger)minute{
    NSDate *dateUpdated;
    
    [componentsDate setDay:day];
    [componentsDate setMonth:month];
    [componentsDate setYear:year];
    [componentsDate setHour:hour];
    [componentsDate setMinute:minute];
    
    dateUpdated = [calendar dateFromComponents:componentsDate];
    
    return dateUpdated;
}

- (IBAction)saveDate:(id)sender {
   
   
    NSCalendar *gregorian = [NSCalendar currentCalendar];
  //  NSDateComponents *components = [[NSDateComponents alloc] init];
    NSDateComponents *components = [gregorian components:NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit fromDate:dateSelected];
    // Then use it
    if(typeCurr == SingegleCalendar){
        
        [components setDay: dayCurr];
        [components setMonth: monthCurr];
        [components setYear: yearCurr];
      
    }
    else{
        [components setDay: dayCurr];
        [components setMonth: monthCurr];
        [components setYear: yearCurr];
        [components setHour: hourCurr];
        [components setMinute: minuteCurr];
       
    }
    
    
    NSDate *newDate = [gregorian dateFromComponents: components];

    
    if([[self delegate] respondsToSelector:@selector(selectedCalendar:andCalendarName:andType:)]){
        [[self delegate] selectedCalendar:newDate andCalendarName:self.strCalendarName andType:typeCurr];
    }
    
    if([[self delegate] respondsToSelector:@selector(selectedCalendar:andCalendar:andType:)]){
        [[self delegate] selectedCalendar:newDate andCalendar:self andType:typeCurr];
    }
    
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone){
        [self dismissFromParentViewController];
    }else{
        [self.popoverPresentCurr dismissPopoverAnimated:YES];
    }
    
}
- (void) presentInParentViewController:(UIViewController *)parentViewController {
    
    if (self.shouldDimBackground == YES) {
        
        //Dims the background, unless overridden
        backgroundGradientView = [[AJRBackgroundDimmer alloc] initWithFrame:parentViewController.view.bounds];
        [parentViewController.view addSubview:backgroundGradientView];
        self.view.frame = parentViewController.view.bounds;
        [parentViewController.view addSubview:self.view];
    }
    
    //Adds the nutrition view to the parent view, as a child
    
    
    
    [parentViewController addChildViewController:self];
    
    //Adds the bounce animation on appear unless overridden
    if (!self.shouldAnimateOnAppear)
        return;
    
    CAKeyframeAnimation *bounceAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
    bounceAnimation.duration = 0.4;
    bounceAnimation.delegate = self;
    
    bounceAnimation.values = [NSArray arrayWithObjects:
                              [NSNumber numberWithFloat:0.7f],
                              [NSNumber numberWithFloat:1.2f],
                              [NSNumber numberWithFloat:0.9f],
                              [NSNumber numberWithFloat:1.0f],
                              nil];
    
    bounceAnimation.keyTimes = [NSArray arrayWithObjects:
                                [NSNumber numberWithFloat:0.0f],
                                [NSNumber numberWithFloat:0.334f],
                                [NSNumber numberWithFloat:0.666f],
                                [NSNumber numberWithFloat:1.0f],
                                nil];
    
    bounceAnimation.timingFunctions = [NSArray arrayWithObjects:
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                       nil];
    
    [self.view.layer addAnimation:bounceAnimation forKey:@"bounceAnimation"];
    
    CABasicAnimation *fadeAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    fadeAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    fadeAnimation.duration = 0.1;
    [backgroundGradientView.layer addAnimation:fadeAnimation forKey:@"fadeAnimation"];
    
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
 
    CGPoint location = [recognizer locationInView:self.view];
    if(!CGRectContainsPoint(self.viewCalendar.frame, location)){
        [self dismissFromParentViewController];
    }
    //Do stuff here...
}
- (void) dismissFromParentViewController {
    
    //Removes the nutrition view from the superview
    [self willMoveToParentViewController:nil];
    
    //Removes the view with or without animation
    if (!self.shouldAnimateOnDisappear) {
        [self.view removeFromSuperview];
        [backgroundGradientView removeFromSuperview];
        [self removeFromParentViewController];
        return;
    }
    else {
        [UIView animateWithDuration:0.4 animations:^ {
            CGRect rect = self.view.bounds;
            rect.origin.y += rect.size.height;
            self.view.frame = rect;
            backgroundGradientView.alpha = 0.0f;
        }
                         completion:^(BOOL finished) {
                             [self.view removeFromSuperview];
                             [backgroundGradientView removeFromSuperview];
                             [self removeFromParentViewController];
                         }];
    }
}

#pragma mark - PickerViewDataSource
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return  [self realNumberOfRowsInComponent:component];
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return arrDataPicker.count;
}

- (NSInteger)realNumberOfRowsInComponent:(NSInteger)component {
    NSInteger numberOfRows = 0;
    
    switch (component) {
        case Day:
            numberOfRows = arrDays.count;
            break;
        case Month:
            numberOfRows = arrMonths.count;
            break;
        case Year:
            numberOfRows = arrYears.count;
            break;
        case Hour:
            numberOfRows = arrHours.count;
            break;
        case Minute:
            numberOfRows = arrMinutes.count;
            break;
        default:
            break;
    }
    
    return numberOfRows;
}
#pragma mark - PickerViewDelegate
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *titleRow;
  
    switch (component) {
        case Day:
            titleRow = [arrDays objectAtIndex:row];
            break;
        case Month:
            titleRow = [arrMonths objectAtIndex:row];
            break;
        case Year:
            titleRow = [arrYears objectAtIndex:row];
            break;
        case Hour:
            titleRow = [arrHours objectAtIndex:row];
            break;
        case Minute:
            titleRow = [arrMinutes objectAtIndex:row];
            break;
        default:
            break;
    }
    
    return titleRow;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
  
    UILabel* tView = (UILabel*)view;
    if (!tView)
    {
        tView = [[UILabel alloc] init];
        
        [tView setFrame:CGRectMake(tView.frame.origin.x, tView.frame.origin.y, self.view.frame.size.width/5, tView.frame.size.height)];
        tView.textColor = [UIColor blackColor];
        tView.textAlignment = NSTextAlignmentCenter;
        tView.backgroundColor = [UIColor clearColor];
        tView.font = [UIFont boldSystemFontOfSize:17.0f];
       
        
    }
    
    switch (component) {
        case Day:
            if([[arrDays objectAtIndex:row] integerValue] == dayCurr && isSelectedDay){
                [self changeFontAndColorForSelectedViewDate:row AndComponent:component];
            }
            tView.text = [arrDays objectAtIndex:row];
            break;
        case Month:
            if([[arrMonths objectAtIndex:row] integerValue] == monthCurr && isSelectedMonth){
                [self changeFontAndColorForSelectedViewDate:row AndComponent:component];
            }
            tView.text = [arrMonths objectAtIndex:row];
            break;
        case Year:
           /* if([[arrYears objectAtIndex:row] integerValue] == yearCurr && isSelectedYear){
                [self changeFontAndColorForSelectedViewDate:row AndComponent:component];
            }*/
            tView.text = [arrYears objectAtIndex:row];
            break;
        case Hour:
            tView.text = [arrHours objectAtIndex:row];
            break;
        case Minute:
            tView.text = [arrMinutes objectAtIndex:row];
            break;
        default:
            break;
    }
    
       return tView;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    switch (component) {
        case Day:
            isSelectedDay = TRUE;
            dayCurr = [[arrDays objectAtIndex:row] integerValue];
             dateSelected = [self updateDate:dayCurr andMonth:monthCurr andYear:yearCurr andHour:hourCurr andMinute:minuteCurr];
           
            break;
        case Month:
            isSelectedMonth = TRUE;
            monthCurr = [[arrMonths objectAtIndex:row] integerValue];
             dateSelected = [self updateDate:1 andMonth:monthCurr andYear:yearCurr andHour:hourCurr andMinute:minuteCurr];
            rangeDayWithMonth = [self updateRangeDayWithMonthAndYear:dateSelected];
            [self createDays];
            [self checkDayCurrent];
            dateSelected = [self updateDate:dayCurr andMonth:monthCurr andYear:yearCurr andHour:hourCurr andMinute:minuteCurr];
            [pickerView reloadComponent:Day];
          
            break;
        case Year:
           // isSelectedYear = TRUE;
            yearCurr = [[arrYears objectAtIndex:row] integerValue];
            dateSelected = [self updateDate:1 andMonth:monthCurr andYear:yearCurr andHour:hourCurr andMinute:minuteCurr];
            rangeDayWithMonth = [self updateRangeDayWithMonthAndYear:dateSelected];
            [self createDays];
            [self checkDayCurrent];
            dateSelected = [self updateDate:dayCurr andMonth:monthCurr andYear:yearCurr andHour:hourCurr andMinute:minuteCurr];
            [pickerView reloadComponent:Day];
            [pickerView reloadComponent:Month];
           
            break;
        case Hour:
            hourCurr = [[arrHours objectAtIndex:row] integerValue];
             dateSelected = [self updateDate:dayCurr andMonth:monthCurr andYear:yearCurr andHour:hourCurr andMinute:minuteCurr];
          
            break;
        case Minute:
            minuteCurr = [[arrMinutes objectAtIndex:row] integerValue];
             dateSelected = [self updateDate:dayCurr andMonth:monthCurr andYear:yearCurr andHour:hourCurr andMinute:minuteCurr];
          
            break;
        default:
            break;
    }
    
        [self changeFontAndColorForSelectedViewDate:(yearCurr - 1900) AndComponent:Year];
        [self changeFontAndColorForSelectedViewDate:(dayCurr -1) AndComponent:Day];
        [self changeFontAndColorForSelectedViewDate:(monthCurr - 1) AndComponent:Month];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
