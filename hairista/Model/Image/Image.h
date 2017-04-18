//
//  Image.h
//  hairista
//
//  Created by Dong Vo on 4/17/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject

@property (nonatomic, strong) NSString *accessMode;
@property (nonatomic, strong) NSString *allowId;
@property (nonatomic, strong) NSString *createdAt;
@property (nonatomic, strong) NSString *forUserId;
@property (nonatomic, strong) NSString *idImage;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) NSString *updatedAt;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *userId;

@end
