//
//  SalonManage.m
//  hairista
//
//  Created by Dong Vo on 4/10/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SalonManage.h"
#import "Salon.h"
#import "Image.h"
#import "SessionUser.h"
#import "Comment.h"
#import "Category.h"
#import "Service.h"
#import "Province.h"
#import "District.h"


static SalonManage *sharedInstance = nil;
@implementation SalonManage
+ (id)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil) {
            
            sharedInstance = [[SalonManage alloc] init];
        }
        return sharedInstance;
    }
    
}

#pragma mark - Parse

-(NSMutableArray *)parseListImageSalon:(NSDictionary *)responseDataObject{

    NSArray *data = [responseDataObject objectForKey:@"data"];
    
    NSMutableArray *arrImageSalon = nil;
    if(data){
        arrImageSalon = [NSMutableArray array];
        for(NSDictionary *dic in data){
        
            Image *img = [[Image alloc] init];
            img.idImage = CHECK_NIL([dic objectForKey:@"id"]);
            img.createdAt = CHECK_NIL([dic objectForKey:@"createdAt"]);
            img.forUserId = CHECK_NIL([dic objectForKey:@"forUserId"]);
            img.name = CHECK_NIL([dic objectForKey:@"name"]);
            img.path = CHECK_NIL([dic objectForKey:@"path"]);
            img.updatedAt = CHECK_NIL([dic objectForKey:@"updatedAt"]);
            img.url = CHECK_NIL([dic objectForKey:@"url"]);
            img.userId = CHECK_NIL([dic objectForKey:@"userId"]);
            img.accessMode = CHECK_NIL([dic objectForKey:@"accessMode"]);
            img.allowId = CHECK_NIL([dic objectForKey:@"allowId"]);
            img.index = -1;
            [arrImageSalon addObject:img];
            
        }
    }
    
    return arrImageSalon;
}

-(NSMutableArray *)parseListCommentSalon:(NSDictionary *)responseDataObject{
    
    NSArray *arrData = [responseDataObject objectForKey:@"data"];

    NSMutableArray *arrListSalons = nil;
    
    
    if(arrData){
    
        arrListSalons = [NSMutableArray array];
        
        for(NSDictionary *dic in arrData){
            
            Comment *comment = [[Comment alloc] init];
            comment.createdAt = CHECK_NIL([dic objectForKey:@"createdAt"]);
            comment.idComment = CHECK_NIL([dic objectForKey:@"id"]);
            comment.message = CHECK_NIL([dic objectForKey:@"message"]);
            comment.model = CHECK_NIL([dic objectForKey:@"model"]);
            comment.modelId = CHECK_NIL([dic objectForKey:@"modelId"]);
            comment.rate = CHECK_NIL([dic objectForKey:@"rate"]);
            comment.status = CHECK_NIL([dic objectForKey:@"status"]);
            comment.updatedAt = CHECK_NIL([dic objectForKey:@"updatedAt"]);
            NSDictionary *dicUser = CHECK_NIL([dic objectForKey:@"user"]);
           
            if(dicUser){
               
                comment.user = [[SessionUser alloc] init];
                comment.user.avatar = CHECK_NIL([dicUser objectForKey:@"avatar"]);
                comment.user.authToken = CHECK_NIL([dicUser objectForKey:@"authToken"]);
                comment.user.idUser = CHECK_NIL([dicUser objectForKey:@"id"]);
                comment.user.name = CHECK_NIL([dicUser objectForKey:@"name"]);
         
            }
           
            [arrListSalons addObject:comment];
        }
    }
    
    return arrListSalons;
}


