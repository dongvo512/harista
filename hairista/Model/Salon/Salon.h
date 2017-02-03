//
//  Salon.h
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Salon : NSObject
@property (nonatomic, strong) NSString *strAddress;
@property (nonatomic, strong) NSString *strSalonName;
@property (nonatomic, strong) NSString *strSalonUrl;
@property (nonatomic, strong) NSString *strPhone;
@property (nonatomic, strong) NSString *strEMail;
@property (nonatomic, strong) NSString *openTime;

@end
