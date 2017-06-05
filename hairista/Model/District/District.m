//
//  District.m
//  hairista
//
//  Created by Dong Vo on 4/27/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "District.h"

@implementation District

-(void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.idDistrict forKey:@"idDistrict"];
    [encoder encodeObject:self.idProvince forKey:@"idProvince"];
    [encoder encodeObject:self.type forKey:@"type"];
    [encoder encodeObject:self.location forKey:@"location"];
    [encoder encodeObject:self.name forKey:@"name"];
}

-(id)initWithCoder:(NSCoder *)decoder {
    
    if((self = [super init])) {
        
        self.idDistrict = [decoder decodeObjectForKey:@"idDistrict"];
        self.idProvince = [decoder decodeObjectForKey:@"idProvince"];
        self.type = [decoder decodeObjectForKey:@"type"];
        self.location = [decoder decodeObjectForKey:@"location"];
        self.name = [decoder decodeObjectForKey:@"name"];
    }
    
    return self;
}
@end
