//
//  HeaderViewBooking.m
//  hairista
//
//  Created by Dong Vo on 2/12/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "HeaderViewBooking.h"

@interface HeaderViewBooking ()
@property (strong, nonatomic) IBOutlet UIView *view;

@end

@implementation HeaderViewBooking

#pragma mark - Init

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

#pragma mark - Method
- (void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"HeaderViewBooking" owner:self options:nil].firstObject;
    
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
}

@end
