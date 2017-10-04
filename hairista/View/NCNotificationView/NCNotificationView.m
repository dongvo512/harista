//
//  NCNotificationView.m
//  hairista
//
//  Created by Dong Vo on 10/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "NCNotificationView.h"
#import "Notification.h"

@interface NCNotificationView (){
    
    Notification *notification;
    
    BOOL isShowMess;
}
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblBookdate;

@end
@implementation NCNotificationView

- (id)initWithFrame:(CGRect)frame notification:(Notification *)aNotification{
    
    if(self = [super initWithFrame:frame]){
        
        notification = aNotification;
        
        [self setup];
    }
    
    return self;
}
#pragma mark - Method
-(void)closeMessage{
    
    if(isShowMess){
        
        isShowMess = NO;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.2];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = CGRectMake(0, - (CGRectGetMaxY(self.frame)), self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(closeMessage) object:nil];
    }
}
-(void)showMessage{
    
    if(!isShowMess){
        
        isShowMess = YES;
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        [UIView commitAnimations];
        
        [self performSelector:@selector(closeMessage) withObject:nil afterDelay:8.0f];
        
    }
}

-(void)setup{
    
    self.view  = [[NSBundle mainBundle] loadNibNamed:@"NCNotificationView" owner:self options:nil].firstObject;
    
    self.view.clipsToBounds = YES;
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
    //self.imgIcon.layer.cornerRadius = 3.0f;
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleFingerTap];
    
    self.lblTitle.text = notification.title;
    self.lblBookdate.text = notification.bookDate;
    
    [self showMessage];
    //The event handling method
    
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
    // CGPoint location = [recognizer locationInView:[recognizer.view superview]];
    
    [self closeMessage];
}
@end
