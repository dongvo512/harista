//
//  Service.h
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Service : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *imgNameService;
@property (nonatomic)  BOOL isSelected;

@end

