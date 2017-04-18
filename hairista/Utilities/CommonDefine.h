//
//  CommonSAMSDefine.h
//  SAMSS
//
//  Created by Dong vo on 04/04/2017.
//  Copyright (c) 2017 hairista. All rights reserved.
//


#pragma mark - Devices



#define Appdelegate_hairista ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define _CM_IPAD @"IPAD"
#define _CM_IPAD_PRO @"IPAD PRO"
#define _CM_IPHONE_3_5_INCH     @"IPHONE 3.5 INCH"
#define _CM_IPHONE_4_INCH       @"IPHONE 4 INCH"
#define _CM_IPHONE_47_INCH      @"IPHONE 4.7 INCH"
#define _CM_IPHONE_55_INCH      @"IPHONE 5.5 INCH"

#define _CM_STRING_EMPTY @""

#define IDIOM    UI_USER_INTERFACE_IDIOM()
#define IPAD     UIUserInterfaceIdiomPad
#define IPHONE   UIUserInterfaceIdiomPhone
#define SW ([[UIScreen mainScreen] bounds].size.width)
#define SH ([[UIScreen mainScreen] bounds].size.height)

#define CHECK_NIL(value) (value == [NSNull null]?@"":value)

#define IMG_DEFAULT [UIImage imageNamed:@"bg_default"]


//-------------------------------------------------------------------------------

#pragma mark - Notification



//-------------------------------------------------------------------------------
#pragma mark - Fonts

// -- Roboto --
#define FONT_ROBOTO_MEDIUM_ITALIC @"Roboto-MediumItalic"
#define FONT_ROBOTO_REGULAR @"Roboto-Regular"
#define FONT_ROBOTO_THIN @"Roboto-Thin"
#define FONT_ROBOTO_MEDIUM @"Roboto-Medium"
#define FONT_ROBOTO_BLACK @"Roboto-Black"
#define FONT_ROBOTO_LIGHT_ITALIC @"Roboto-LightItalic"
#define FONT_ROBOTO_BOLD_ITALIC @"Roboto-BoldItalic"
#define FONT_ROBOTO_BLACK_ITALIC @"Roboto-BlackItalic"
#define FONT_ROBOTO_LIGHT @"Roboto-Light"
#define FONT_ROBOTO_BOLD @"Roboto-Bold"
#define FONT_ROBOTO_ITALIC @"Roboto-Italic"
#define FONT_ROBOTO_THIN_ITALIC @"Roboto-ThinItalic"

// -- Roboto Condensed --
#define  FONT_ROBOTO_CONDENSED_BOLD_ITALIC @"RobotoCondensed-BoldItalic"
#define  FONT_ROBOTO_CONDENSED_ITALIC @"RobotoCondensed-Italic"
#define  FONT_ROBOTO_CONDENSED_LIGHT @"RobotoCondensed-Light"
#define  FONT_ROBOTO_CONDENSED_LIGHT_ITALIC @"RobotoCondensed-LightItalic"
#define  FONT_ROBOTO_CONDENSED_REGULAR @"RobotoCondensed-Regular"
#define  FONT_ROBOTO_CONDENSED_BOLD @"RobotoCondensed-Bold"

//Helvetica
#define _CM_FONT_HELVETICA_LIGHT @"HelveticaNeue-Light"
#define _CM_FONT_HELVETICA @"Helvetica"
#define _CM_DEFAULT_FONT_REGULAR @"HelveticaNeue"
#define _CM_DEFAULT_FONT_MEDIUM @"HelveticaNeue-Medium"
#define _CM_DEFAULT_FONT_MEDIUM_ITALIC @"HelveticaNeue-MediumItalic"
#define _CM_DEFAULT_FONT_ITALIC @"HelveticaNeue-LightItalic"
#define _CM_DEFAULT_FONT_BOLD @"HelveticaNeue-CondensedBold"

// -- Arial --
#define _CM_DEFAULT_FONT @"Arial"
#define FONT_ARIAL_BOLD @"Arial-BoldMT"