-(NSMutableArray *)parseListSalons:(NSDictionary *)responseDataObject{

    NSArray *arrData = [responseDataObject objectForKey:@"data"];
    
    NSMutableArray *arrListSalons = nil;
    
    if(arrData){
    
        arrListSalons = [NSMutableArray array];
        
        for(NSDictionary *dic in arrData){
        
            Salon *salon = [[Salon alloc] init];
            salon.idSalon = CHECK_NIL([dic objectForKey:@"id"]);
            salon.name = CHECK_NIL([dic objectForKey:@"name"]);
            salon.name_slug = CHECK_NIL([dic objectForKey:@"name_slug"]) ;
            salon.avatarId = CHECK_NIL([dic objectForKey:@"avatarId"]);
            salon.wallpaperId = CHECK_NIL([dic objectForKey:@"wallpaperId"]);
            salon.email = CHECK_NIL([dic objectForKey:@"email"]);
            salon.phone = CHECK_NIL([dic objectForKey:@"phone"]);
            salon.status = CHECK_NIL([dic objectForKey:@"status"]);
            salon.phoneVerified = CHECK_NIL([dic objectForKey:@"phoneVerified"]);
            salon.homeAddress = CHECK_NIL([dic objectForKey:@"homeAddress"]);
            salon.lastAddress = CHECK_NIL([dic objectForKey:@"lastAddress"]);
            salon.inviteCode = CHECK_NIL([dic objectForKey:@"inviteCode"]);
            salon.provider = CHECK_NIL([dic objectForKey:@"provider"]);
            salon.providerId = CHECK_NIL([dic objectForKey:@"providerId"]);
            salon.provider_reponse = CHECK_NIL([dic objectForKey:@"provider_reponse"]);
            salon.invitedBy = CHECK_NIL([dic objectForKey:@"invitedBy"]);
            salon.authToken = CHECK_NIL([dic objectForKey:@"authToken"]);
            salon.lastLng = CHECK_NIL([dic objectForKey:@"lastLng"]);
            salon.lastLat = CHECK_NIL([dic objectForKey:@"lastLat"]);
            salon.isShowOnBoard = CHECK_NIL([dic objectForKey:@"isShowOnBoard"]);
            salon.birthday = CHECK_NIL([dic objectForKey:@"birthday"]);
            salon.city = CHECK_NIL([dic objectForKey:@"city"]);
            salon.district = CHECK_NIL([dic objectForKey:@"district"]);
            salon.about = CHECK_NIL([dic objectForKey:@"about"]);
            salon.avgRate = CHECK_NIL([dic objectForKey:@"avgRate"]);
            salon.totalComment = CHECK_NIL([dic objectForKey:@"totalComment"]);
            salon.totalRate = CHECK_NIL([dic objectForKey:@"totalRate"]);
            salon.totalPointRate = CHECK_NIL([dic objectForKey:@"totalPointRate"]);
            salon.role = CHECK_NIL([dic objectForKey:@"role"]);
            salon.isOnline = CHECK_NIL([dic objectForKey:@"isOnline"]);
            salon.createdAt = CHECK_NIL([dic objectForKey:@"createdAt"]);
            salon.updatedAt = CHECK_NIL([dic objectForKey:@"updatedAt"]);
            salon.avatar = CHECK_NIL([dic objectForKey:@"avatar"]);
            salon.wallpaper = CHECK_NIL([dic objectForKey:@"wallpaper"]);
            
             salon.openTime = CHECK_NIL([dic objectForKey:@"openTime"]);
             salon.closeTime = CHECK_NIL([dic objectForKey:@"closeTime"]);
            salon.districtId = CHECK_NIL([dic objectForKey:@"districtId"]);
            salon.provinceId = CHECK_NIL([dic objectForKey:@"provinceId"]);
            
            NSDictionary *dicProvince = [dic objectForKey:@"province"];
            
            if(![dicProvince isKindOfClass:[NSNull class]]){
            
                salon.provinceObject = [[Province alloc] init];
                
                salon.provinceObject.idProvince = CHECK_NIL([dicProvince objectForKey:@"id"]);
                salon.provinceObject.provinceName = CHECK_NIL([dicProvince objectForKey:@"name"]);
                salon.provinceObject.type = CHECK_NIL([dicProvince objectForKey:@"type"]);

            }
            
            NSDictionary *dicDistrict = [dic objectForKey:@"district"];
            
            if(![dicDistrict isKindOfClass:[NSNull class]]){
            
                salon.districtObject = [[District alloc] init];
                
                salon.districtObject.idDistrict = CHECK_NIL([dicDistrict objectForKey:@"id"]);
                salon.districtObject.idProvince = CHECK_NIL([dicDistrict objectForKey:@"provinceId"]);
                salon.districtObject.type = CHECK_NIL([dicDistrict objectForKey:@"type"]);
                salon.districtObject.location = CHECK_NIL([dicDistrict objectForKey:@"location"]);
                 salon.districtObject.name = CHECK_NIL([dicDistrict objectForKey:@"name"]);

            }
            
            [arrListSalons addObject:salon];
        }
    }
    
    return arrListSalons;
}

