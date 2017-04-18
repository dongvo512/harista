//
//  SalonManage.h
//  hairista
//
//  Created by Dong Vo on 4/10/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SalonManage : NSObject

+ (id)sharedInstance;

- (void)getListSalons:(BOOL)isShowOnBoard page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)uploadUrlImageForSalon:(NSString *)imgUrl idSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult;

-(void)getListImageSalon:(NSString *)idSalon page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

//- (void)getDetailSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult;

@end
