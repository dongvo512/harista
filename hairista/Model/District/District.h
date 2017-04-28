//
//  District.h
//  hairista
//
//  Created by Dong Vo on 4/27/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface District : NSObject

@property (nonatomic, strong) NSNumber *idDistrict;
@property (nonatomic, strong) NSNumber *idProvince;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *name;

@end

/*
 {
 "id": 886,
 "provinceId": 89,
 "type": "Huyện",
 "location": "10 50 12N, 105 05 33E",
 "name": "An Phú                                                                                                                                                                                                                                                         "
 }
*/
