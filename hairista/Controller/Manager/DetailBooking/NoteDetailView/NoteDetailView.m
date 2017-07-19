//
//  NoteDetailView.m
//  hairista
//
//  Created by Dong Vo on 4/21/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "NoteDetailView.h"
#import "CommentStarCell.h"
#import "StarRate.h"
#import "SalonManage.h"
#import "Salon.h"
#import "Comment.h"
#import "BookingManage.h"
#import "Booking.h"

@interface NoteDetailView (){

    Booking *bookingCurr;
    
}

@property (weak, nonatomic) IBOutlet UITextView *txtView;

@property (nonatomic, strong) NSMutableArray *arrStars;
@end

@implementation NoteDetailView


-(id)initWithFrame:(CGRect)frame booking:(Booking *)booking{

    self = [super initWithFrame:frame];
    
    if(self){
   
        bookingCurr = booking;
        [self setup];
    }
    
    return self;
}

-(void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"NoteDetailView" owner:self options:nil].firstObject;
    self.clipsToBounds = YES;
    self.view.frame = self.bounds;
    self.alpha = 0;

    [self addSubview:self.view];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    self.alpha = 1;
    [UIView commitAnimations];
    
    [self.txtView.layer setBorderWidth:0.5];
    [self.txtView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    self.txtView.layer.cornerRadius = 3.0;
    
    if(bookingCurr.note.length > 0){
        
        self.txtView.text = bookingCurr.note;
    }
    
}

#pragma mark - Action

- (IBAction)touchBtnSend:(id)sender {
    
    if([self.txtView.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 10){
    
        [self updateNote:self.txtView.text];
    }
    else{
    
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Ghi chú phải ít nhất 10 ký tự" buttonClick:nil];
    }
    
}


-(void)updateNote:(NSString *)note{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[BookingManage sharedInstance] updateBookingNote:bookingCurr.idBooking.stringValue note:note dataResult:^(NSError *error, id idObject, NSString *strError) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
        
            bookingCurr.note = note;
            
            if([[self delegate] respondsToSelector:@selector(finishUpdateNote:)]){
            
                [[self delegate] finishUpdateNote:note];
            }
            
            [self.view endEditing:YES];
            
            [UIView animateWithDuration:0.5
                             animations:^{
                                 
                                 [self setAlpha:0];
                                 
                             }
                             completion:^(BOOL finished){
                                 
                                 [self removeFromSuperview];
                             }];
            [UIView commitAnimations];

        }
    }];
}

- (IBAction)touchBackground:(id)sender {
    
    [self.view endEditing:YES];
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         [self setAlpha:0];
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                     }];
    [UIView commitAnimations];
}


@end
