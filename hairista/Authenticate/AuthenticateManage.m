//
//  AuthenticateManage.m
//  hairista
//
//  Created by Dong Vo on 4/5/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "AuthenticateManage.h"
#import "SessionUser.h"
#import "Image.h"

static AuthenticateManage *sharedInstance = nil;

@implementation AuthenticateManage
+ (id)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil) {
            
            sharedInstance = [[AuthenticateManage alloc] init];
        }
        return sharedInstance;
    }
    
}

#pragma mark - Parse

- (NSMutableArray *)parseListUserSearch:(NSDictionary *)responseDataObject{

     NSArray *array = [responseDataObject objectForKey:@"data"];
    
    NSMutableArray *arrUser = [NSMutableArray array];
    
    for(NSDictionary *dic in array){
    
        SessionUser *user = [[SessionUser alloc] init];
        user.totalRate = CHECK_NIL([dic objectForKey:@"totalRate"]);
        user.isOnline = CHECK_NIL([dic objectForKey:@"isOnline"]);
        user.updatedAt = CHECK_NIL([dic objectForKey:@"updatedAt"]);
        user.idUser = CHECK_NIL([dic objectForKey:@"id"]);
        user.email = CHECK_NIL([dic objectForKey:@"email"]);
        user.name = CHECK_NIL([dic objectForKey:@"name"]);
        user.homeAddress = CHECK_NIL([dic objectForKey:@"homeAddress"]);
        user.avatar = CHECK_NIL([dic objectForKey:@"avatar"]);
        user.phone = CHECK_NIL([dic objectForKey:@"phone"]);
        
        [arrUser addObject:user];
    }
    
    return arrUser;
}

- (NSString *)parseuploadUrlImage:(NSDictionary *)responseDataObject error:(NSError **)error{
    
    NSString *strImgUrl = @"";
    
   strImgUrl = CHECK_NIL([responseDataObject objectForKey:@"id"]);

    return strImgUrl;
}

- (void)parseUpdateUserInfo:(NSDictionary *)responseDataObject{
    
    if(Appdelegate_hairista.sessionUser){
   
        Appdelegate_hairista.sessionUser.name = CHECK_NIL([responseDataObject objectForKey:@"name"]);
        
        Appdelegate_hairista.sessionUser.homeAddress = CHECK_NIL([responseDataObject objectForKey:@"homeAddress"]);
    
        Appdelegate_hairista.sessionUser.email = CHECK_NIL([responseDataObject objectForKey:@"email"]);
       
        Appdelegate_hairista.sessionUser.avatar = CHECK_NIL([responseDataObject objectForKey:@"avatar"]);
    }
}

