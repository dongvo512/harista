//
//  Booking.h
//  hairista
//
//  Created by Dong Vo on 2/12/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Salon.h"
#import "SessionUser.h"

@interface Booking : NSObject

@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *discount;
@property (nonatomic, strong) NSNumber *idBooking;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *name_slug;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) Salon *salon;
@property (nonatomic, strong) NSString *salonId;
@property (nonatomic, strong) NSString *startDate;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *totalPrice;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) SessionUser *user;
@property (nonatomic, strong) NSString *userId;




@property (nonatomic, strong) NSString *imgAvtarName;
@property (nonatomic, strong) NSString *strDate;
@property (nonatomic, strong) NSString *strUserNameBooking;
@property (nonatomic, strong) NSString *strUserPhone;
@property (nonatomic, strong) NSString *strListService;

@end
