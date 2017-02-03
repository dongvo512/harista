//
//  NCComboboxNewView.h
//  eSAMS
//
//  Created by steven on 7/27/16.
//  Copyright © 2016 NhatCuongMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NCScrollLabelView.h"
@interface NCComboboxNewView : UIView
@property (nonatomic, strong) id delegate;
@property (strong, nonatomic) IBOutlet NCScrollLabelView  *scrlbName;
@property (nonatomic) NSInteger typeMasterDataCombobox;
@property (weak, nonatomic) IBOutlet UIButton *btnSelected;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (nonatomic) BOOL isValidate;
@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leaddingTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingImaIcon;


-(void)setImageIcon:(NSString *)strNameIcon;
-(void)setTextName:(NSString *)strName andFont:(UIFont*)font;
- (NSString *)getText;
-(void)setTextName:(NSString *)strName;
-(void)setbackGroundView:(UIColor *)color;
-(void)setTextColor:(UIColor *)textColor;
-(void)setPlaceHolder:(NSString *)strPlaceHolder;
-(void)updateHeightFrameAfterAutolayout:(float)height;
-(void)setFontForTextField:(UIFont *)font;
-(void)setDisableSwipe;
-(void)setEnableSwipe;
-(void)setBorderValidate;
-(void)setBorderDefault;
-(void)setEnable:(BOOL)isEnable;
-(void)sethiddenBttnSelect;
-(void)showBtnSelected;

@end
@protocol NCComboboxNewViewDelegate <NSObject>
@optional

- (void)didSelect:(CGRect)frame inView:(UIView *)vieParent andType:(NSInteger)type andCombobox:(NCComboboxNewView*)comboboxCurr;

- (void)clearCombobox:(NCComboboxNewView *)comboboxCurr;
@end
