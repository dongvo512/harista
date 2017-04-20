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
            
             salon.wallpaper = CHECK_NIL([dic objectForKey:@"openTime"]);
             salon.wallpaper = CHECK_NIL([dic objectForKey:@"closeTime"]);
            
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
#pragma mark - Call API

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

-(void)uploadUrlImageForSalon:(NSString *)imgUrl idSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult{
    
    NSString *url = [NSString stringWithFormat:@"%@/%@",URL_POST_URL_IMAGE,idSalon];
    
    NSDictionary *dicBody = @{@"images":imgUrl};
    
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

    NSString *url = [NSString stringWithFormat:@"%@%@/image?page=%@&limit=%@",URL_GET_DETAIL_SALON,idSalon,page,limit];
    
    
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
@end
