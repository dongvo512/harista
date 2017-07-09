//
//  BookingManage.m
//  hairista
//
//  Created by Dong Vo on 5/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "BookingManage.h"
#import "Booking.h"
#import "Salon.h"
#import "SessionUser.h"
#import "Service.h"

static BookingManage *sharedInstance = nil;
@implementation BookingManage

+ (id)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil) {
            
            sharedInstance = [[BookingManage alloc] init];
        }
        return sharedInstance;
    }
    
}

#pragma mark - Parse

-(NSMutableArray *)parseBooking:(NSDictionary *)responseDataObject{

    NSArray *arrData = [responseDataObject objectForKey:@"data"];
    NSMutableArray *arrBooking = [NSMutableArray array];
    
    for(NSDictionary *dic in arrData){

        Booking *booking = [[Booking alloc] init];
        booking.createdAt = CHECK_NIL([dic objectForKey:@"createdAt"]);
        booking.discount = CHECK_NIL([dic objectForKey:@"discount"]);
        booking.idBooking = CHECK_NIL([dic objectForKey:@"id"]);
        booking.name = CHECK_NIL([dic objectForKey:@"name"]);
        booking.name_slug = CHECK_NIL([dic objectForKey:@"name_slug"]);
        booking.price = CHECK_NIL([dic objectForKey:@"price"]);
        booking.salonId = CHECK_NIL([dic objectForKey:@"salonId"]);
        booking.startDate = CHECK_NIL([dic objectForKey:@"startDate"]);
        booking.status = CHECK_NIL([dic objectForKey:@"status"]);
        booking.totalPrice = CHECK_NIL([dic objectForKey:@"totalPrice"]);
        booking.updatedAt = CHECK_NIL([dic objectForKey:@"updatedAt"]);
        booking.userId = CHECK_NIL([dic objectForKey:@"userId"]);
        
        NSDictionary *dicSalon = [dic objectForKey:@"salon"];
        
        if(dicSalon){
        
            Salon *salon = [[Salon alloc] init];
            booking.salon = salon;
            salon.idSalon = CHECK_NIL([dicSalon objectForKey:@"id"]);
            salon.name = CHECK_NIL([dicSalon objectForKey:@"name"]);
            salon.name_slug = CHECK_NIL([dicSalon objectForKey:@"name_slug"]) ;
            salon.avatarId = CHECK_NIL([dicSalon objectForKey:@"avatarId"]);
            salon.wallpaperId = CHECK_NIL([dicSalon objectForKey:@"wallpaperId"]);
            salon.email = CHECK_NIL([dicSalon objectForKey:@"email"]);
            salon.phone = CHECK_NIL([dicSalon objectForKey:@"phone"]);
            salon.status = CHECK_NIL([dicSalon objectForKey:@"status"]);
            salon.phoneVerified = CHECK_NIL([dicSalon objectForKey:@"phoneVerified"]);
            salon.homeAddress = CHECK_NIL([dicSalon objectForKey:@"homeAddress"]);
            salon.lastAddress = CHECK_NIL([dicSalon objectForKey:@"lastAddress"]);
            salon.inviteCode = CHECK_NIL([dicSalon objectForKey:@"inviteCode"]);
            salon.provider = CHECK_NIL([dicSalon objectForKey:@"provider"]);
            salon.providerId = CHECK_NIL([dicSalon objectForKey:@"providerId"]);
            salon.provider_reponse = CHECK_NIL([dicSalon objectForKey:@"provider_reponse"]);
            salon.invitedBy = CHECK_NIL([dicSalon objectForKey:@"invitedBy"]);
            salon.authToken = CHECK_NIL([dicSalon objectForKey:@"authToken"]);
            salon.lastLng = CHECK_NIL([dicSalon objectForKey:@"lastLng"]);
            salon.lastLat = CHECK_NIL([dicSalon objectForKey:@"lastLat"]);
            salon.isShowOnBoard = CHECK_NIL([dicSalon objectForKey:@"isShowOnBoard"]);
            salon.birthday = CHECK_NIL([dicSalon objectForKey:@"birthday"]);
            salon.city = CHECK_NIL([dicSalon objectForKey:@"city"]);
            salon.district = CHECK_NIL([dicSalon objectForKey:@"district"]);
            salon.about = CHECK_NIL([dicSalon objectForKey:@"about"]);
            salon.avgRate = CHECK_NIL([dicSalon objectForKey:@"avgRate"]);
            salon.totalComment = CHECK_NIL([dicSalon objectForKey:@"totalComment"]);
            salon.totalRate = CHECK_NIL([dicSalon objectForKey:@"totalRate"]);
            salon.totalPointRate = CHECK_NIL([dicSalon objectForKey:@"totalPointRate"]);
            salon.role = CHECK_NIL([dicSalon objectForKey:@"role"]);
            salon.isOnline = CHECK_NIL([dicSalon objectForKey:@"isOnline"]);
            salon.createdAt = CHECK_NIL([dicSalon objectForKey:@"createdAt"]);
            salon.updatedAt = CHECK_NIL([dicSalon objectForKey:@"updatedAt"]);
            salon.avatar = CHECK_NIL([dicSalon objectForKey:@"avatar"]);
            salon.wallpaper = CHECK_NIL([dicSalon objectForKey:@"wallpaper"]);
            
            salon.openTime = CHECK_NIL([dicSalon objectForKey:@"openTime"]);
            salon.closeTime = CHECK_NIL([dicSalon objectForKey:@"closeTime"]);
            salon.districtId = CHECK_NIL([dicSalon objectForKey:@"districtId"]);
            salon.provinceId = CHECK_NIL([dicSalon objectForKey:@"provinceId"]);
            
            NSDictionary *dicProvince = [dicSalon objectForKey:@"province"];
            
            if(![dicProvince isKindOfClass:[NSNull class]]){
                
                salon.provinceObject = [[Province alloc] init];
                
                salon.provinceObject.idProvince = CHECK_NIL([dicProvince objectForKey:@"id"]);
                salon.provinceObject.provinceName = CHECK_NIL([dicProvince objectForKey:@"name"]);
                salon.provinceObject.type = CHECK_NIL([dicProvince objectForKey:@"type"]);
                
            }
            
            NSDictionary *dicDistrict = [dicSalon objectForKey:@"district"];
            
            if(![dicDistrict isKindOfClass:[NSNull class]]){
                
                salon.districtObject = [[District alloc] init];
                
                salon.districtObject.idDistrict = CHECK_NIL([dicDistrict objectForKey:@"id"]);
                salon.districtObject.idProvince = CHECK_NIL([dicDistrict objectForKey:@"provinceId"]);
                salon.districtObject.type = CHECK_NIL([dicDistrict objectForKey:@"type"]);
                salon.districtObject.location = CHECK_NIL([dicDistrict objectForKey:@"location"]);
                salon.districtObject.name = CHECK_NIL([dicDistrict objectForKey:@"name"]);
                
            }
        }
        
        NSDictionary *dicUser = [dic objectForKey:@"user"];
        
        if(dicUser){
        
            SessionUser *user = [[SessionUser alloc] init];
            booking.user = user;
            user.idUser = CHECK_NIL([dicUser objectForKey:@"id"]);
            user.name = CHECK_NIL([dicUser objectForKey:@"name"]);
            user.name_slug = CHECK_NIL([dicUser objectForKey:@"name_slug"]) ;
            user.avatarId = CHECK_NIL([dicUser objectForKey:@"avatarId"]);
            user.wallpaperId = CHECK_NIL([dicUser objectForKey:@"wallpaperId"]);
            user.email = CHECK_NIL([dicUser objectForKey:@"email"]);
            user.phone = CHECK_NIL([dicUser objectForKey:@"phone"]);
            user.status = CHECK_NIL([dicUser objectForKey:@"status"]);
            user.phoneVerified = CHECK_NIL([dicUser objectForKey:@"phoneVerified"]);
            user.homeAddress = CHECK_NIL([dicUser objectForKey:@"homeAddress"]);
            user.lastAddress = CHECK_NIL([dicUser objectForKey:@"lastAddress"]);
            user.inviteCode = CHECK_NIL([dicUser objectForKey:@"inviteCode"]);
            user.provider = CHECK_NIL([dicUser objectForKey:@"provider"]);
            user.providerId = CHECK_NIL([dicUser objectForKey:@"providerId"]);
            user.provider_reponse = CHECK_NIL([dicUser objectForKey:@"provider_reponse"]);
            user.invitedBy = CHECK_NIL([dicUser objectForKey:@"invitedBy"]);
            user.authToken = CHECK_NIL([dicUser objectForKey:@"authToken"]);
            user.lastLng = CHECK_NIL([dicUser objectForKey:@"lastLng"]);
            user.lastLat = CHECK_NIL([dicUser objectForKey:@"lastLat"]);
            user.birthday = CHECK_NIL([dicUser objectForKey:@"birthday"]);
            user.city = CHECK_NIL([dicUser objectForKey:@"city"]);
            user.district = CHECK_NIL([dicUser objectForKey:@"district"]);
            user.about = CHECK_NIL([dicUser objectForKey:@"about"]);
            user.avgRate = CHECK_NIL([dicUser objectForKey:@"avgRate"]);
            user.totalComment = CHECK_NIL([dicUser objectForKey:@"totalComment"]);
            user.totalRate = CHECK_NIL([dicUser objectForKey:@"totalRate"]);
            user.totalPointRate = CHECK_NIL([dicUser objectForKey:@"totalPointRate"]);
            user.role = CHECK_NIL([dicUser objectForKey:@"role"]);
            user.isOnline = CHECK_NIL([dicUser objectForKey:@"isOnline"]);
            user.createdAt = CHECK_NIL([dicUser objectForKey:@"createdAt"]);
            user.updatedAt = CHECK_NIL([dicUser objectForKey:@"updatedAt"]);
            user.avatar = CHECK_NIL([dicUser objectForKey:@"avatar"]);
            user.wallpaper = CHECK_NIL([dicUser objectForKey:@"wallpaper"]);
            
        }
        
        [arrBooking addObject:booking];
    }
    
    return arrBooking;
}

