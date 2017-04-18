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

- (void)registerUser:(NSString *)phone password:(NSString *)password passwordConfirm:(NSString *)passwordConfirm dataResult:(DataAPIResult)dataApiResult;

- (void)login:(NSString *)phone password:(NSString *)password dataResult:(DataAPIResult)dataApiResult;

- (void)changePassword:(NSString *)password confirmPassword:(NSString *)confirmPassword dataResult:(DataAPIResult)dataApiResult;

- (void)updateUserInfo:(NSDictionary *)dicBody dataResult:(DataAPIResult)dataApiResult;

- (void)uploadUrlImage:(NSString *)imgUrl dataResult:(DataAPIResult)dataApiResult;

@end
