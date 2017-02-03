//
//  Annotation.m
//  hairista
//
//  Created by Dong Vo on 2/3/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "Annotation.h"

@interface Annotation (){

    CLLocationCoordinate2D coordinateCurr;
    NSString *title;
    NSString *subtitle;
    UIImage *imgAnnotaion;
}

@end

@implementation Annotation

@synthesize coordinate = _coordinate;
@synthesize title = _title;
@synthesize subtitle = _subtitle;

-(id)init:(NSString *)aTitle address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate imageSalon:(UIImage *)imageSalon{
   
    self = [super init];
    
    if(self){
        
        title = aTitle;
        subtitle = address;
        coordinateCurr = coordinate;
        imgAnnotaion = imageSalon;
        
    }
    return self;
}

-(CLLocationCoordinate2D)getCoordinate{

    return coordinateCurr;
}
-(UIImage *)getImage{

    return imgAnnotaion;
}

@end
