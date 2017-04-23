//
//  Category.h
//  hairista
//
//  Created by Dong Vo on 4/23/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Category : NSObject

@property (nonatomic, strong) NSString *idCategory;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *name_slug;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSMutableArray *arrServices;

@end