-(NSMutableArray *)parseListSalonsFavorite:(NSDictionary *)responseDataObject{
    
    NSArray *arrData = [responseDataObject objectForKey:@"data"];
    NSMutableArray *arrListSalons = nil;
    if(arrData.count > 0){
    
         arrListSalons = [NSMutableArray array];
    }
   
    for(NSDictionary *dic in arrData){
    
        NSDictionary *dicSalon = [dic objectForKey:@"user"];
       
        if(dicSalon){
        
            Salon *salon = [[Salon alloc] init];
            salon.idSalon = CHECK_NIL([dicSalon objectForKey:@"id"]);
            salon.avatar = CHECK_NIL([dicSalon objectForKey:@"avatar"]);
            salon.avgRate = CHECK_NIL([dicSalon objectForKey:@"avgRate"]);
            salon.openTime = CHECK_NIL([dicSalon objectForKey:@"openTime"]);
            salon.closeTime = CHECK_NIL([dicSalon objectForKey:@"closeTime"]);
            salon.email = CHECK_NIL([dicSalon objectForKey:@"email"]);
            salon.homeAddress = CHECK_NIL([dicSalon objectForKey:@"homeAddress"]);
            salon.name = CHECK_NIL([dicSalon objectForKey:@"name"]);
            salon.phone = CHECK_NIL([dicSalon objectForKey:@"phone"]);
            salon.lastLat = CHECK_NIL([dicSalon objectForKey:@"lastLat"]);
            salon.lastLng = CHECK_NIL([dicSalon objectForKey:@"lastLng"]);
            salon.totalComment = CHECK_NIL([dicSalon objectForKey:@"totalComment"]);
            
            
            [arrListSalons addObject:salon];
        }
      
    }
    
    return arrListSalons;
}

- (Image *)uploadUrlImageForSalon:(NSDictionary *)responseDataObject error:(NSError **)error{
    
    Image *img = [[Image alloc] init];
  
    img.idImage = CHECK_NIL([responseDataObject objectForKey:@"id"]);
    img.createdAt = CHECK_NIL([responseDataObject objectForKey:@"createdAt"]);
    img.forUserId = CHECK_NIL([responseDataObject objectForKey:@"forUserId"]);
    img.name = CHECK_NIL([responseDataObject objectForKey:@"name"]);
    img.path = CHECK_NIL([responseDataObject objectForKey:@"path"]);
    img.updatedAt = CHECK_NIL([responseDataObject objectForKey:@"updatedAt"]);
    img.url = CHECK_NIL([responseDataObject objectForKey:@"url"]);
    img.userId = CHECK_NIL([responseDataObject objectForKey:@"userId"]);
    
    return img;
}
-(Comment *)parsesendMessage:(NSDictionary *)responseDataObject{
    
    Comment *comment = [[Comment alloc] init];
    comment.createdAt =  CHECK_NIL([responseDataObject objectForKey:@"createdAt"]);
    comment.updatedAt =  CHECK_NIL([responseDataObject objectForKey:@"updatedAt"]);
    comment.idComment =  CHECK_NIL([responseDataObject objectForKey:@"id"]);
    comment.message =  CHECK_NIL([responseDataObject objectForKey:@"message"]);
    comment.rate =  CHECK_NIL([responseDataObject objectForKey:@"rate"]);

    return comment;
    
}

-(Category *)parseCategory:(NSDictionary *)responseDataObject{

    
    Category *cat = [[Category alloc] init];
    cat.createdAt = CHECK_NIL([responseDataObject objectForKey:@"createAt"]);
    cat.idCategory = CHECK_NIL([responseDataObject objectForKey:@"id"]);
    cat.updatedAt = CHECK_NIL([responseDataObject objectForKey:@"updatedAt"]);
    cat.name = CHECK_NIL([responseDataObject objectForKey:@"name"]);
    cat.userId = CHECK_NIL([responseDataObject objectForKey:@"userId"]);
    cat.name_slug = CHECK_NIL([responseDataObject objectForKey:@"name_slug"]);
    
    return cat;
}

