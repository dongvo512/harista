//
//  NCSearchBarView.m
//  eSAMS
//
//  Created by Dong Vo on 6/24/16.
//  Copyright © 2016 NhatCuongMobile. All rights reserved.
//

#import "NCSearchBarView.h"
#import "NCTextFieldView.h"
#import "CommonDefine.h"


@interface NCSearchBarView()
{
    BOOL isHaveSearchText;

}
@property (strong, nonatomic) IBOutlet UIView *view;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintBtnSearchAdvance;

@end

@implementation NCSearchBarView

static NCSearchBarView *sharedInstance = nil;
+ (id)sharedInstance :(CGRect)frame{
    
    
    @synchronized(self) {
        if (sharedInstance == nil) {
          
            sharedInstance = [[self alloc] initWithFrame:CGRectMake(frame.origin.x,0, frame.size.width, 72)];
             [sharedInstance setup];
        }
        
        return sharedInstance;
    }
    
}

#pragma mark - Method

-(void)setup{

    sharedInstance.view  = [[NSBundle mainBundle] loadNibNamed:@"NCSearchBarView" owner:self options:nil].firstObject;
    
    sharedInstance.view.frame = sharedInstance.bounds;
    [self addSubview:sharedInstance.view];
    
    [self.tfSearch setBackgroundColor:[UIColor clearColor]];
    self.tfSearch.txtTextField.placeholder = @"Tìm kiếm...";
    [self.tfSearch.txtTextField setTextColor:[UIColor whiteColor]];
    self.tfSearch.txtTextField.clearButtonMode = UITextFieldViewModeNever;
    [self.tfSearch.txtTextField setReturnKeyType:UIReturnKeyDone];
    [self.tfSearch setColorForPlaceHolder:[UIColor whiteColor]];
    self.tfSearch.txtTextField.font = [UIFont fontWithName:FONT_ROBOTO_REGULAR size:16.0f];
    self.tfSearch.strACCEPT_CHARACTER = _CM_ACCEPTABLE_CHARECTERS6;
    self.tfSearch.MAX_LENGHT = 100;
    self.tfSearch.view.layer.borderColor = [UIColor clearColor].CGColor;
    self.tfSearch.txtTextField.clearButtonMode = UITextFieldViewModeNever;
    self.tfSearch.delegate = self;
    
}

-(void)showSearchBar{

    [self setHidden:NO];
    
    [self.tfSearch.txtTextField becomeFirstResponder];
    
}
- (IBAction)clearSearchText:(id)sender {
    
    self.tfSearch.txtTextField.text = _CM_STRING_EMPTY;
    [self.btnClearText setHidden:YES];
    [self.tfSearch.txtTextField resignFirstResponder];
    
    if([[self delegate] respondsToSelector:@selector(selectedBtnClearText)]){
        
        [[self delegate] selectedBtnClearText];
    }
}

- (void)clearSearchTextField {
     self.tfSearch.txtTextField.text = _CM_STRING_EMPTY;
}

-(void)close{

    [self.tfSearch.txtTextField resignFirstResponder];
   
    [self setHidden:YES];
    self.tfSearch.txtTextField.text = _CM_STRING_EMPTY;
    
}
- (IBAction)closeSearchBar:(id)sender {
   
    [self performSelector:@selector(close) withObject:nil afterDelay:0.0f];
    
    if([[self delegate] respondsToSelector:@selector(selectedBtnClose)]){
    
        [[self delegate] selectedBtnClose];
    }
    
}
#pragma mark - NCTextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textFieldControl andTextFieldName:(NSString *) strTextFieldName{
    
    if([[self delegate] respondsToSelector:@selector(searchBarDidBeginEditing:andTextFieldName:)]){
    
        [[self delegate] searchBarDidBeginEditing:textFieldControl andTextFieldName:strTextFieldName];
    }
}

- (void)textFieldShouldReturn:(UITextField *)textFieldControl
             andTextFieldName:(NSString *) strTextFieldName{
    
    if([[self delegate] respondsToSelector:@selector(searchBarShouldReturn:andTextFieldName:)]){
        
        [[self delegate] searchBarShouldReturn:textFieldControl andTextFieldName:strTextFieldName];
    }
    
}

- (void)textFieldTextChange:(UITextField *)textField
           andTextFieldName:(NSString *)strTextFieldName{
    
    if (textField.text.length == 0) {
        
        isHaveSearchText = NO;
        
        [self.btnClearText setHidden:YES];
    }
    else{
    
        isHaveSearchText = YES;
        
        [self.btnClearText setHidden:NO];
    }
    
    if([[self delegate] respondsToSelector:@selector(searchBarTextChange:andTextFieldName:)]){
        
        [[self delegate] searchBarTextChange:textField andTextFieldName:strTextFieldName];
    }
}
@end