-(NSMutableArray *)parseListServiceFromBooking:(NSDictionary *)responseDataObject{

    NSArray *arrData = [responseDataObject objectForKey:@"data"];
    NSMutableArray *arrSerice = [NSMutableArray array];
    
    for(NSDictionary *dic in arrData){
        
        NSDictionary *dicService = [dic objectForKey:@"service"];
        
        if(dicService){
        
            Service *service = [[Service alloc] init];
            service.idBookingDetail = CHECK_NIL([dic objectForKey:@"id"]);
            service.status = CHECK_NIL([dic objectForKey:@"status"]);
            service.categoryId = CHECK_NIL([dicService objectForKey:@"categoryId"]);
            service.createdAt = CHECK_NIL([dicService objectForKey:@"createdAt"]);
            service.idService = CHECK_NIL([dicService objectForKey:@"id"]);
            service.image = CHECK_NIL([dicService objectForKey:@"image"]);
            service.name = CHECK_NIL([dicService objectForKey:@"name"]);
            service.name_slug = CHECK_NIL([dicService objectForKey:@"name_slug"]);
            service.ordering = CHECK_NIL([dicService objectForKey:@"ordering"]);
            service.price = CHECK_NIL([dicService objectForKey:@"price"]);
            service.priceDiscount = CHECK_NIL([dicService objectForKey:@"priceDiscount"]);
            service.updatedAt = CHECK_NIL([dicService objectForKey:@"updatedAt"]);
            
            [arrSerice addObject:service];
        }
    }

    return arrSerice;
}