- (NSMutableArray *)parseListService:(NSArray *)responseDataObject{
    
    NSMutableArray *arrData = [NSMutableArray array];
    
    for(NSDictionary *dic in responseDataObject){
    
        Category *cat = [[Category alloc] init];
        cat.idCategory = CHECK_NIL([dic objectForKey:@"id"]);
        cat.name = CHECK_NIL([dic objectForKey:@"name"]);
        cat.name_slug = CHECK_NIL([dic objectForKey:@"name_slug"]);
        cat.userId = CHECK_NIL([dic objectForKey:@"userId"]);
        cat.createdAt = CHECK_NIL([dic objectForKey:@"createdAt"]);
        cat.updatedAt = CHECK_NIL([dic objectForKey:@"updatedAt"]);
        cat.arrServices = [NSMutableArray array];
        NSArray *arrService = [dic objectForKey:@"services"];
        [arrData addObject:cat];
        for(NSDictionary *dicService in arrService){
        
            Service *service = [[Service alloc] init];
            service.idService = CHECK_NIL([dicService objectForKey:@"id"]);
            
            service.name = CHECK_NIL([dicService objectForKey:@"name"]);

            service.name_slug = CHECK_NIL([dicService objectForKey:@"name_slug"]);

            service.price = CHECK_NIL([dicService objectForKey:@"price"]);

            service.priceDiscount = CHECK_NIL([dicService objectForKey:@"priceDiscount"]);

            service.image = CHECK_NIL([dicService objectForKey:@"image"]);

            service.userId = CHECK_NIL([dicService objectForKey:@"userId"]);
            
            service.ordering = CHECK_NIL([dicService objectForKey:@"ordering"]);
            
            service.categoryId = CHECK_NIL([dicService objectForKey:@"categoryId"]);
            
            service.createdAt = CHECK_NIL([dicService objectForKey:@"createdAt"]);
            
            service.updatedAt = CHECK_NIL([dicService objectForKey:@"updatedAt"]);

            [cat.arrServices addObject:service];
        }
        
    }
    
    return arrData;
    
}

-(NSMutableArray *)parseListProvince:(NSArray *)responseDataObject{

    NSMutableArray *arrData = [NSMutableArray array];
    
    for(NSDictionary *dic in responseDataObject){
    
        Province *province = [[Province alloc] init];
        province.idProvince = CHECK_NIL([dic objectForKey:@"id"]);
        province.provinceName = CHECK_NIL([dic objectForKey:@"name"]);
        province.type = CHECK_NIL([dic objectForKey:@"type"]);
        
        [arrData addObject:province];
    }
    
    return arrData;

}

-(NSMutableArray *)parseListDistrict:(NSArray *)responseDataObject{
    
    NSMutableArray *arrData = [NSMutableArray array];
    
    for(NSDictionary *dic in responseDataObject){
        
        District *district = [[District alloc] init];
        district.idDistrict = CHECK_NIL([dic objectForKey:@"id"]);
         district.idProvince = CHECK_NIL([dic objectForKey:@"provinceId"]);
        district.name = CHECK_NIL([dic objectForKey:@"name"]);
        district.type = CHECK_NIL([dic objectForKey:@"type"]);
        district.location = CHECK_NIL([dic objectForKey:@"location"]);
        
        [arrData addObject:district];
    }
    
    return arrData;
    
}

//sendMessage

#pragma mark - Call API
//
//- (void)getDetailSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult{
//
//    
//     NSString *url = [NSString stringWithFormat:@"%@%@",URL_GET_DETAIL_SALON,idSalon];
//    
//    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
//        
//        if(isError){
//            
//            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorSalonDetail", nil)};
//            
//            NSError *error = [[NSError alloc]initWithDomain:@"ErrorSalonDetail" code:1 userInfo:userInfo];
//            dataApiResult(error, nil);
//        }
//        else{
//            
////            NSMutableArray *arrSalon = [self parseListSalons:responseDataObject];
////            
////            dataApiResult(nil, arrSalon);
//        }
//    }];
//
//    
//}

-(void)uploadUrlImageForSalon:(NSString *)imgUrl name:(NSString *)name idSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",URL_POST_URL_IMAGE,idSalon];
    
    NSDictionary *dicBody = @{@"images":imgUrl,@"name":name};
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_POST withRequestBody:dicBody callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorUploadUrlImageSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorUploadUrlImageSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSError *error = nil;
            Image *img = [self uploadUrlImageForSalon:responseDataObject error:&error];
            
            dataApiResult(error, img);
        }
    }];
    
}

-(void)getListImageSalon:(NSString *)idSalon page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@%@/image?page=%@&limit=%@&orderBy=ordering,asc",URL_GET_DETAIL_SALON,idSalon,page,limit];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorGetListSalonImages", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorGetListSalonImages" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrSalon = [self parseListImageSalon:responseDataObject];
            
            dataApiResult(nil, arrSalon);
        }
    }];
}

