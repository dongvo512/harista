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

@property (nonatomic, weak) id delegate;

-(void)setDataForCell:(BOOL)isShowSearchOption location:(BOOL)isLocation;
@end

@protocol SearchOptionSalonCellDelegate <NSObject>

-(void)switchChangeValue:(BOOL)isSwitchOn;

-(void)selectedBtnSearch;

-(void)selectedBtnShowMore:(UIButton *)btnSelected;

-(void)touchCBOProvince;
-(void)touchCBODistrict;


-(void)clearCboProvice;
-(void)clearCboDistrict;

@end