// -- OpenSans --
#define FONT_OPENSANS_LIGHT_ITALIC @"OpenSansLight-Italic"
#define FONT_OPENSANS_BOLD @"OpenSans-Bold"
#define FONT_OPENSANS_SEMI_BOLD_ITALIC @"OpenSans-SemiboldItalic"
#define FONT_OPENSANS_EXTRABOLD @"OpenSans-Extrabold"
#define FONT_OPENSANS @"OpenSans"
#define FONT_OPENSANS_BOLD_ITALIC @"OpenSans-BoldItalic"
#define FONT_OPENSANS_LIGHT @"OpenSans-Light"
#define FONT_OPENSANS_EXTRA_BOLD_ITALIC @"OpenSans-ExtraboldItalic"
#define FONT_OPENSANS_ITALIC @"OpenSans-Italic"
#define FONT_OPENSANS_SEMI_BOLD @"OpenSans-Semibold"


//-------------------------------------------------------------------------------
#pragma mark - ACCEPTABLE_CHARECTERS

#define _CM_ACCEPTABLE_CHARECTERS_NAME @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'"

#define _CM_ACCEPTABLE_CHARECTERS @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789- ,."
#define _CM_ACCEPTABLE_CHARECTERS2 @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-"
#define _CM_ACCEPTABLE_CHARECTERS3 @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define _CM_ACCEPTABLE_CHARECTERS4 @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-."
#define _CM_ACCEPTABLE_CHARECTERS5 @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-, "
#define _CM_ACCEPTABLE_CHARECTERS6 @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789/,. "
#define _CM_ACCEPTABLE_CHARECTERS7 @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789@.-_"
#define _CM_ACCEPTABLE_CHARECTERS_NUMBER_STRING @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
#define _CM_ACCEPTABLE_STRING @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "
#define _CM_ACCEPTABLE_NUMBER @" ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz "

#define _CM_SIGNATURE_DEFAULT @"<br/><br/>----- ----- ----- ----- ----- ----- ----- ----- ----- ----- ----- -----<br/>"

#define _CM_STRING_EMPTY @""
#define STRING_EMPTY @""
#define _CM_STRING_WATING_DATACACHE @"Đang lấy dữ liệu"
#define _CM_BOOL_FALSE @"false"
#define _CM_BOOL_TRUE @"true"
#define _CM_BOOL_FALSE_NUMBER @"0"
#define _CM_BOOL_TRUE_NUMBER @"1"

#define BOOL_FALSE @"false"
#define BOOL_TRUE @"true"

#define BOOL_FALSE_NUMBER @"0"
#define BOOL_TRUE_NUMBER @"1"

#define _CM_INT_DECIMAL_DEFAULT @"0"
#define INT_DECIMAL_DEFAULT @"1"

#define _CM_INT_DECIMAL_NULL @"-1"
#define INT_DECIMAL_NULL @"-1"

#define _CM_SOUND_TICK @"Tick"
#define _CM_SOUND_ERROR @"Error"
#define _CM_NUMBER @"0123456789"

#pragma mark - API

#define kHTTP_METHOD_POST   @"POST"
#define kHTTP_METHOD_GET    @"GET"
#define kHTTP_METHOD_PUT    @"PUT"

#define URL_POST_REGISTER @"https://salonhair.herokuapp.com/api/v1/register"
#define URL_POST_LOGIN @"https://salonhair.herokuapp.com/api/v1/login"
#define URL_PUT_CHANGE_PASSWORD @"https://salonhair.herokuapp.com/api/v1/users/me/changePassword"
#define URL_PUT_UPDATE_USER_INFO @"https://salonhair.herokuapp.com/api/v1/users/me"
#define URL_GET_LIST_SALON @"https://salonhair.herokuapp.com/api/v1/salons"
#define URL_GET_DETAIL_SALON @"https://salonhair.herokuapp.com/api/v1/users/"
#define URL_POST_URL_IMAGE @"https://salonhair.herokuapp.com/api/v1/imagesUrl"

//

