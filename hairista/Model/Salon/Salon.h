//
//  Salon.h
//  hairista
//
//  Created by Dong Vo on 1/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "District.h"
#import "Province.h"
#import "District.h"

@interface Salon : NSObject

@property (nonatomic, strong) NSString *idSalon;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *name_slug;
@property (nonatomic, strong) NSString *avatarId;
@property (nonatomic, strong) NSString *wallpaperId;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *phoneVerified;
@property (nonatomic, strong) NSString *homeAddress;
@property (nonatomic, strong) NSString *lastAddress;
@property (nonatomic, strong) NSString *inviteCode;
@property (nonatomic, strong) NSString *provider;
@property (nonatomic, strong) NSString *providerId;
@property (nonatomic, strong) NSString *provider_reponse;
@property (nonatomic, strong) NSString *invitedBy;
@property (nonatomic, strong) NSString *authToken;
@property (nonatomic, strong) NSString *lastLat;
@property (nonatomic, strong) NSString *lastLng;
@property (nonatomic, strong) NSString *isShowOnBoard;
@property (nonatomic, strong) NSString *birthday;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *district;
@property (nonatomic, strong) NSString *about;
@property (nonatomic, strong) NSString *avgRate;
@property (nonatomic, strong) NSString *totalComment;
@property (nonatomic, strong) NSString *totalRate;
@property (nonatomic, strong) NSString *totalPointRate;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) NSString *isOnline;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *wallpaper;
@property (nonatomic, strong) NSString *openTime;
@property (nonatomic, strong) NSString *closeTime;
@property (nonatomic, strong) NSArray *childs;
@property (nonatomic, strong) NSNumber *isFavorite;
@property (nonatomic, strong) NSString *districtId;
@property (nonatomic, strong) NSString *provinceId;
@property (nonatomic, strong) Province *provinceObject;
@property (nonatomic, strong) District *districtObject;
@end
