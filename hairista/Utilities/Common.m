//
//  Common.m
//  eGovernment
//
//  Created by Dong Vo on 1/7/16.
//  Copyright © 2016 NhatCuongMobile. All rights reserved.
//

#import "Common.h"
#import "CommonDefine.h"
#import "Reachability.h"

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

+ (BOOL)checkForWIFIConnection{
    
    BOOL statusInternet = FALSE;
    
    Reachability *wifiReach = [Reachability reachabilityForInternetConnection];
    NetworkStatus netStatus = [wifiReach currentReachabilityStatus];
    
    switch (netStatus){
            
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            statusInternet = FALSE;
            
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            statusInternet = TRUE;
            
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            statusInternet = TRUE;
            
            break;
        }
    }
    
    return statusInternet;
}


+ (NSInteger)yearFromDate:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:date];
    
    return [components year];
}

+ (NSString *)getStringDisplayFormDate:(NSDate *)date andFormatString:(NSString *)format{

    NSString *convertString = @"";
    
    NSDateFormatter *fm = [[NSDateFormatter alloc] init];
    [fm setDateFormat:format];

    convertString = [fm stringFromDate:date];
    
    return convertString;
    
}

+(void)showAlert:(UIViewController *)controller title:(NSString *)title message:(NSString *)message buttonClick:(ButtonClick)buttonClick{

    UIAlertController *vcAlert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *Oke = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       
        
        if(buttonClick){
        
             buttonClick(action);
        }
       
    }];
    
    
    [vcAlert addAction:Oke];
    
    [controller presentViewController:vcAlert animated:YES completion:nil];

}


+ (BOOL)isSameDay:(NSDate*)date1 otherDay:(NSDate*)date2 {
    NSCalendar* calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    
    return [comp1 day]   == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];

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
