//
//  Annotation.m
//  hairista
//
//  Created by Dong Vo on 2/3/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "Annotation.h"

@interface Annotation ()<MKAnnotation>{

    CLLocationCoordinate2D coordinateCurr;
    NSString *titleCurr;
    NSString *subtitleCurr;
    UIImage *imgAnnotaion;
}

@end

@implementation Annotation

@synthesize coordinate = coordinateCurr;
@synthesize title = titleCurr;
@synthesize subtitle = subtitleCurr;

-(id)init:(NSString *)aTitle address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate imageSalon:(UIImage *)imageSalon{
   
    self = [super init];
    
    if(self){
        
        titleCurr = aTitle;
        subtitleCurr = address;
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
