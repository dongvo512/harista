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

typedef void (^ButtonClick)(UIAlertAction *alertAction);
typedef void (^DataAPIResult)(NSError *error, id idObject);
typedef void (^CallAPIResult)(BOOL isError, NSString *stringError, id responseDataObject);
#pragma mark - System
+ (instancetype)sharedInstance;
+ (BOOL)checkForWIFIConnection;

#pragma mark - Devices
+ (NSInteger)yearFromDate:(NSDate *)date;

+ (NSInteger)monthFromDate:(NSDate *)date;

+ (NSInteger)dayFromDate:(NSDate *)date;

+ (NSInteger)hourFromDate:(NSDate *)date;

+ (NSInteger)minuteFromDate:(NSDate *)date;

+ (NSInteger)secondFromDate:(NSDate *)date;

+ (BOOL)checkLeastOneWordAndOneNumber:(NSString *) strValue;

+ (NSString *)upperFirstLetter:(NSString *)strKeyWord;

+ (NSString *)getStringDisplayFormDate:(NSDate *)date andFormatString:(NSString *)format;
+ (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2;

+ (NSString *)formattedDateTimeWithDateString:(NSString *)inputDateString inputFormat:(NSString *)inputFormat outputFormat:(NSString *)outputFormat;
#pragma mark - Alert
+(void)showAlert:(UIViewController *)controller title:(NSString *)title message:(NSString *)message buttonClick:(ButtonClick)buttonClick;
+ (NSString *)getString3DigitsDot:(NSInteger )number;
+(NSDate *)getDateFromStringFormat:(NSString *)dateString format:(NSString *)format;
@end
