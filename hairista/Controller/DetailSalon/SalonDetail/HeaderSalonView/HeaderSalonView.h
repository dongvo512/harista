//
//  HeaderSalonView.h
//  hairista
//
//  Created by Dong Vo on 4/15/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Salon;

@interface HeaderSalonView : UICollectionReusableView

@property (nonatomic, weak) id delegate;
-(void)setDataForView:(Salon *)salon;

@end
@protocol HeaderSalonViewDelegate <NSObject>

-(void)selectFavorite;
-(void)selectLocation;

@end
