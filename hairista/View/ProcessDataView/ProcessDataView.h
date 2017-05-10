//
//  ProcessDataView.h
//  hairista
//
//  Created by Dong Vo on 4/15/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProcessDataView : UIView

-(id)initWithFrame:(CGRect)frame withImage:(UIImage *)image progress:(NSProgress *)progress;
-(void)closeProgress;
@end
