//
//  NCTextFieldView.m
//  SAMSS
//
//  Created by Macboook MD102 on 7/6/15.
//  Copyright (c) 2015 com.nc.sams. All rights reserved.
//

#import "NCTextFieldView.h"
#import "CommonDefine.h"
#import "Common.h"

@interface NCTextFieldView()<UITextFieldDelegate>
{
    BOOL isDeleteLinkCharacter;
    NSString *strInputLicensePlateID;
}

@end
@implementation NCTextFieldView

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
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
    self.view.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.view.clipsToBounds = YES;
}
-(void)setColorForPlaceHolder:(UIColor *)color{

    [self.txtTextField setValue:color
                    forKeyPath:@"_placeholderLabel.textColor"];
}
- (void)setup{
    
    [self config];
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"NCTextFieldView" owner:self options:nil].firstObject;

    self.txtTextField.delegate = self;
    self.view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    self.view.layer.borderWidth = 0.7f;
    self.view.layer.cornerRadius = 5.0;
 
    self.txtTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.txtTextField.leftViewMode = UITextFieldViewModeAlways;
    self.txtTextField.clipsToBounds = YES;
    self.txtTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [self.txtTextField addTarget:self action:@selector(textFieldTextChange:) forControlEvents:UIControlEventEditingChanged];

    
    self.view.frame = self.bounds;
    [self addSubview:self.view];

}

- (void)config{
  
    self.isString = TRUE;
    self.isNumber = FALSE;
    self.isUpperFirstWord = FALSE;
    self.isCheckUnicode = FALSE;
    self.isLockPaste = FALSE;
    self.isLockCopy = FALSE;
    self.isLockMenuView = FALSE;
    self.isCheckLeastOneNuberAndOneWord = FALSE;
    self.isLoadDataAfterEdit = FALSE; //Use textFieldShouldEndEditing after check valid condition
    self.isUseEndEditing = FALSE; //Use textFieldShouldEndEditing after check valid condition
    self.isACCEPT_CHARACTER = FALSE;
    self.MAX_LENGHT = 50;
    self.strACCEPT_CHARACTER = _CM_ACCEPTABLE_CHARECTERS;
    self.strTextFieldName = _CM_STRING_EMPTY;
    self.view.backgroundColor = [UIColor clearColor];
}

- (void)setNeedDisplay{
    [self textFieldShouldEndEditing:self.txtTextField];
}

