//
//  ImageUploadObject.h
//  hairista
//
//  Created by Dong Vo on 5/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ImageUploadObject : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSString *index;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *urlImage;
@end
