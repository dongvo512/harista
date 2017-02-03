//
//  MultiSchoolClassCell.h
//  eSchool
//
//  Created by Dong Vo on 9/17/16.
//  Copyright © 2016 NhatCuongSofware. All rights reserved.
//

#import <UIKit/UIKit.h>


@class SchoolClassTemp,SchoolClassObject,NCScrollLabelView;

@interface SingleMasterDataCell : UITableViewCell
@property (weak, nonatomic) IBOutlet NCScrollLabelView *scrName;
@property (weak, nonatomic) IBOutlet UIImageView *imgVSelected;

@end
