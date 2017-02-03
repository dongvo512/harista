//
//  NCScrollLabelView.m
//  SAMSS
//
//  Created by Macboook MD102 on 7/6/15.
//  Copyright (c) 2015 com.nc.sams. All rights reserved.
//

#import "NCScrollLabelView.h"
#import "CommonDefine.h"

@interface NCScrollLabelView (){
    UIEvent * anevent;
    CGPoint apoint;
    UITapGestureRecognizer * tap;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UIView *view;


@end
@implementation NCScrollLabelView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
}
-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

-(void)setup{
   /* UIView * view = [[NSBundle mainBundle] loadNibNamed:@"NCScrollLabelView" owner:self options:nil].firstObject;*/
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"NCScrollLabelView" owner:self options:nil].firstObject;
    self.clipsToBounds = YES;
    [self setBackgroundColor:[UIColor clearColor]];
    [self.view setBackgroundColor:[UIColor clearColor]];
    
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
    tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchHandle)];
    [self addGestureRecognizer:tap];
}
-(void)setAlignCenter{

    [self.lblText setTextAlignment:NSTextAlignmentCenter];
}

-(void)setText:(NSString *)strText andFont:(UIFont *)font{
    
    [self.lblText setFont:font];
    
    strText = (strText == nil || [strText isEqualToString:@"null"])?_CM_STRING_EMPTY:strText;
    
    self.lblText.text = strText;
}
- (void)touchHandle{

    //  NSLog(@"%f",self.scrollView.frame.size.height);
  //  NSLog(@"%f",self.lblText.frame.size.height);
  //  NSLog(@"%f",self.frame.size.height);
  
    if ([self.delegate isKindOfClass:[UITableViewCell class]]) {
        id view = [self superview];
        
        while (view && [view isKindOfClass:[UITableView class]] == NO) {
            view = [view superview];
        }
        
        if ([view isKindOfClass:[UITableView class]]) {
            if ([[(UITableView *)view delegate] respondsToSelector:@selector(tableView:willSelectRowAtIndexPath:)]) {
                [[(UITableView *)view delegate] tableView:view willSelectRowAtIndexPath:[view indexPathForCell:self.delegate]];

            }
            if ([[(UITableView *)view delegate] respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
                [[(UITableView *)view delegate] tableView:view didSelectRowAtIndexPath:[view indexPathForCell:self.delegate]];

            }
       
            NSIndexPath *indexPathCurr = [view indexPathForCell:self.delegate];
            
            [view selectRowAtIndexPath:indexPathCurr animated:NO scrollPosition:UITableViewScrollPositionNone];

        }
        
    }
    if ([self.delegate isKindOfClass:[UIButton class]]) {
        [self.delegate sendActionsForControlEvents:UIControlEventTouchUpInside];
    }

}
- (void)scrollViewDidScroll:(UIScrollView *)aScrollView
{
    [self.scrollView setContentOffset: CGPointMake(self.scrollView.contentOffset.x,0)];
    
}
- (void)setTextColorForText:(UIColor *)color{
    [self.lblText setTextColor:color];
}
-(void)setFontForText:(UIFont *)font{

    [self.lblText setFont:font];
}


@end
