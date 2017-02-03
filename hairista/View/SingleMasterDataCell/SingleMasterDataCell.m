//
//  MultiSchoolClassCell.m
//  eSchool
//
//  Created by Dong Vo on 9/17/16.
//  Copyright © 2016 NhatCuongSofware. All rights reserved.
//

#import "SingleMasterDataCell.h"

#import "NCScrollLabelView.h"

@interface SingleMasterDataCell ()

@end

@implementation SingleMasterDataCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.scrName.delegate = self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
