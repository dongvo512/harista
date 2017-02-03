//
//  NCComboboxNewView.m
//  eSAMS
//
//  Created by steven on 7/27/16.
//  Copyright © 2016 NhatCuongMobile. All rights reserved.
//

#import "NCComboboxNewView.h"
#import "Common.h"
#import "UIColor+Method.h"
#import "CommonDefine.h"

@interface NCComboboxNewView (){
    
    UISwipeGestureRecognizer *swipeLeft;
    UISwipeGestureRecognizer *swipeRight;
    NSString *strplace;
    
}

@property (weak, nonatomic) IBOutlet UIButton *btnClearText;

@property (weak, nonatomic) IBOutlet UIImageView *imgViewIcon;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthIconRightContraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthIconClearText;



@end

@implementation NCComboboxNewView{
    
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if(self){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        [self setup];
    }
    return self;
    
}

#pragma mark - Method

- (void)sethiddenBttnSelect{
    
    [self.btnSelected setHidden:YES];
    [self.btnClearText setHidden:YES];
    [self.imgViewIcon setHidden:YES];
}

- (void)showBtnSelected{
    
    [self.btnSelected setHidden:NO];
    [self.imgViewIcon setHidden:NO];
}

- (void)setBorderValidate{
    
    self.view.layer.cornerRadius = 5.0;
    self.view.layer.borderWidth = 0.7;
    self.view.layer.borderColor = [UIColor redColor].CGColor;
    self.view.clipsToBounds = YES;
}

- (void)setBorderDefault{
    
    self.view.layer.cornerRadius = 5.0;
    self.view.layer.borderWidth = 0.7;
    self.view.layer.borderColor = [UIColor grayBorder].CGColor;
    self.view.clipsToBounds = YES;
    
}

- (void)setup{
    
    self.view  = [[NSBundle mainBundle] loadNibNamed:@"NCComboboxNewView" owner:self options:nil].firstObject;
    
    self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view.clipsToBounds = YES;
    swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeLeft)];
    [swipeLeft setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    
    //self.trailingImaIcon.constant=0;
    
    [self.scrlbName.lblText setFont:[UIFont fontWithName:FONT_ROBOTO_LIGHT size:16.0f]];
    
    [self.btnDelete setHidden:YES];
    
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
}

- (void)setIcon{
    
}

- (void)setDisableSwipe{
    
    swipeLeft.enabled = NO;
    swipeRight.enabled = NO;
}

- (void)setEnableSwipe{
    
    swipeLeft.enabled = YES;
    swipeRight.enabled = YES;
}

-(void)handleSwipeLeft{
    
    [self.imgViewIcon setHidden:NO];
    [self.btnClearText setHidden:YES];
}

-(void)returnDefaultSwipe{
    
    [self.imgViewIcon setHidden:NO];
    [self.btnClearText setHidden:YES];
}

- (void)setImageIcon:(NSString *)strNameIcon{
    
    self.imgViewIcon.image = [UIImage imageNamed:strNameIcon];
}

- (void)setTextName:(NSString *)strName andFont:(UIFont*)font{
    
    
    [self.scrlbName setText:strName andFont:font];
}
-(void)setTextName:(NSString *)strName{
    
    [self.scrlbName.lblText setText:strName];
    
    if (strName.length > 0) {
        
        [self.btnDelete setHidden:NO];
        [self.btnSelected setHidden:YES];
    }
    else{
        
        [self.btnDelete setHidden:YES];
        [self.btnSelected setHidden:NO];
    }
}

- (NSString *)getText{

    return self.scrlbName.lblText.text;
}

- (void)setbackGroundView:(UIColor *)color{
    [self.view setBackgroundColor:color];
}

- (void)setTextColor:(UIColor *)textColor{
    [self.scrlbName setTextColorForText:textColor];
}

- (void)setPlaceHolder:(NSString *)strPlaceHolder{
   
    strplace = strPlaceHolder;
    
    [self.btnSelected setHidden:NO];
    [self.btnDelete setHidden:YES];
    [self.scrlbName.lblText setText:strplace];
    [self.scrlbName.lblText setTextColor:[UIColor grayTextCombobox]];
    
}

-(void)updateHeightFrameAfterAutolayout:(float)height{
    
    self.widthIconRightContraint.constant = height;
    self.widthIconClearText.constant = height;
}

- (void)setFontForTextField:(UIFont *)font{
    
    [self.scrlbName setFontForText:font];
}

#pragma IBAction

-(void)setEnable:(BOOL)isEnable{
    
    self.view.userInteractionEnabled = isEnable;
}

- (IBAction)clearText:(id)sender {
    
    [self.scrlbName.lblText setText:_CM_STRING_EMPTY];
    
    [self.btnDelete setHidden:YES];
    [self.btnSelected setHidden:NO];
    
    [self setPlaceHolder:strplace];
    
    if([[self delegate] respondsToSelector:@selector(clearCombobox:)]){
        [[self delegate] clearCombobox:self];
    }
    
}

- (IBAction)clickButton:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(didSelect:inView:andType:andCombobox:)]){
        
        [[self delegate] didSelect:self.frame inView:self.superview
                           andType:self.typeMasterDataCombobox
                       andCombobox:self];
        
    }
}

@end
