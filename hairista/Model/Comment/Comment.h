//
//  Comment.h
//  hairista
//
//  Created by Dong Vo on 2/7/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SessionUser.h"

@interface Comment : NSObject

//@property (nonatomic, strong) NSString *strName;
//@property (nonatomic, strong) NSString *comment;
//@property (nonatomic, strong) NSString *numLike;
//@property (nonatomic, strong) NSString *imgName;


@property (nonatomic, strong) NSString *createdAt;

@property (nonatomic, strong) NSString *idComment;

@property (nonatomic, strong) NSString *message;

@property (nonatomic, strong) NSString *model;

@property (nonatomic, strong) NSString *modelId;

@property (nonatomic, strong) NSString *rate;

@property (nonatomic, strong) NSString *status;

@property (nonatomic, strong) NSString *updatedAt;

@property (nonatomic, strong) SessionUser *user;

@end
