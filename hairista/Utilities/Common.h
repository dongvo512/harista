//
//  Common.h
//  eGovernment
//
//  Created by Dong Vo on 1/7/16.
//  Copyright © 2016 NhatCuongMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define MAX_TOTAL_MB_FILE 4*1024*1024

@interface Common : NSObject

#pragma mark - System
+ (instancetype)sharedInstance;

#pragma mark - Devices
+ (NSInteger)yearFromDate:(NSDate *)date;

+ (NSInteger)monthFromDate:(NSDate *)date;

+ (NSInteger)dayFromDate:(NSDate *)date;

+ (NSInteger)hourFromDate:(NSDate *)date;

+ (NSInteger)minuteFromDate:(NSDate *)date;

+ (NSInteger)secondFromDate:(NSDate *)date;

+ (BOOL)checkLeastOneWordAndOneNumber:(NSString *) strValue;

+ (NSString *)upperFirstLetter:(NSString *)strKeyWord;

@end
