//
//  NoteDetailView.h
//  hairista
//
//  Created by Dong Vo on 4/21/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Booking;

@interface NoteDetailView : UIView

-(id)initWithFrame:(CGRect)frame booking:(Booking *)booking;

@property (nonatomic, weak) id delegate;

@property (strong, nonatomic) IBOutlet UIView *view;

@end
@protocol NoteDetailViewDelegate <NSObject>

-(void)finishUpdateNote:(NSString *)note;

@end
