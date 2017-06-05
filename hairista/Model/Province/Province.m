//
//  Province.m
//  hairista
//
//  Created by Dong Vo on 2/1/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "Province.h"

@implementation Province

-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.idProvince forKey:@"idProvince"];
    [encoder encodeObject:self.provinceName forKey:@"provinceName"];
    [encoder encodeObject:self.type forKey:@"type"];
}

-(id)initWithCoder:(NSCoder *)decoder {
    
    if((self = [super init])) {
        
        self.idProvince = [decoder decodeObjectForKey:@"idProvince"];
        self.provinceName = [decoder decodeObjectForKey:@"provinceName"];
        self.type = [decoder decodeObjectForKey:@"type"];
    }
    
    return self;
}
@end
