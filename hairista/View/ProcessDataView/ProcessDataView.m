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
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (nonatomic, weak) NSProgress *progressCurr;
@end

@implementation ProcessDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image progress:(NSProgress *)progress{

    self = [super initWithFrame:frame];
    if(self){
        
        self.imageUpoadCurr = image;
        self.progressCurr = progress;
        [self setup];
    }
    
    return self;

}
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
    
   
    [self.progressCurr setTotalUnitCount:1];
    [self.progressCurr addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
    
   
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
   
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
      
        NSLog(@"%.21g",progress.fractionCompleted);
        
        if(progress.fractionCompleted <= 1){
        
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.progressView setProgress:progress.fractionCompleted animated:YES];
            });
        }
       
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
                         [Appdelegate_hairista.progressCurr cancel];
                         Appdelegate_hairista.processDataView = nil;
                         
                     }];
    [UIView commitAnimations];

}

@end
