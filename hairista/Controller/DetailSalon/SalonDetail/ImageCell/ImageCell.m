//
//  ImageCell.m
//  hairista
//
//  Created by Dong Vo on 4/15/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ImageCell.h"

@implementation ImageCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 4; // if you like rounded corners
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.2;
    
}

@end
