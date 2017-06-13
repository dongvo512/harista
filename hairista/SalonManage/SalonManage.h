//
//  SalonManage.h
//  hairista
//
//  Created by Dong Vo on 4/10/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Service, Salon;

@interface SalonManage : NSObject

+ (id)sharedInstance;

- (void)getListSalons:(BOOL)isShowOnBoard page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)uploadUrlImageForSalon:(NSString *)imgUrl name:(NSString *)name idSalon:(NSString *)idSalon dataResult:(DataAPIResult)dataApiResult;

-(void)getListImageSalon:(NSString *)idSalon page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

- (void)getListCommentSalon:(NSString *)idSalon page:(NSString *)page limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)sendMessage:(NSString *)idSalon message:(NSString *)message rate:(NSString *)rate dataResult:(DataAPIResult)dataApiResult;

-(void)getListCategoriesProduct:(DataAPIResult)dataApiResult;

-(void)calFavourite:(NSString *)idSalon dataApiResult:(DataAPIResult)dataApiResult;

-(void)getListFavoriteSalon:(NSString *)indexPage limit:(NSString *)limit dataResult:(DataAPIResult)dataApiResult;

-(void)getListProvince:(DataAPIResult)dataApiResult;

-(void)getListDistrict:(NSString *)idProvince dataApiResult:(DataAPIResult)dataApiResult;

-(void)getListSalonNearBy:(NSString *)lateitude longLocation:(NSString *)longitude pageindex:(NSString *)pageIndex limit:(NSString *)limit provinceid:(NSString *)provinceID district:(NSString *)districtID name:(NSString *)name dataApiResult:(DataAPIResult)dataApiResult;

-(void)deleteFavorite:(NSString *)idSalon dataApiResult:(DataAPIResult)dataApiResult;

-(void)favorite:(NSString *)idSalon dataApiResult:(DataAPIResult)dataApiResult;

-(void)updateMultiIndexImage:(NSDictionary *)dicListImage dataApiResult:(DataAPIResult)dataApiResult;

-(void)getListSalonUpdateImage:(DataAPIResult)dataApiResult;

-(void)getListServiceBySalonID:(NSString *)salonID dataApiResult:(DataAPIResult)dataApiResult;

-(void)createCategory:(NSString *)catName dataApiResult:(DataAPIResult)dataApiResult;

-(void)getListServiceByCategoryID:(NSString *)categoryID dataApiResult:(DataAPIResult)dataApiResult;


-(void)createServiceByIdCat:(NSString *)idCate service:(Service *)service dataApiResult:(DataAPIResult)dataApiResult;

-(void)updateCategory:(NSString *)idCat nameCat:(NSString *)catName dataApiResult:(DataAPIResult)dataApiResult;

-(void)updateService:(NSString *)idCate service:(Service *)service dataApiResult:(DataAPIResult)dataApiResult;

-(void)deleteImage:(NSString *)idImage dataApiResult:(DataAPIResult)dataApiResult;

-(void)deleteComment:(NSString *)idComment dataApiResult:(DataAPIResult)dataApiResult;

-(void)updateSalonOnBoard:(Salon *)salon dataApiResult:(DataAPIResult)dataApiResult;

-(void)updateUserToSalon:(SessionUser *)user dataApiResult:(DataAPIResult)dataApiResult;

-(void)updateSalonToUser:(Salon *)salon dataApiResult:(DataAPIResult)dataApiResult;

@end
