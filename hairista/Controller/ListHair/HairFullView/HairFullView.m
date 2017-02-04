//
//  HairFullView.m
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "HairFullView.h"
#import "Hair.h"


@interface HairFullView (){

    Hair *hairCurr;
}

@property (strong, nonatomic) IBOutlet UIView *view;
@property (weak, nonatomic) IBOutlet UILabel *lblName;


@end

@implementation HairFullView

- (id)initWithFrame:(CGRect)frame hair:(Hair *)hair{
    if(self = [super initWithFrame:frame]){
        
        hairCurr = hair;
        [self setup];
    }
    return self;
}
- (void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"HairFullView" owner:self options:nil].firstObject;
    
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
    self.imgViewHair.image = [UIImage imageNamed:hairCurr.imgName];
    self.lblName.text = hairCurr.hairName;
}
- (IBAction)tapView:(id)sender {
    
    [UIView animateWithDuration:0.5
                     animations:^{self.alpha = 0.0;}
                     completion:^(BOOL finished){ [self removeFromSuperview]; }];
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
