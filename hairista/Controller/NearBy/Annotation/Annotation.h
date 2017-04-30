//
//  Annotation.h
//  hairista
//
//  Created by Dong Vo on 2/3/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>


@interface Annotation : NSObject <MKAnnotation>

-(id)init:(NSString *)aTitle address:(NSString *)address coordinate:(CLLocationCoordinate2D)coordinate imageSalon:(UIImage *)imageSalon;
-(UIImage *)getImage;
-(void)setImage:(UIImage *)newImage;
-(CLLocationCoordinate2D)getCoordinate;

@property (nonatomic) BOOL isSelected;

@end
