//
//  HeaderBannerView.h
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Salon;


@interface HeaderBannerView : UIView

@property (strong, nonatomic) IBOutlet UIView *view;

- (id)initWithFrame:(CGRect)frame listSalonHot:(NSArray *)arraySalonHot;
@property (nonatomic, weak) id delegate;

@end
@protocol HeaderBannerViewDelegate <NSObject>

-(void)selectSalonHeaderView:(Salon *)salon;

@end
