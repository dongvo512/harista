//
//  DistrictViewController.h
//  hairista
//
//  Created by Dong Vo on 4/27/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class District;

@interface DistrictViewController : UIViewController

@property (nonatomic, weak) id delegate;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil districtSelected:(District *)aDistrictSelected province:(NSString *)idProvinceParent;

@end
@protocol DistrictViewControllerDelegte <NSObject>

-(void)selectedDistrict:(District *)district controller:(DistrictViewController *)controller;

@end