#pragma mark - Call Api
-(void)createBooking:(NSDictionary *)dicBody idSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult {

    NSString *url = [NSString stringWithFormat:@"%@%@/booking",URL_POST_CREATE_BOOKING,idSalon];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_POST withRequestBody:dicBody callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorCreateBooking", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorCreateBooking" code:1 userInfo:userInfo];
            dataApiResult(error, nil, stringError);
        }
        else{
            
            dataApiResult(nil, @"OK", stringError);
        }
    }];
    
}

-(void)getListBookingOfSalon:(NSString *)indexPage limit:(NSString *)limit startDate:(NSString *)startDate endDate:(NSString *)endDate dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@?limit=%@&page=%@&startDate=%@&endDate=%@",URL_GET_LIST_BOOKING_OF_SALON,limit,indexPage,startDate,endDate];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorBookingOfSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorBookingOfSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil, stringError);
        }
        else{
            
            NSMutableArray *arrData = [self parseBooking:responseDataObject];
            
            dataApiResult(nil, arrData, stringError);
        }
    }];

}

-(void)getListBookingOfUser:(NSString *)idUser indexPage:(NSString *)indexPage limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@%@/booking?limit=%@&page=%@",URL_GET_LIST_BOOKING_OF_USER,idUser,limit,indexPage];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorBookingOfUser", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorBookingOfUser" code:1 userInfo:userInfo];
            dataApiResult(error, nil, stringError);
        }
        else{
            
            NSMutableArray *arrData = [self parseBooking:responseDataObject];
            
            dataApiResult(nil, arrData, stringError);
        }
    }];
}

