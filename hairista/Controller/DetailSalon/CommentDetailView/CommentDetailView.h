//
//  CommentDetailView.h
//  hairista
//
//  Created by Dong Vo on 4/21/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Salon,Comment;

@interface CommentDetailView : UIView

-(id)initWithFrame:(CGRect)frame salon:(Salon *)salon;

@property (nonatomic, weak) id delegate;

@property (strong, nonatomic) IBOutlet UIView *view;

@end
@protocol CommentDetailViewDelegate <NSObject>

-(void)commented:(Comment *)comment;

@end
