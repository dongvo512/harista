//
//  NCScrollLabelView.h
//  SAMSS
//
//  Created by Macboook MD102 on 7/6/15.
//  Copyright (c) 2015 com.nc.sams. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NCScrollLabelView : UIView

@property (strong, nonatomic) id delegate;
@property (nonatomic) NSInteger indexRow;
@property (weak, nonatomic) IBOutlet UILabel *lblText;
-(void)setText:(NSString *)strText andFont:(UIFont *)font;
- (void)setTextColorForText:(UIColor *)color;
-(void)setFontForText:(UIFont *)font;
-(void)setAlignCenter;
@end
@protocol NCScrollLabelViewDelegate <NSObject>
@optional

- (void)didSelectLabelScrollView:(NCScrollLabelView *)labelScrollView atIndex:(NSInteger)indexRow;

@end
