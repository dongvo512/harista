//
//  NCSearchBarView.h
//  eSAMS
//
//  Created by Dong Vo on 6/24/16.
//  Copyright © 2016 NhatCuongMobile. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NCTextFieldView;

@interface NCSearchBarView : UIView

//@property (weak, nonatomic) IBOutlet UIButton *btnSearchAdvance;
@property (weak, nonatomic) IBOutlet NCTextFieldView *tfSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnClearText;


@property (nonatomic) id delegate;
+ (id)sharedInstance :(CGRect)frame;
//+ (id)sharedInstance;
//- (void)hiddenSearchAdvance;

//- (void)showSearchAdvance;

- (void)showSearchBar;
- (void)close;
- (void)clearSearchTextField ;

@end
@protocol NCSearchBarViewDelegate <NSObject>

@optional

-(void)selectedBtnClose;
//-(void)selectedBtnSearchAdvance;

- (void)searchBarDidBeginEditing:(UITextField *)textField andTextFieldName:(NSString *) strTextFieldName;

- (void)searchBarShouldReturn:(UITextField *)textField
             andTextFieldName:(NSString *) strTextFieldName;
    
- (void)searchBarTextChange:(UITextField *)textField
           andTextFieldName:(NSString *)strTextFieldName;

- (void)selectedBtnClearText;

@end