-(void)getListBookingOfMe:(NSString *)indexPage limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{

        NSString *url = [NSString stringWithFormat:@"%@?limit=%@&page=%@",URL_GET_LIST_BOOKING_OF_ME,limit,indexPage];
    
        [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
    
            if(isError){
    
                NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorBookingOfMe", nil)};
    
                NSError *error = [[NSError alloc]initWithDomain:@"ErrorBookingOfMe" code:1 userInfo:userInfo];
                dataApiResult(error, nil, stringError);
            }
            else{
    
                NSMutableArray *arrData = [self parseBooking:responseDataObject];
    
                dataApiResult(nil, arrData, stringError);
            }
        }];

}


-(void)getDetailBooking:(NSString *)idBooking dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@%@",URL_GET_DETAIL_BOOKING,idBooking];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorDetailBooking", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorDetailBooking" code:1 userInfo:userInfo];
            dataApiResult(error, nil, stringError);
        }
        else{
            
            NSMutableArray *arrData = [self parseListServiceFromBooking:responseDataObject];
            
            dataApiResult(nil, arrData, stringError);
        }
    }];

}

-(void)updateBooking:(NSString *)idBooking status:(NSString *)status dataResult:(DataAPIResult)dataApiResult{

    
   // NSDictionary *dic = @{@"name":booking.name, @"price":booking.price, @"totalPrice":booking.totalPrice, @"startDate":booking.startDate};
    
    NSString *url = [NSString stringWithFormat:@"%@%@/%@",URL_PUT_UPDATE_BOOKING,idBooking,status];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_PUT withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorUpdateBooking", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorUpdateBooking" code:1 userInfo:userInfo];
            dataApiResult(error, nil, stringError);
        }
        else{
            
          //  NSMutableArray *arrData = [self parseListServiceFromBooking:responseDataObject];
            
            dataApiResult(nil, @"OK", stringError);
        }
    }];
}
-(void)deleteBookingDetailByBookingID:(NSString *)idBooking idBookingDetail:(NSString *)idBookingDetail dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@%@/detail/%@/delete",URL_PUT_UPDATE_BOOKING,idBooking,idBookingDetail];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_PUT withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorDeleteBookingDetail", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorDeleteBookingDetail" code:1 userInfo:userInfo];
            dataApiResult(error, nil, stringError);
        }
        else{
            
            //  NSMutableArray *arrData = [self parseListServiceFromBooking:responseDataObject];
            
            dataApiResult(nil, @"OK", stringError);
        }
    }];
}

-(void)insertServiceForBookingOfUser:(NSString *)idBooking dicbody:(NSDictionary *)dic
                          dataResult:(DataAPIResult)dataApiResult{

     NSString *url = [NSString stringWithFormat:@"%@%@/addMore",URL_PUT_UPDATE_BOOKING,idBooking];
   
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_PUT withRequestBody:dic callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorInsertBookingDetail", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorInsertBookingDetail" code:1 userInfo:userInfo];
            dataApiResult(error, nil, stringError);
        }
        else{
            
            //  NSMutableArray *arrData = [self parseListServiceFromBooking:responseDataObject];
            
            dataApiResult(nil, @"OK", stringError);
        }
    }];
}
@end
