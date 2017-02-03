//
//  CommonSAMSDefine.h
//  SAMSS
//
//  Created by Dong vo on 01/08/2016.
//  Copyright (c) 2016 NhatCuong. All rights reserved.
//

//ProERP Version
#pragma mark - ProERP Version


#define IOS_VERSION_EPUPIL  @"1.0_23/08/2016"

//More Key HandShake
#pragma mark - More Key HandShake

#define _CM_MOREKEY @"1213ckjkvivaLaLa"

#pragma mark - PermisstionView

//-------------------------------------------------------------------------------

#pragma mark - Devices

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
#define Appdelegate_Pupil ((AppDelegate *)[[UIApplication sharedApplication] delegate])

#define HEIGHT_CELL_OPTION 45


//-------------------------------------------------------------------------------

#pragma mark - Notification 

#define EDITED_REQUEST_OFF @"EDITED_REQUEST_OFF"

#define SELECTED_MENU_BUTON @"SELECTED_MENU_BUTON"

#define SELECTED_SCORE_BUTTON @"SELECTED_SCORE_BUTTON"


#define LOG_OUT @"LOG_OUT"

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

#define _CM_Application_Name @"EGovSAMS"

#define _CM_SOUND_TICK @"Tick"
#define _CM_SOUND_ERROR @"Error"
#define _CM_NUMBER @"0123456789"

#pragma mark - Config App Temp
#define SCHOOLCLASSRIGHTTYPEALL @"SCHOOLCLASSRIGHTTYPEALL"