- (SessionUser *)parseIntroductionScreen:(NSDictionary *)responseDataObject{
    
    NSDictionary *dic = [responseDataObject objectForKey:@"profile"];
    
    Appdelegate_hairista.sessionUser = [[SessionUser alloc] init];
  
    Appdelegate_hairista.sessionUser.token = CHECK_NIL([responseDataObject objectForKey:@"token"]) ;
    
    Appdelegate_hairista.sessionUser.idUser = CHECK_NIL([dic objectForKey:@"id"]);
    
     Appdelegate_hairista.sessionUser.name = CHECK_NIL([dic objectForKey:@"name"]);
    
     Appdelegate_hairista.sessionUser.name_slug = CHECK_NIL([dic objectForKey:@"name_slug"]);
    
     Appdelegate_hairista.sessionUser.avatarId = CHECK_NIL([dic objectForKey:@"avatarId"]);
    
     Appdelegate_hairista.sessionUser.wallpaperId = CHECK_NIL([dic objectForKey:@"wallpaperId"]);
    
     Appdelegate_hairista.sessionUser.email = CHECK_NIL([dic objectForKey:@"email"]);
    
     Appdelegate_hairista.sessionUser.phone = CHECK_NIL([dic objectForKey:@"phone"]);
    
     Appdelegate_hairista.sessionUser.status = CHECK_NIL([dic objectForKey:@"status"]);
    
     Appdelegate_hairista.sessionUser.phoneVerified = CHECK_NIL([dic objectForKey:@"phoneVerified"]);
    
     Appdelegate_hairista.sessionUser.homeAddress = CHECK_NIL([dic objectForKey:@"homeAddress"]);
    
     Appdelegate_hairista.sessionUser.lastAddress = CHECK_NIL([dic objectForKey:@"lastAddress"]);
    
     Appdelegate_hairista.sessionUser.inviteCode = CHECK_NIL([dic objectForKey:@"inviteCode"]);
    
     Appdelegate_hairista.sessionUser.provider = CHECK_NIL([dic objectForKey:@"provider"]);
    
     Appdelegate_hairista.sessionUser.providerId = CHECK_NIL([dic objectForKey:@"providerId"]);
    
     Appdelegate_hairista.sessionUser.provider_reponse = CHECK_NIL([dic objectForKey:@"provider_reponse"]);
    
     Appdelegate_hairista.sessionUser.invitedBy = CHECK_NIL([dic objectForKey:@"invitedBy"]);
    
     Appdelegate_hairista.sessionUser.authToken = CHECK_NIL([dic objectForKey:@"authToken"]);
    
     Appdelegate_hairista.sessionUser.lastLat = CHECK_NIL([dic objectForKey:@"lastLat"]);
    
     Appdelegate_hairista.sessionUser.lastLng = CHECK_NIL([dic objectForKey:@"lastLng"]);
    
    Appdelegate_hairista.sessionUser.birthday = CHECK_NIL([dic objectForKey:@"birthday"]);
    
    Appdelegate_hairista.sessionUser.city = CHECK_NIL([dic objectForKey:@"city"]);
    
    Appdelegate_hairista.sessionUser.district = CHECK_NIL([dic objectForKey:@"district"]);
    
    Appdelegate_hairista.sessionUser.about = CHECK_NIL([dic objectForKey:@"about"]);
    
    Appdelegate_hairista.sessionUser.avgRate = CHECK_NIL([dic objectForKey:@"avgRate"]);
    Appdelegate_hairista.sessionUser.totalComment = CHECK_NIL([dic objectForKey:@"totalComment"]);
    
    Appdelegate_hairista.sessionUser.totalRate = CHECK_NIL([dic objectForKey:@"totalRate"]);
    
    Appdelegate_hairista.sessionUser.totalPointRate = CHECK_NIL([dic objectForKey:@"totalPointRate"]);
    
    Appdelegate_hairista.sessionUser.role = CHECK_NIL([dic objectForKey:@"role"]);
    
    Appdelegate_hairista.sessionUser.isOnline = CHECK_NIL([dic objectForKey:@"isOnline"]);
    
    Appdelegate_hairista.sessionUser.createdAt = CHECK_NIL([dic objectForKey:@"createdAt"]);
    
    Appdelegate_hairista.sessionUser.updatedAt = CHECK_NIL([dic objectForKey:@"updatedAt"]);
    
    Appdelegate_hairista.sessionUser.avatar = CHECK_NIL([dic objectForKey:@"avatar"]);
    
    Appdelegate_hairista.sessionUser.wallpaper = CHECK_NIL([dic objectForKey:@"wallpaper"]);
    
    return Appdelegate_hairista.sessionUser;
    
}

- (NSMutableArray *)parseListImageUser:(NSDictionary *)responseDataObject{
    
    NSArray *arrDic = [responseDataObject objectForKey:@"data"];
    
    NSMutableArray *arrData = [NSMutableArray array];
    
    for(NSDictionary *dic in arrDic){
    
        Image *img = [[Image alloc] init];
        
        img.idImage = CHECK_NIL([dic objectForKey:@"id"]);
        img.createdAt = CHECK_NIL([dic objectForKey:@"createdAt"]);
        img.forUserId = CHECK_NIL([dic objectForKey:@"forUserId"]);
        img.name = CHECK_NIL([dic objectForKey:@"name"]);
        img.path = CHECK_NIL([dic objectForKey:@"path"]);
        img.updatedAt = CHECK_NIL([dic objectForKey:@"updatedAt"]);
        img.url = CHECK_NIL([dic objectForKey:@"url"]);
        img.userId = CHECK_NIL([dic objectForKey:@"userId"]);
        [arrData addObject:img];
    }

    return arrData;
}

#pragma mark - CallAPI

-(void)uploadUrlImage:(NSString *)imgUrl dataResult:(DataAPIResult)dataApiResult{

    NSDictionary *dicBody = @{@"images":imgUrl};
    
    [APIRequestHandler initWithURLString:URL_POST_URL_IMAGE withHttpMethod:kHTTP_METHOD_POST withRequestBody:dicBody callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorUploadUrlImage", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorUploadUrlImage" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSError *error = nil;
            NSString *idImage = [self parseuploadUrlImage:responseDataObject error:&error];
            
            dataApiResult(error, idImage);
        }
    }];


}

