//
//  SearchOptionSalonCell.h
//  hairista
//
//  Created by Dong Vo on 1/31/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NCComboboxNewView;

@interface SearchOptionSalonCell : UITableViewCell

@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboProvince;
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboDistrict;
@property (weak, nonatomic) IBOutlet NCComboboxNewView *cboNumberStar;

@property (nonatomic, weak) id delegate;

-(void)setDataForCell:(BOOL)isShowSearchOption;
@end

@protocol SearchOptionSalonCellDelegate <NSObject>

-(void)selectedBtnSearch;

-(void)selectedBtnShowMore:(UIButton *)btnSelected;

-(void)touchCBOProvince;
-(void)touchCBODistrict;
-(void)touchCBONumberStar;

-(void)clearCboProvice;
-(void)clearCboDistrict;
-(void)clearCboNumberStar;
@end