- (void)getListSalons:(BOOL)isShowOnBoard page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@?isShowOnBoard=%@&page=%@&limit=%@",URL_GET_LIST_SALON,(isShowOnBoard)?@"1":@"0",page,limit];
    
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorGetListSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorGetListSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrSalon = [self parseListSalons:responseDataObject];
            
            dataApiResult(nil, arrSalon);
        }
    }];

}
- (void)getListCommentSalon:(NSString *)idSalon page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@?page=%@&limit=%@",URL_GET_URL_COMMENT_SALON,idSalon,page,limit];
    
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorGetListCommentSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorGetListCommentSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrCommentSalon = [self parseListCommentSalon:responseDataObject];
            
            dataApiResult(nil, arrCommentSalon);
        }
    }];
    
}

-(void)sendMessage:(NSString *)idSalon message:(NSString *)message rate:(NSString *)rate dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@/%@",URL_POST_COMMENT_SALON,idSalon];
    
    
    NSDictionary *dicBody = @{@"message":message, @"rate":rate};
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_POST withRequestBody:dicBody callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorSendCommentSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorSendCommentSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            Comment *comment = [self parsesendMessage:responseDataObject];
            
            dataApiResult(nil, comment);
        }
    }];
}

-(void)getListCategoriesProduct:(DataAPIResult)dataApiResult{
    
    [APIRequestHandler initWithURLString:URL_GET_CATEGORIES_PRODUCT withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorCategoriesProduct", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorCategoriesProduct" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
           NSArray *arrData = [self parseListService:responseDataObject];
            
            dataApiResult(nil, arrData);
            
        }
    }];

}

-(void)calFavourite:(NSString *)idSalon dataApiResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@%@",URL_POST_FAVOURTIE,idSalon];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_POST withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorFavoriteSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorFavoriteSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            dataApiResult(nil, @"OK");
            
        }
    }];

}
-(void)getListFavoriteSalon:(NSString *)indexPage limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@?page=%@&limit=%@",URL_GET_LIST_FAVOURTIE,indexPage,limit];

    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorListFavoriteSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorListFavoriteSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrData = [self parseListSalonsFavorite:responseDataObject];
            
            dataApiResult(nil, arrData);
            
        }
    }];
}

-(void)deleteFavorite:(NSString *)idSalon dataApiResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@%@/delete",URL_DELETE_FAVORITE,idSalon];
    
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_DELETE withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorDeleteFavorite", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorDeleteFavorite" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            dataApiResult(nil, @"OK");
            
        }
    }];
}
-(void)favorite:(NSString *)idSalon dataApiResult:(DataAPIResult)dataApiResult{
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_FAVORITE,idSalon];
    
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_POST withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorFavorite", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorFavorite" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            dataApiResult(nil, @"OK");
            
        }
    }];
}

#pragma mark - Province, District
-(void)getListProvince:(DataAPIResult)dataApiResult{

    [APIRequestHandler initWithURLString:URL_GET_LIST_PROVINCE withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorListProvince", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorListProvince" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrData = [self parseListProvince:responseDataObject];
            
            dataApiResult(nil, arrData);
            
        }
    }];

}
-(void)getListDistrict:(NSString *)idProvince dataApiResult:(DataAPIResult)dataApiResult{

    NSString *urlDistrict = [NSString stringWithFormat:@"%@%@",URL_GET_LIST_DISTRICT,idProvince];
    
    
    [APIRequestHandler initWithURLString:urlDistrict withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorListDistrict", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorListDistrict" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrData = [self parseListDistrict:responseDataObject];
            
            dataApiResult(nil, arrData);
            
        }
    }];

}

-(void)getListSalonNearBy:(NSString *)lateitude longLocation:(NSString *)longitude pageindex:(NSString *)pageIndex limit:(NSString *)limit provinceid:(NSString *)provinceID district:(NSString *)districtID name:(NSString *)name dataApiResult:(DataAPIResult)dataApiResult{

    NSMutableString *strUrl = [NSMutableString stringWithFormat:@"%@?page=%@&limit=%@",URL_GET_LIST_SALON_NEARBY,pageIndex,limit];
    
    if(lateitude.length > 0){
    
        [strUrl appendFormat:@"&lat=%@",lateitude];
    }
    
    if(longitude.length > 0){
    
        [strUrl appendFormat:@"&lng=%@",longitude];
    }
    
    if(provinceID.length > 0){
    
        [strUrl appendFormat:@"&provinceId=%@",provinceID];
    }
    
    if(districtID.length > 0){
    
        [strUrl appendFormat:@"&districtId=%@",districtID];
    }
    
    if(name.length > 0){
    
        [strUrl appendFormat:@"&name=%@",name];
    }
    
    
    
    [APIRequestHandler initWithURLString:strUrl withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorListNearby", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorListNearby" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrData = [self parseListSalons:responseDataObject];
            
            dataApiResult(nil, arrData);
            
        }
    }];
  //  NSString *url = [NSString stringWithFormat:@"%@?lat=%@&lng=%@&"]

}

