//
//  AppDelegate.h
//  test
//
//  Created by Dong Vo on 2/3/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SessionUser.h"
#import "ProcessDataView.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) SessionUser *sessionUser;
@property (nonatomic, strong) ProcessDataView *processDataView;
@property (nonatomic, strong) NSProgress *progressCurr;
@property (nonatomic, strong) NSString *deviceToken;
#pragma mark - Popup Golbal

-(void)showProcessBar:(UIImage *)image progress:(NSProgress *)progressCurr;
-(void)closeProgress;
@end

