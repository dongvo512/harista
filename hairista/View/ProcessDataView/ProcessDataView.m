//
//  ProcessDataView.m
//  hairista
//
//  Created by Dong Vo on 4/15/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ProcessDataView.h"

@interface ProcessDataView ()
@property (strong, nonatomic) IBOutlet ProcessDataView *view;
@property (weak, nonatomic) IBOutlet UIImageView *imgUpload;
@property (nonatomic, weak) UIImage *imageUpoadCurr;
@end

@implementation ProcessDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image{
   
    self = [super initWithFrame:frame];
    if(self){
       
        self.imageUpoadCurr = image;
        
        [self setup];
    }
   
    return self;
}

-(void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"ProcessDataView" owner:self options:nil].firstObject;
    self.clipsToBounds = YES;

    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
    if(self.imageUpoadCurr){
    
        [self.imgUpload setImage:self.imageUpoadCurr];
    }
}
- (IBAction)stopUpload:(id)sender {
    
    [Appdelegate_hairista.progressCurr cancel];
    
    [self closeProgress];
    
}

-(void)closeProgress{

    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         [self setFrame:CGRectMake(0, SH, SW, 50)];
                     }
                     completion:^(BOOL finished) {
                         
                         [self removeFromSuperview];
                         Appdelegate_hairista.processDataView = nil;
                         
                     }];
    [UIView commitAnimations];

}

@end
