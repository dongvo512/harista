//
//  Common.m
//  eGovernment
//
//  Created by Dong Vo on 1/7/16.
//  Copyright © 2016 NhatCuongMobile. All rights reserved.
//

#import "Common.h"
#import "CommonDefine.h"

@interface Common()

@end

@implementation Common

#pragma mark - System

+ (instancetype)sharedInstance{
    
    static Common *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[Common alloc] init];
        
    });
    return sharedInstance;
}

+ (NSInteger)yearFromDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return [components year];
}

+ (NSInteger)monthFromDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return [components month];
}

+ (NSInteger)dayFromDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return [components day];
}

+ (NSInteger)hourFromDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    return [components hour];
}

+ (NSInteger)minuteFromDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    return [components minute];
}

+ (NSInteger)secondFromDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:date];
    
    return [components second];
}

+ (NSString *)upperFirstLetter:(NSString *)strKeyWord{
    
    NSString *capitalisedSentence = _CM_STRING_EMPTY;
    
    if(strKeyWord.length > 0){
        
        capitalisedSentence = [[strKeyWord lowercaseString] stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                                                    withString:[[strKeyWord  substringToIndex:1] capitalizedString]];
    }
    
    return capitalisedSentence;
}


+ (BOOL)checkLeastOneWordAndOneNumber:(NSString *) strValue{
    
    BOOL isNumber = FALSE;
    BOOL isText = FALSE;
    
    for (int i = 0; i < strValue.length; i++) {
        NSString *ch = [strValue substringWithRange:NSMakeRange(i, 1)];
        if ([self checkIsNumber:ch]) {
            isNumber = TRUE;
        }
        
        if ([self checkIsNumber:ch] == FALSE) {
            isText = TRUE;
        }
        
        if (isNumber == TRUE && isText == TRUE) {
            return TRUE;
        }
    }
    
    if (isNumber == TRUE && isText == TRUE) {
        return TRUE;
    }
    else{
        return FALSE;
    }
}
+ (BOOL)checkIsNumber:(NSString *)strValue{
    
    BOOL isValid = NO;
    NSCharacterSet *alphaNumbersSet = [NSCharacterSet decimalDigitCharacterSet];
    NSCharacterSet *stringSet = [NSCharacterSet characterSetWithCharactersInString:strValue];
    isValid = [alphaNumbersSet isSupersetOfSet:stringSet];
    return isValid;
}
@end
