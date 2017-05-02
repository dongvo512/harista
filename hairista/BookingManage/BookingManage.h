//
//  BookingManage.h
//  hairista
//
//  Created by Dong Vo on 5/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BookingManage : NSObject

+ (id)sharedInstance;

-(void)createBooking:(NSDictionary *)dicBody idSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult;

-(void)getListBookingOfMe:(NSString *)indexPage limit:(NSString *)limit startDate:(NSString *)startDate endDate:(NSString *)endDate dataResult:(DataAPIResult)dataApiResult;

@end