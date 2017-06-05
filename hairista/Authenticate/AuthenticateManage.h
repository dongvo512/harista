//
//  AuthenticateManage.h
//  hairista
//
//  Created by Dong Vo on 4/5/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthenticateManage : NSObject

+ (id)sharedInstance;

- (void)registerUser:(NSDictionary *)dicbody dataResult:(DataAPIResult)dataApiResult;

- (void)login:(NSString *)phone password:(NSString *)password dataResult:(DataAPIResult)dataApiResult;

- (void)changePassword:(NSString *)password confirmPassword:(NSString *)confirmPassword dataResult:(DataAPIResult)dataApiResult;

- (void)updateUserInfo:(NSDictionary *)dicBody dataResult:(DataAPIResult)dataApiResult;

- (void)uploadUrlImage:(NSString *)imgUrl dataResult:(DataAPIResult)dataApiResult;

-(void)getListImageUser:(NSString *)pageIndex limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)searchListUser:(NSString *)keyword pageIndex:(NSString *)pageIndex limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)searchListUserOfSalon:(NSString *)keyword pageIndex:(NSString *)pageIndex limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)addUserForSalonByID:(NSString *)idUser dataResult:(DataAPIResult)dataApiResult;
@end
