//
//  UploadImageViewController.h
//  hairista
//
//  Created by Dong Vo on 5/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UploadImageViewController : UIViewController
@property (nonatomic, weak) id delegate;
@end
@protocol UploadImageViewControllerDelegate <NSObject>

-(void)finishUploadImages:(UploadImageViewController *)controller;

@end
