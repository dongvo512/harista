//
//  HeaderBannerCell.m
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "HeaderBannerCell.h"
#import "Salon.h"


@interface HeaderBannerCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewBanner;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonName;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblSalonTimeOpen;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewRating;

@end

@implementation HeaderBannerCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setDataForCell:(Salon *)salon{

    self.imgViewBanner.image = [UIImage imageNamed:salon.strSalonUrl];
    self.lblSalonName.text = salon.strSalonName;
    self.lblSalonPhone.text = salon.strPhone;
    self.lblSalonTimeOpen.text = salon.openTime;
}

@end