-(void)updateMultiIndexImage:(NSDictionary *)dicListImage dataApiResult:(DataAPIResult)dataApiResult{

    [APIRequestHandler initWithURLString:URL_PUT_MULTI_IMAGE withHttpMethod:kHTTP_METHOD_PUT withRequestBody:dicListImage callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorUploadMultiImage", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorUploadMultiImage" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            dataApiResult(nil, @"OK");
            
        }
    }];
}

-(void)getListSalonUpdateImage:(DataAPIResult)dataApiResult{

    [APIRequestHandler initWithURLString:URL_GET_SALON_IMAGE_UPLOADED withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorSalonUpdateImage", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorSalonUpdateImage" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            dataApiResult(nil, @"OK");
            
        }
    }];
}
-(void)getListServiceBySalonID:(NSString *)salonID dataApiResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@%@/categories",URL_GET_LIST_SERVICE_BY_SALONID,salonID];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorServiceBySalonID", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorServiceBySalonID" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSArray *arrData = [self parseListService:responseDataObject];
            
            dataApiResult(nil, arrData);
            
        }
    }];

}

-(void)createCategory:(NSString *)catName dataApiResult:(DataAPIResult)dataApiResult{

    //{{url}}categories
    
    NSDictionary *dic = @{@"name":catName};
    
    [APIRequestHandler initWithURLString:URL_POST_CREATE_CATEGORY withHttpMethod:kHTTP_METHOD_POST withRequestBody:dic callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorCreateCategory", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorCreateCategory" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            Category *cat = [self parseCategory:responseDataObject];
            
            dataApiResult(nil, cat);
            
        }
    }];

}

-(void)updateCategory:(NSString *)idCat nameCat:(NSString *)catName dataApiResult:(DataAPIResult)dataApiResult{

    NSDictionary *dic = @{@"name":catName};
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_PUT_UPDATE_CATEGORY,idCat];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_PUT withRequestBody:dic callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorUpdateCategory", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorUpdateCategory" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            Category *cat = [self parseCategory:responseDataObject];
            
            dataApiResult(nil, cat);
            
        }
    }];
}

-(void)updateService:(NSString *)idCate service:(Service *)service dataApiResult:(DataAPIResult)dataApiResult{

    NSDictionary *dic = @{@"name":service.name, @"image":service.image, @"price":service.price.stringValue, @"categoryId":idCate};
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_PUT_UPDATE_SERVICE,service.idService];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_PUT withRequestBody:dic callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorUpdateService", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorUpdateService" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            dataApiResult(nil, @"OK");
            
            //Category *cat = [self parseCategory:responseDataObject];
            
            // dataApiResult(nil, cat);
            
        }
    }];
}

-(void)getListServiceByCategoryID:(NSString *)categoryID dataApiResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@%@/product",URL_GET_SERICE_BY_CATEGORYID,categoryID];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorServicesByCategoryID", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorServicesByCategoryID" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            Category *cat = [self parseCategory:responseDataObject];
            
            dataApiResult(nil, cat);
            
        }
    }];

}

-(void)createServiceByIdCat:(NSString *)idCate service:(Service *)service dataApiResult:(DataAPIResult)dataApiResult{
    
    NSDictionary *dic = @{@"name":service.name, @"image":service.image, @"price":service.price.stringValue, @"categoryId":idCate};
    
    [APIRequestHandler initWithURLString:URL_POST_CREATE_SERVICE withHttpMethod:kHTTP_METHOD_POST withRequestBody:dic callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorCreateService", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorCreateService" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
             dataApiResult(nil, @"OK");
            
            //Category *cat = [self parseCategory:responseDataObject];
            
           // dataApiResult(nil, cat);
            
        }
    }];
}

-(void)deleteImage:(NSString *)idImage dataApiResult:(DataAPIResult)dataApiResult{

    NSDictionary *dic = @{@"phone":Appdelegate_hairista.sessionUser.phone};
    
    NSString *url = [NSString stringWithFormat:@"%@%@",URL_DELETE_IMAGE,idImage];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_DELETE withRequestBody:dic callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorDeleteImage", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorDeleteImage" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            dataApiResult(nil, @"OK");
            
        }
    }];
}
@end