#pragma mark - TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSCharacterSet *nonNumberSet;
    NSCharacterSet *cs;
    NSString *filtered;

    
    if(self.isFormatLicensePlateMoto){
        //Dong Vo:
        if(self.isString){
            if (self.isACCEPT_CHARACTER == TRUE) {
                NSString *lastChar = nil;
                if(![textField.text isEqualToString:@""]){
                    lastChar = [textField.text substringWithRange:range];
                }
                // string = "" là xoá, ngược lại là nhâp.
                if(![string isEqualToString:@""]){
                    isDeleteLinkCharacter = FALSE;
                    if([string isEqualToString:@" "]){
                        return  NO;
                    }
                    
                    if (textField.text.length >= self.MAX_LENGHT && range.length == 0) return NO;
                    cs = [[NSCharacterSet characterSetWithCharactersInString:self.strACCEPT_CHARACTER] invertedSet];
                    
                    filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
                    BOOL isAceptString = [string isEqualToString:filtered];
                    return isAceptString;
                    
                }else{
                    if((range.location == 2 && [lastChar isEqualToString:@"-"])||(range.location == 5 && [lastChar isEqualToString:@"-"])){
                        isDeleteLinkCharacter = TRUE;
                        strInputLicensePlateID = [textField.text substringToIndex:textField.text.length -2];
                    }else{
                        isDeleteLinkCharacter = FALSE;
                    }
                    return YES;
                }
            }
        }
    }
    if(self.isFormatLicensePlateCar){
        //Dong Vo:
        if(self.isString){
            if (self.isACCEPT_CHARACTER == TRUE) {
                NSString *lastChar = nil;
                if(![textField.text isEqualToString:@""]){
                    lastChar = [textField.text substringWithRange:range];
                }
                // string = "" là xoá, ngược lại là nhâp.
                if(![string isEqualToString:@""]){
                    isDeleteLinkCharacter = FALSE;
                    if([string isEqualToString:@" "]){
                        return  NO;
                    }
                    
                    if (textField.text.length >= self.MAX_LENGHT && range.length == 0) return NO;
                    cs = [[NSCharacterSet characterSetWithCharactersInString:self.strACCEPT_CHARACTER] invertedSet];
                    
                    filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
                    BOOL isAceptString = [string isEqualToString:filtered];
                    return isAceptString;
                    
                }else{
                    if((range.location == 2 && [lastChar isEqualToString:@"-"])||(range.location == 4 && [lastChar isEqualToString:@"-"])){
                        isDeleteLinkCharacter = TRUE;
                        strInputLicensePlateID = [textField.text substringToIndex:textField.text.length -2];
                    }else{
                        isDeleteLinkCharacter = FALSE;
                    }
                    return YES;
                }
            }
        }
    }
    
    
    if (!textField.isEnabled) return NO;
    
    if (self.isNumber) {
        
        if ([string length] == 0 && range.length > 0){
            textField.text = [textField.text stringByReplacingCharactersInRange:range withString:string];
            
            if ([[self delegate] respondsToSelector:@selector(textFieldTextChange:andTextFieldName:)]){
                [[self delegate] textFieldTextChange:textField andTextFieldName:self.strTextFieldName];
            }
            
            if ([[self delegate] respondsToSelector:@selector(textFieldTextChange:)]){
                [[self delegate] textFieldTextChange:self];
            }
            
            
            return NO;
        }
        
        nonNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet];
        if ([string stringByTrimmingCharactersInSet:nonNumberSet].length > 0){
            
            if (textField.text.length >= self.MAX_LENGHT && range.length == 0) {
                return NO; // Change not allowed
            } else {
                return YES; // Change allowed
            }
            return YES;
        }
        return NO;
    }
    else if(self.isString){
        
        if (self.isACCEPT_CHARACTER == TRUE) {
            if (textField.text.length >= self.MAX_LENGHT && range.length == 0) return NO;
            cs = [[NSCharacterSet characterSetWithCharactersInString:self.strACCEPT_CHARACTER] invertedSet];
            
            filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
            return [string isEqualToString:filtered];
        }
        else{
            if (textField.text.length >= self.MAX_LENGHT && range.length == 0) return NO;
            else {
                return YES;
            }
        }
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (self.isCheckUnicode) {
        if (textField.text.length == 0) return YES;
        BOOL isConvert = [textField.text canBeConvertedToEncoding:NSASCIIStringEncoding];
        if (isConvert == FALSE) {
            
            if ([[self delegate] respondsToSelector:@selector(textFieldCheckUnicode:andTextFieldName:)]){
                [[self delegate] textFieldCheckUnicode:textField andTextFieldName:self.strTextFieldName];
            }
            
            return YES;
        }
    }
    
    if (self.isCheckLeastOneNuberAndOneWord) {
        if (textField.text.length == 0) return YES;
        if ([Common checkLeastOneWordAndOneNumber:textField.text] == FALSE) {
            if ([[self delegate] respondsToSelector:@selector(textFieldCheckLeastOneNuberAndOneWord:andTextFieldName:)]){
                [[self delegate] textFieldCheckLeastOneNuberAndOneWord:textField andTextFieldName:self.strTextFieldName];
            }
            return NO;
        }
    }
    
    if (self.strValueOrValue.length > 0) {
        if (textField.text.length == 0) return YES;
        NSArray *arraySplit = [self.strValueOrValue componentsSeparatedByString:@","];
        if (arraySplit.count < 2) return YES;
        
        int _first = [[arraySplit objectAtIndex:0] intValue];
        int _second = [[arraySplit objectAtIndex:1] intValue];
        
        if (textField.text.length > _first && textField.text.length < _second) {
            
            if ([[self delegate] respondsToSelector:@selector(textFieldCheckValueOrValue:andTextFieldName:andFirstValue:andSecondValue:)]){
                [[self delegate] textFieldCheckValueOrValue:textField andTextFieldName:self.strTextFieldName andFirstValue:_first andSecondValue:_second];
            }
            
            return NO;
        }
        
        if (textField.text.length < _first) {
            
            if ([[self delegate] respondsToSelector:@selector(textFieldCheckValueOrValue:andTextFieldName:andFirstValue:andSecondValue:)]){
                [[self delegate] textFieldCheckValueOrValue:textField andTextFieldName:self.strTextFieldName andFirstValue:_first andSecondValue:_second];
            }
            
            return NO;
        }
        
        if (textField.text.length > _second) {
            return NO;
        }
    }
    
    if (self.isUpperFirstWord) {
        
        if (textField.text.length == 0) return YES;
        NSArray *arraySplit = [textField.text componentsSeparatedByString:@" "];
        NSString *strResult = _CM_STRING_EMPTY;
        
        for (NSString *str in arraySplit) {
            if ([str isEqualToString: @" "] || str.length == 0) continue;
            
            NSString *stringConvert = [Common upperFirstLetter:str];
            strResult = strResult.length == 0 ? stringConvert : [NSString stringWithFormat:@"%@ %@", strResult, stringConvert];
        }
        
        if (strResult.length > 0) {
            textField.text = strResult;
        }
    }
    
    if (self.isUpper) {
        if (textField.text.length == 0) return YES;
        textField.text = [textField.text uppercaseString];
    }
    
    if (self.isUseEndEditing) {
        if ([[self delegate] respondsToSelector:@selector(textFieldEndEditing:andTextFieldName:)]){
            [[self delegate] textFieldEndEditing:textField andTextFieldName:self.strTextFieldName];
        }
    }
    
    return YES;
}

