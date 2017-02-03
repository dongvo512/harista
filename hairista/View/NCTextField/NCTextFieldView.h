//
//  NCTextFieldView.h
//  SAMSS
//
//  Created by Macboook MD102 on 7/6/15.
//  Copyright (c) 2015 com.nc.sams. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NCTextFieldDelegate;

@interface NCTextFieldView : UIView

@property (strong) id delegate;

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UITextField *txtTextField;
@property (nonatomic, strong) NSMutableArray *arrItem;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingContraintTextField;
@property (nonatomic, strong) NSString *strACCEPT_CHARACTER;
@property (nonatomic, strong) NSString *strTextFieldName;
@property (nonatomic) NSString *strValueOrValue; // giá trị nhập vào là 9 hoặc 12 :@"9,12"
@property (nonatomic) int MAX_LENGHT;
@property (nonatomic) BOOL isACCEPT_CHARACTER;
@property (nonatomic) BOOL isNumber;
@property (nonatomic) BOOL isString;
@property (nonatomic) BOOL isUpperFirstWord;
@property (nonatomic) BOOL isCheckUnicode;
@property (nonatomic) BOOL isCheckLeastOneNuberAndOneWord;
@property (nonatomic) BOOL isUpper;
@property (nonatomic) BOOL isLoadDataAfterEdit;
@property (nonatomic) BOOL isUseEndEditing;
@property (nonatomic) BOOL isLockCopy;
@property (nonatomic) BOOL isLockPaste;
@property (nonatomic) BOOL isLockMenuView;
@property (nonatomic) BOOL isFormatLicensePlateMoto;
@property (nonatomic) BOOL isFormatLicensePlateCar;
@property (nonatomic, strong) NSString *strOrginalText;
@property (nonatomic, strong) NSString *strNewText;
@property (nonatomic) BOOL isValidate;

@property (nonatomic, strong) UIScrollView *scrollParent;
@property (nonatomic, strong) UIView *viewContentParent;
@property (nonatomic, strong) UITextView *txtViewDescription;

-(void)setBorderValidate;
-(void)setBorderDefault;
-(void)setColorForPlaceHolder:(UIColor *)color;

@end

@protocol NCTextFieldDelegate
@optional

- (void)textFieldDidBeginEditing:(UITextField *)textFieldControl andTextFieldName:(NSString *) strTextFieldName;

- (void)textFieldDidEndEditing:(UITextField *)textFieldControl andTextFieldName:(NSString *) strTextFieldName;

- (void)textFieldViewDidBeginEditing:(NCTextFieldView *)textFieldView;

- (void)textFieldViewDidEndEditing:(NCTextFieldView *)textFieldView;

- (void)textFieldCheckUnicode:(UITextField *)textFieldControl andTextFieldName:(NSString *) strTextFieldName;

- (void)textFieldCheckLeastOneNuberAndOneWord:(UITextField *)textFieldControl andTextFieldName:(NSString *) strTextFieldName;

- (void)textFieldCheckValueOrValue:(UITextField *)textFieldControl andTextFieldName:(NSString *) strTextFieldName andFirstValue:(int) _firstValue andSecondValue:(int) _secondValue;

- (void)textFieldShouldReturn:(UITextField *)textFieldControl andTextFieldName:(NSString *) strTextFieldName;

- (void)textFieldClearButton:(UITextField *)textField andTextFieldName:(NSString *) strTextFieldName;

- (void)textFieldTextChange:(UITextField *)textField andTextFieldName:(NSString *) strTextFieldName;

- (void)textFieldTextChange:(NCTextFieldView *)nctextField;


- (void)textFieldEndEditing:(UITextField *)textField andTextFieldName:(NSString *) strTextFieldName;

- (void)textFieldDidBackspace:(NCTextFieldView *)textField;
@end