#define DANH_MUC_NHAN_XET @"DANH MỤC NHẬN XÉT"
#define UPDATE_DANH_GIA_DINH_KI_MON_HOC @"UPDATE DÁNH GIÁ ĐỊNH KÌ MÔN HỌC"
#define DANH_SÁCH_MỨC_ĐÁNH_GIÁ_HỌC_SINH @"DANH SÁCH MỨC ĐÁNH GIÁ HỌC SINH"
#define DANH_SACH_KI_DANH_GIA @"DANH SÁCH KÌ ĐÁNH GIÁ"
#define DANH_GIA_DINH_KI_MON_HOC @"ĐÁNH GIÁ ĐỊNH KÌ MÔN HỌC"
#define XOA_THONG_TIN_DIEM_DANH @"XOÁ THÔNG TIN ĐIỂM DANH"
#define CAP_NHAT_THONG_TIN_CAU_HINH_MAC_DINH_CUA_USER_LOGIN @"CẬP NHẬT THÔNG TIN CẤU HÌNH MẶC ĐỊNH CỦA USER"
#define DANH_SACH_LOP_CUA_TRUONG_THEO_MON_HOC @"DANH SÁCH LỚP CỦA TRƯỜNG THEO MÔN HỌC"
#define CHECK_PERMISSION_FOLLOWING_LOP @"CHECK QUYỀN THEO USER TRÊN LỚP "
#define DANH_SACH_KHU_PHO @"DANH SÁCH KHU PHÔ"
#define DANH_SACH_CHE_DO_MIEN_GIAM @"DANH SÁCH CHẾ ĐỘ MIỄN GIẢM"
#define DANH_SACH_TRANG_THAI_HOC_TAP @"DANH SÁCH TRANG THÁI HỌC TẬP"
#define DANH_SACH_LOAI_HINH_HOC_TAP @"DANH SÁCH LOẠI HÌNH HỌC TẬP"
#define DANH_SACH_DOI_TUONG_CHINH_XACH @"DANH SÁCH ĐỐI TƯỢNG CHÍNH XÁCH"
#define DANH_SACH_NGHE_NGHIEP @"DANH SÁCH NGHỀ NGHIỆP"
#define DANH_SACH_NOI_CAP_CMND @"DANH SÁCH NƠI CẤP CMND"
#define DANH_SACH_HE_NGOAI_NGU @"DANH SÁCH HỆ NGOẠI NGỮ"
#define DANH_SACH_LOAI_KHUYET_TAT @"DANH SÁCH LOẠI KHUYẾT TẬT"
#define DANH_SACH_PHUONG_XA @"DANH SÁCH PHƯỜNG XÃ"
#define DANH_SACH_QUAN_HUYEN @"DANH SÁCH QUẬN HUYỆN"
#define DANH_SACH_TINH_THANH_PHO @"DANH SÁCH TỈNH THÀNH PHỐ"
#define DANH_SACH_QUOC_TICH @"DANH SÁCH QUỐC TỊCH"
#define DANH_SACH_NHOM_MAU @"DANH SÁCH NHÓM MÁU"
#define DANH_SACH_QUOC_GIA @"DANH SÁCH QUỐC GIA"
#define UPDATE_DANH_GIA_THUONG_XUYEN @"UPDATE DÁNH GIÁ THƯỜNG XUYÊN"
#define DANH_SACH_THANG_THUONG_XUYEN @"DANH SÁCH THÁNG ĐÁNH GIÁ THƯỜNG XUYÊN"
#define DANH_SACH_DANH_GIA_THUONG_XUYEN @"DANH SÁCH ĐÁNH GIÁ THƯỜNG XUYÊN"
#define DANH_SACH_TRUONG @"DANH SÁCH LOẠI TRƯỜNG"
#define DANH_SACH_QUAN_LI_HOC_SINH @"DANH SÁCH QUẢN LÍ HỌC SINH"
#define DANH_SACH_DIEM_DANH_HOC_SINH @"DANH SÁCH ĐIỂM DANH HỌC SINH"
#define UPDATE_GIAO_VIEN_BO_MON @"DANH SÁCH GIÁO VIÊN BỘ MÔN"
#define DANH_SACH_LOAI_HANH_KIEM @"DANH SÁCH LOẠI HẠNH KIỂM"
#define DANH_SACH_LOP_THEO_GIAO_VIEN @"DANH SÁCH THEO GIÁO VIÊN"
#define DANH_SACH_GIAO_VIEN_THEO_MON_HOC @"DANH SÁCH THEO MÔN HỌC"
#define DANH_SACH_MON_HOC_THEO_TRUONG @"DANH SÁCH MÔN HỌC THEO TRƯỜNG"
#define DANH_SACH_SCHOOLSETTING @"DANH SÁCH SCHOOL SETTING"
#define DANH_SACH_SO_TIET_HOC_TU_BUOI_HOC @"DANH SÁCH SỐ TIẾT HỌC TỪ BUỔI HỌC"
#define DANH_SACH_BUOI_HOC @"DANH SÁCH BUỔI HỌC"
#define MON_HOC_THEO_LOP_USER @"MÔN HỌC THEO LỚP DỰA TRÊN USER LOGIN"
#define MON_HOC_THEO_LOP @"MỘN HỌC THEO LỚP ALL"
#define GIAO_VIEN_THEO_TRUONG @"GIAO VIÊN THEO TRƯỜNG "
#define LOP_THEO_GIAO_VIEN @"LỚP THEO GIÁO VIÊN"
#define KHOI_THEO_TRUONG @"KHỐI THEO TRƯỜNG"
#define APP_CONFIG_THEO_USER @"APP CONFIG THEO USER LOGIN"
#define ALL_APP_CONFIG @"ALL APP CONFIG"
#define DANH_SACH_NAM_HOC @"DANH SACH NAM HOC"
#define DANH_SACH_HOC_KI @"DANH SÁCH HỌC KÌ"
#define DANH_SACH_LI_DO_NGHI_HOC @"DANH SÁCH LÍ DO NGHỈ HỌC"
#define DANH_SACH_MON_HOC_TU_LOP @"DANH SÁCH MÔN HỌC TỪ LỚP"
#define DANH_SACH_LOAI_HANH_KIEM @"DANH SÁCH LOẠI HẠNH KIỂM"

#define SETTING_REPORT @"ReportSetting"
#define SETTING_REPORT_SUBJECT_RESULT @"SubjectResult"
#define SETTING_REPORT_QUALITY_SCORE @"QualityScore"
#define SETTING_REPORT_PERSONAL_PROFILE @"PersonalProfile"

#define SETTING_PERSONALSCORE @"PersonalScoreSetting"
#define SETTING_PERSONALSCORE_PERSONAL_TRANSCRIPT @"PersonalTranscript"