+ (NSString *)upperFirstLetter:(NSString *)strKeyWord{
    
    NSString *capitalisedSentence = _CM_STRING_EMPTY;
    
    if(strKeyWord.length > 0){
        
        capitalisedSentence = [[strKeyWord lowercaseString] stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                                    withString:[[strKeyWord  substringToIndex:1] capitalizedString]];
    }
    
    return capitalisedSentence;
}


-(void) textFieldTextChange:(id) sender{
    
    UITextField *_textField = (UITextField *) sender;
    // NSLog(@"%@",_textField.text);
    if([self.strTextFieldName isEqual:@"LicensePlateIDMoto"]){
        if(!isDeleteLinkCharacter){
            if(_textField.text.length == 2 || _textField.text.length == 5){
                self.txtTextField.text = [NSString stringWithFormat:@"%@-",_textField.text];
                return;
            }
        }else
        {
            self.txtTextField.text = strInputLicensePlateID;
            return;
        }
    }
    if([self.strTextFieldName isEqual:@"LicensePlateIDCar"]){
        if(!isDeleteLinkCharacter){
            if(_textField.text.length == 2 || _textField.text.length == 4){
                self.txtTextField.text = [NSString stringWithFormat:@"%@-",_textField.text];
                return;
            }
        }else
        {
            self.txtTextField.text = strInputLicensePlateID;
            return;
        }
    }
    
    if ([[self delegate] respondsToSelector:@selector(textFieldTextChange:andTextFieldName:)]){
        [[self delegate] textFieldTextChange:_textField andTextFieldName:self.strTextFieldName];
    }
    
    if ([[self delegate] respondsToSelector:@selector(textFieldTextChange:)]){
        [[self delegate] textFieldTextChange:self];
    }

}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    if ([[self delegate] respondsToSelector:@selector(textFieldDidBeginEditing:andTextFieldName:)]){
        [[self delegate] textFieldDidBeginEditing:textField andTextFieldName:self.strTextFieldName];
    }
    
    if ([[self delegate] respondsToSelector:@selector(textFieldViewDidBeginEditing:)]){
        [[self delegate] textFieldViewDidBeginEditing:self];
    }
    
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    if ([[self delegate]
         respondsToSelector:@selector(textFieldDidEndEditing:andTextFieldName:)]){
        
        [[self delegate] textFieldDidEndEditing:textField
                               andTextFieldName:self.strTextFieldName];
    }
    
    if ([[self delegate]
         respondsToSelector:@selector(textFieldViewDidEndEditing:)]){
        
        [[self delegate] textFieldViewDidEndEditing:self];
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [self.txtTextField resignFirstResponder];
    
    if ([[self delegate] respondsToSelector:@selector(textFieldShouldReturn:andTextFieldName:)]){
        [[self delegate] textFieldShouldReturn:textField andTextFieldName:self.strTextFieldName];
    }
    return YES;
}

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    if ([[self delegate] respondsToSelector:@selector(textFieldClearButton:andTextFieldName:)]){
        [[self delegate] textFieldClearButton:textField andTextFieldName:self.strTextFieldName];
    }
    return YES;
}

- (void)deleteBackward {
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidBackspace:)]){
        [self.delegate textFieldDidBackspace:self];
    }
    
    [self.txtTextField deleteBackward];
    
}

- (BOOL)keyboardInputShouldDelete:(UITextField *)textField {
    
    BOOL shouldDelete = YES;
    
    if ([UITextField instancesRespondToSelector:_cmd]) {
        BOOL (*keyboardInputShouldDelete)(id, SEL, UITextField *) = (BOOL (*)(id, SEL, UITextField *))[UITextField instanceMethodForSelector:_cmd];
        
        if (keyboardInputShouldDelete) {
            shouldDelete = keyboardInputShouldDelete(self, _cmd, textField);
        }
    }
    
    [self deleteBackward];
    
   /* BOOL isIos8 = ([[[UIDevice currentDevice] systemVersion] intValue] == 8);
    BOOL isLessThanIos8_3 = ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.3f);
    
    if (![textField.text length] && isIos8 && isLessThanIos8_3) {
        [self deleteBackward];
    }*/
    
    return shouldDelete;
    
}

@end
