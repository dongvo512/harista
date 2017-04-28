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

- (void)getListCommentSalon:(NSString *)idSalon page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)sendMessage:(NSString *)idSalon message:(NSString *)message rate:(NSString *)rate dataResult:(DataAPIResult)dataApiResult;

-(void)getListCategoriesProduct:(DataAPIResult)dataApiResult;

-(void)calFavourite:(NSString *)idSalon dataApiResult:(DataAPIResult)dataApiResult;

-(void)getListFavoriteSalon:(NSString *)indexPage limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)getListProvince:(DataAPIResult)dataApiResult;

-(void)getListDistrict:(NSString *)idProvince dataApiResult:(DataAPIResult)dataApiResult;

-(void)getListSalonNearBy:(NSString *)lateitude longLocation:(NSString *)longitude pageindex:(NSString *)pageIndex limit:(NSString *)limit provinceid:(NSString *)provinceID district:(NSString *)districtID name:(NSString *)name dataApiResult:(DataAPIResult)dataApiResult;

//- (void)getDetailSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult;

@end
