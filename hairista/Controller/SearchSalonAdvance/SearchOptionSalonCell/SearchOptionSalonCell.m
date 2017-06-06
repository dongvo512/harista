//
//  SearchOptionSalonCell.m
//  hairista
//
//  Created by Dong Vo on 1/31/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SearchOptionSalonCell.h"
#import "NCComboboxNewView.h"
#import "UIColor+Method.h"

@interface SearchOptionSalonCell ()

@property (weak, nonatomic) IBOutlet UISwitch *switchNearBy;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnShowMore;
@property (weak, nonatomic) IBOutlet UIView *viewOption;
@property (weak, nonatomic) IBOutlet UIView *viewNearBy;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraintNearby;
@property (weak, nonatomic) IBOutlet UISwitch *switchNearby;

@end

@implementation SearchOptionSalonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.btnSearch.layer.borderWidth = 0.5;
    self.btnSearch.layer.borderColor = [UIColor grayTextCombobox].CGColor;
    
    [self.cboProvince.view setBackgroundColor:[UIColor whiteColor]];
    [self.cboProvince setPlaceHolder:@"Tỉnh thành"];
    self.cboProvince.delegate = self;
    
    [self.cboDistrict.view setBackgroundColor:[UIColor whiteColor]];
    [self.cboDistrict setPlaceHolder:@"Quận huyện"];
    self.cboDistrict.delegate = self;
    
}
- (IBAction)changeSwitch:(id)sender {
    
    UISwitch *mySwitch = (UISwitch *)sender;
   
    BOOL isSwitchOn;
    
    if ([mySwitch isOn]) {
      
        isSwitchOn = YES;
        
    } else {
        
        isSwitchOn = NO;
    }
    
    if([[self delegate] respondsToSelector:@selector(switchChangeValue:)]){
    
        [[self delegate] switchChangeValue:isSwitchOn];
    }
}

- (IBAction)touchBtnSearch:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(selectedBtnSearch)]){
        
        [[self delegate] selectedBtnSearch];
    }
}


- (IBAction)touchBtnShowMore:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(selectedBtnShowMore:)]){
    
        [[self delegate] selectedBtnShowMore:(UIButton *)sender];
    }
}

-(void)setDataForCell:(BOOL)isShowSearchOption location:(BOOL)isLocation{

    if(isShowSearchOption){
    
        [self.btnShowMore setImage:[UIImage imageNamed:@"ic_show_up"] forState:UIControlStateNormal];
        [self.viewOption setHidden:NO];
           }
    else{
    
        [self.btnShowMore setImage:[UIImage imageNamed:@"ic_show_down"] forState:UIControlStateNormal];
        [self.viewOption setHidden:YES];
        
    }
    
    if(isLocation){
        
        self.heightContraintNearby.constant = 44;
        [self.viewNearBy setHidden:NO];

    }
    else{
    
        self.heightContraintNearby.constant = 0;
        [self.viewNearBy setHidden:YES];
    }
}

#pragma mark - NCComboboxNewViewDelegate
- (void)didSelect:(CGRect)frame inView:(UIView *)vieParent andType:(NSInteger)type andCombobox:(NCComboboxNewView*)comboboxCurr{

    if([comboboxCurr isEqual:self.cboProvince]){
    
        if([[self delegate] respondsToSelector:@selector(touchCBOProvince)]){
        
            [[self delegate] touchCBOProvince];
        }
    }
    else if ([comboboxCurr isEqual:self.cboDistrict]){
    
        if([[self delegate] respondsToSelector:@selector(touchCBODistrict)]){
            
            [[self delegate] touchCBODistrict];
        }
    }
    
}

- (void)clearCombobox:(NCComboboxNewView *)comboboxCurr{

    if([comboboxCurr isEqual:self.cboProvince]){
        
        if([[self delegate] respondsToSelector:@selector(clearCboProvice)]){
            
            [[self delegate] clearCboProvice];
        }
    }
    else if ([comboboxCurr isEqual:self.cboDistrict]){
        
        if([[self delegate] respondsToSelector:@selector(clearCboDistrict)]){
            
            [[self delegate] clearCboDistrict];
        }
    }
    else{
        
       
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