- (void)registerUser:(NSString *)phone password:(NSString *)password passwordConfirm:(NSString *)passwordConfirm dataResult:(DataAPIResult)dataApiResult{

    NSDictionary *dicBody = @{@"phone":phone, @"password":password, @"password_confirmation":passwordConfirm};
    
    [APIRequestHandler initWithURLString:URL_POST_REGISTER withHttpMethod:kHTTP_METHOD_POST withRequestBody:dicBody callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
        
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorRegister", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorRegister" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
        
            dataApiResult(nil, @"OK");
        }
    }];
    
}


- (void)updateUserInfo:(NSDictionary *)dicBody dataResult:(DataAPIResult)dataApiResult{

    [APIRequestHandler initWithURLString:URL_PUT_UPDATE_USER_INFO withHttpMethod:kHTTP_METHOD_PUT withRequestBody:dicBody callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorUpdateUser", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorUpdateUser" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            [self parseUpdateUserInfo:responseDataObject];
            dataApiResult(nil, @"OK");
        }
    }];

}

- (void)login:(NSString *)phone password:(NSString *)password dataResult:(DataAPIResult)dataApiResult{
    
    NSDictionary *dicBody = @{@"phone":phone, @"password":password, @"deviceToken":Appdelegate_hairista.deviceToken,@"deviceType":@"ios"};
    
    [APIRequestHandler initWithURLString:URL_POST_LOGIN withHttpMethod:kHTTP_METHOD_POST withRequestBody:dicBody callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorLogin", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorLogin" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
             SessionUser *user = [self parseIntroductionScreen:responseDataObject];
            
            dataApiResult(nil, user);
        }
    }];
    
}

- (void)changePassword:(NSString *)password confirmPassword:(NSString *)confirmPassword dataResult:(DataAPIResult)dataApiResult{

    NSDictionary *dicBody = @{@"password":password, @"password_confirmation":confirmPassword};
    
    [APIRequestHandler initWithURLString:URL_PUT_CHANGE_PASSWORD withHttpMethod:kHTTP_METHOD_PUT withRequestBody:dicBody callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorChangePassword", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorChangePassword" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            dataApiResult(nil, @"OK");
        }
    }];
}

-(void)getListImageUser:(NSString *)pageIndex limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{

    NSString *url = [NSString stringWithFormat:@"%@?page=%@&limit=%@",URL_GET_IMAGE_USER,pageIndex,limit];
    
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorChangePassword", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorChangePassword" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrData = [self parseListImageUser:responseDataObject];
            
            dataApiResult(nil, arrData);
        }
    }];

}

-(void)searchListUserOfSalon:(NSString *)keyword pageIndex:(NSString *)pageIndex limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{

    //URL_GET_SEARCH_USER
    
    NSString *url = [NSString stringWithFormat:@"%@?keywords=%@&page=%@&limit=%@",URL_GET_SEARCH_USER_SALON,keyword,pageIndex,limit];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorSearchUserSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorSearchUserSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrData = [self parseListUserSearch:responseDataObject];
            
            dataApiResult(nil, arrData);
        }
    }];

}

-(void)searchListUser:(NSString *)keyword pageIndex:(NSString *)pageIndex limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult{

     //URL_GET_SEARCH_USER
    
    NSString *url = [NSString stringWithFormat:@"%@?keywords=%@&page=%@&limit=%@",URL_GET_SEARCH_USER,keyword,pageIndex,limit];
    
    [APIRequestHandler initWithURLString:url withHttpMethod:kHTTP_METHOD_GET withRequestBody:nil callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorSearchUser", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorSearchUser" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
            NSMutableArray *arrData = [self parseListUserSearch:responseDataObject];
            
            dataApiResult(nil, arrData);
        }
    }];

}
-(void)addUserForSalonByID:(NSString *)idUser dataResult:(DataAPIResult)dataApiResult{

    NSDictionary *dic = @{@"userId":idUser};
    
    [APIRequestHandler initWithURLString:URL_POST_ADD_USER_FOR_SALON withHttpMethod:kHTTP_METHOD_POST withRequestBody:dic callApiResult:^(BOOL isError, NSString *stringError, id responseDataObject) {
        
        if(isError){
            
            NSDictionary *userInfo = @{NSLocalizedFailureReasonErrorKey: NSLocalizedStringFromTable(stringError, @"ErrorAddUserForSalon", nil)};
            
            NSError *error = [[NSError alloc]initWithDomain:@"ErrorAddUserForSalon" code:1 userInfo:userInfo];
            dataApiResult(error, nil);
        }
        else{
            
//            NSMutableArray *arrData = [self parseListUserSearch:responseDataObject];
//            
            dataApiResult(nil, @"OK");
        }
    }];
}
@end
