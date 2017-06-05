//
//  ServiceBookingCell.m
//  hairista
//
//  Created by Dong Vo on 2/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServiceBookingCell.h"
#import "Service.h"
#import "UIColor+Method.h"

@interface ServiceBookingCell ()

@property (weak, nonatomic) IBOutlet UILabel *lblSerivceName;
@property (weak, nonatomic) IBOutlet UILabel *lblServicePrice;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintLine;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintLine2;

@property (weak, nonatomic) IBOutlet UIView *viewLine;
@property (weak, nonatomic) IBOutlet UIView *viewLine2;
@property (weak, nonatomic) IBOutlet UIImageView *imgInsert;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintInsert;

@end

@implementation ServiceBookingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDataForCell:(Service *)service{

   // if([service.status isEqualToString:@""])
    
    self.lblSerivceName.text = service.name;
    
    self.lblServicePrice.text = [Common getString3DigitsDot:service.price.integerValue];
    
    [self.viewLine setHidden:YES];
    
    [self.viewLine2 setHidden:YES];
    
    if([service.status isEqualToString:@"deleted"]){
        
         CGSize stringSize = [self.lblSerivceName.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:FONT_ROBOTO_REGULAR size:16]}];
        
        if(stringSize.width < SW/2){
        
             [self.viewLine setHidden:NO];
            self.widthContraintLine.constant = stringSize.width + 20;
        }
        
        [self.lblSerivceName setTextColor:[UIColor lightGrayColor]];
        
        CGSize stringSizePrice = [self.lblServicePrice.text sizeWithAttributes:@{NSFontAttributeName: [UIFont fontWithName:FONT_ROBOTO_REGULAR size:16]}];

        if(stringSizePrice.width < SW/2){
            
            [self.viewLine2 setHidden:NO];
            self.widthContraintLine2.constant = stringSizePrice.width + 20;
        }
        
        [self.lblServicePrice setTextColor:[UIColor lightGrayColor]];
        
    }
    
    if(service.isAddNew || [service.status isEqualToString:@"addmore"]){
    
        self.widthContraintInsert.constant = 24;
        [self.imgInsert setHidden:NO];
        [self.lblSerivceName setTextColor:[UIColor whiteColor]];
        [self.lblServicePrice setTextColor:[UIColor whiteColor]];
    }
    else{
    
        self.widthContraintInsert.constant = 0;
        [self.imgInsert setHidden:YES];
    }
    
}
@end
