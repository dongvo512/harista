//
//  Service.h
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

@property (nonatomic, strong) NSString *idService;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *name_slug;

@property (nonatomic, strong) NSString *price;

@property (nonatomic, strong) NSString *priceDiscount;

@property (nonatomic, strong) NSString *image;

@property (nonatomic, strong) NSString *userId;

@property (nonatomic, strong) NSString *ordering;

@property (nonatomic, strong) NSString *categoryId;

@property (nonatomic, strong) NSString *createdAt;

@property (nonatomic, strong) NSString *updatedAt;

@property (nonatomic) BOOL isSelected;

@end

