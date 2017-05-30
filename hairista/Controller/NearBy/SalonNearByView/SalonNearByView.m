//
//  SalonNearByView.m
//  hairista
//
//  Created by Dong Vo on 4/28/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SalonNearByView.h"
#import "Salon.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SalonNearByView()
@property (weak, nonatomic) IBOutlet UIImageView *imgViewSalon;
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblPhone;
@property (weak, nonatomic) IBOutlet UILabel *lblOpenTime;

@property (weak, nonatomic) IBOutlet UIView *viewContent;

@end

@implementation SalonNearByView

#pragma mark - Init

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        
        [self setup];
    }
    return self;
}

#pragma mark - Method
-(void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"SalonNearByView" owner:self options:nil].firstObject;
    
    self.clipsToBounds = YES;
    self.view.frame = self.bounds;
    [self addSubview:self.view];
   
    self.layer.masksToBounds = NO;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 4;
    self.layer.shadowOpacity = 0.2;
    self.layer.cornerRadius = 3.0f;
}

-(void)setDataForView:(Salon *)salon{

    [self.imgViewSalon sd_setImageWithURL:[NSURL URLWithString:salon.avatar] placeholderImage:IMG_DEFAULT];
    self.lblPhone.text = [Common convertPhone84:salon.phone];
    self.lblName.text = salon.name;
    self.lblAddress.text = salon.homeAddress;
    self.lblOpenTime.text = [NSString stringWithFormat:@"%@ - %@",salon.openTime, salon.closeTime];
}

@end
