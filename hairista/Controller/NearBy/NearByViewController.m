//
//  NearByViewController.m
//  hairista
//
//  Created by Dong Vo on 1/27/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "NearByViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Annotation.h"


@interface NearByViewController ()<MKMapViewDelegate,CLLocationManagerDelegate>{

    CLLocationManager *localManager;
    
   // Annotation *annotationUser;
    
    BOOL isCanUpdateCurrLocation;
    
    MKPolyline *polylineCurr;
    
    NSArray *arrAnnotations;
    
    MKCoordinateRegion coordinateGroupAnnotatons;
}
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;
@property (weak, nonatomic) IBOutlet UIButton *btnNearByAnnotation;
@property (weak, nonatomic) IBOutlet UIButton *btnNearByUser;

@end

@implementation NearByViewController


#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapKit.showsUserLocation = YES;
    self.mapKit.showsBuildings = YES;
    
    localManager = [[CLLocationManager alloc] init];
    
    localManager.delegate = self;
    localManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    if([localManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        
        isCanUpdateCurrLocation = YES;
        
        [localManager requestWhenInUseAuthorization];
       
        [localManager startUpdatingLocation];
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Method
-(void)touchBtnGo:(UIButton *)btn{
    
    Annotation *annotation = [arrAnnotations objectAtIndex:btn.tag];
    
   // NSLog(@"%d",btn.tag);
    
    [self drawLineLocation:self.mapKit.userLocation.coordinate desLocation:[annotation getCoordinate]];
}
- (void)drawLineLocation:(CLLocationCoordinate2D )fromLocation desLocation:(CLLocationCoordinate2D )desLocation{

     NSArray *pointsArray = [self.mapKit overlays];
    
    if(pointsArray.count > 0){
        
        [self.mapKit removeOverlays:pointsArray];
    }
    // Bước 1: tạo PlaceMark điểm đầu và điểm cuối.
    MKPlacemark *fromPlaceMark = [[MKPlacemark alloc] initWithCoordinate:fromLocation addressDictionary:nil];
    
     MKPlacemark *desPlaceMark = [[MKPlacemark alloc] initWithCoordinate:desLocation addressDictionary:nil];
    // Bước 2: Toạ MapItem để hiển thị
    
    MKMapItem *mapItemFrom = [[MKMapItem alloc] initWithPlacemark:fromPlaceMark];
    
    MKMapItem *mapItemDes = [[MKMapItem alloc] initWithPlacemark:desPlaceMark];
    
    // Bước 3: Tạo yêu cầu chỉ đường.
    
    MKDirectionsRequest *direcRequest = [[MKDirectionsRequest alloc] init];
    
    direcRequest.source = mapItemFrom;
    
    direcRequest.destination = mapItemDes;
    
    direcRequest.transportType = MKDirectionsTransportTypeAutomobile;
    
    // Bước 4:
    
    MKDirections *direction = [[MKDirections alloc] initWithRequest:direcRequest];
   
    [direction calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * _Nullable response, NSError * _Nullable error) {
      
        if(!error){
            
            @try {
                
                NSArray *arrRoutes = [response routes];
                
                MKRoute *route = [arrRoutes firstObject];
                
                polylineCurr = route.polyline;
                
                [self.mapKit addOverlay:polylineCurr level:MKOverlayLevelAboveRoads];
                
                MKMapRect rect = route.polyline.boundingMapRect;
                
                [self.mapKit setVisibleMapRect:rect edgePadding:UIEdgeInsetsMake(40, 40, 20, 20) animated:YES];
                
            }
            @catch (NSException * e) {
                NSLog(@"Exception: %@", e);
            }
        }
        else{
            
            NSLog(@"%@",error.localizedDescription);
        }

    }];
    
}

- (NSArray *)getDistanceClosest:(NSArray *)arrAnnotation CLLocationUser:(CLLocation *)locationUser{

    CLLocation *userLocation = locationUser;
    NSMutableDictionary *distances = [NSMutableDictionary dictionary];
    
    for (Annotation *obj in arrAnnotation) {
        CLLocation *loc = [[CLLocation alloc] initWithLatitude:[obj getCoordinate].latitude longitude:[obj getCoordinate].longitude];
        CLLocationDistance distance = [loc distanceFromLocation:userLocation];
        
        NSLog(@"Distance from Annotations - %f", distance);
        
        [distances setObject:obj forKey:@( distance )];
    }
    
    NSArray *sortedKeys = [[distances allKeys] sortedArrayUsingSelector:@selector(compare:)];
    NSArray *closestKeys = [sortedKeys subarrayWithRange:NSMakeRange(0, MIN(1, sortedKeys.count))];
    
    NSArray *closestAnnotations = [distances objectsForKeys:closestKeys notFoundMarker:[NSNull null]];
    
    return closestAnnotations;
}

- (IBAction)touchBtnAnnotations:(UIButton *)btn {
    
      Annotation *annotation = [[self getDistanceClosest:arrAnnotations CLLocationUser:self.mapKit.userLocation.location] firstObject];
    
    if(CLLocationCoordinate2DIsValid([annotation getCoordinate])) {
       
        [self drawLineLocation:self.mapKit.userLocation.coordinate desLocation:[annotation getCoordinate]];
    }

}

- (IBAction)touchBtnUserLocation:(id)sender {
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = self.mapKit.userLocation.coordinate.latitude;
    location.longitude = self.mapKit.userLocation.coordinate.longitude;
    region.span = span;
    region.center = location;
    [self.mapKit setRegion:region animated:YES];
}

- (MKCoordinateRegion)regionForAnnotations:(NSArray *)annotations
{
    MKCoordinateRegion region;
    
    if ([annotations count] == 0)
    {
        region = MKCoordinateRegionMakeWithDistance(self.mapKit.userLocation.coordinate, 1000, 1000);
    }
    
    else if ([annotations count] == 1)
    {
        id <MKAnnotation> annotation = [annotations lastObject];
        region = MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000);
    } else {
        CLLocationCoordinate2D topLeftCoord;
        topLeftCoord.latitude = -90;
        topLeftCoord.longitude = 180;
        
        CLLocationCoordinate2D bottomRightCoord;
        bottomRightCoord.latitude = 90;
        bottomRightCoord.longitude = -180;
        
        for (id <MKAnnotation> annotation in annotations)
        {
            topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
            topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
            bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
            bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        }
        
        const double extraSpace = 1.12;
        region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) / 2.0;
        region.center.longitude = topLeftCoord.longitude - (topLeftCoord.longitude - bottomRightCoord.longitude) / 2.0;
        region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude) * extraSpace;
        region.span.longitudeDelta = fabs(topLeftCoord.longitude - bottomRightCoord.longitude) * extraSpace;
    }
    
    return [self.mapKit regionThatFits:region];
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - MapKit Delegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{

    if(status == kCLAuthorizationStatusDenied){
        
        [self.btnNearByAnnotation setHidden:YES];
        
        [self.btnNearByUser setHidden:YES];
    }
    
}

-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    
    MKPolylineRenderer *polylineRender = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
    polylineRender.strokeColor = [UIColor redColor];
    polylineRender.lineWidth = 3.0f;
   
    return polylineRender;
}

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{

    MKAnnotationView *pinView = nil;
    
    if([annotation isKindOfClass:[Annotation class]]){
    
        static NSString *identifier = @"CustomPinAnnotationView";
        pinView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];

        if(!pinView){
            
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            UIButton *btnGo = [UIButton buttonWithType:UIButtonTypeCustom];
            NSLog(@"%d",[arrAnnotations indexOfObject:annotation]);
            [btnGo setTag:[arrAnnotations indexOfObject:annotation]];
            [btnGo setImage:[UIImage imageNamed:@"ic_go"] forState:UIControlStateNormal];
            [btnGo addTarget:self action:@selector(touchBtnGo:) forControlEvents:UIControlEventTouchUpInside];
            btnGo.frame =
            CGRectMake(0, 0, 26, 26);
            [pinView setRightCalloutAccessoryView:btnGo];
            pinView.enabled = YES;
            pinView.canShowCallout = YES;
            pinView.calloutOffset = CGPointMake(0, 4);
            pinView.contentMode = UIViewContentModeScaleAspectFill;
        }
        else{
            
            pinView.annotation = annotation;
        }

        Annotation *annotationCurr = (Annotation *)annotation;
        
        pinView.image = [annotationCurr getImage];
    }
    
    return pinView;
}
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"Latitude :  %f", newLocation.coordinate.latitude);
    NSLog(@"Longitude :  %f", newLocation.coordinate.longitude);
    
    if(isCanUpdateCurrLocation){
    
    isCanUpdateCurrLocation = NO;
        
    UIImage *img = [UIImage imageNamed:@"ic_salon"];
    
        //Tân bay tân sơn nhất 10.818635, 106.658584
        CLLocationCoordinate2D coordinateSanBay = CLLocationCoordinate2DMake(10.818635, 106.658584);
        Annotation *annotationSanBay = [[Annotation alloc] init:@"Sân bay tân sơn nhất" address:@"Arrival Loop, Phường 2, Tân Bình, Hồ Chí Minh, Việt Nam" coordinate:coordinateSanBay imageSalon:img];
        
        //SALON Hair Bar 10.772879, 106.704363
        CLLocationCoordinate2D coordinateHairBar = CLLocationCoordinate2DMake(10.772879, 106.704363);
        Annotation *annotationHairBar = [[Annotation alloc] init:@"Salons Hair Bar" address:@"55 Nguyễn Huệ, Phường Bến Nghé, Tp.HCM" coordinate:coordinateHairBar imageSalon:img];
        
        
        //SALON HAIR 10.775825, 106.674018
        CLLocationCoordinate2D coordinateHAIR = CLLocationCoordinate2DMake(10.775825, 106.674018);
        Annotation *annotationHair = [[Annotation alloc] init:@"Salons Lê Hiếu" address:@"285 Cách mạng tháng 8, Phường 12, Quận 10, TP.HCM" coordinate:coordinateHAIR imageSalon:img];
        
        //SALON Lê Hiếu 10.788152, 106.677404
        CLLocationCoordinate2D coordinateLeHieu = CLLocationCoordinate2DMake(10.788152, 106.677404);
        Annotation *annotationLeHieu = [[Annotation alloc] init:@"Salons Lê Hiếu 2" address:@"386 Lê Văn Sỹ, Quận 3, TP.HCM" coordinate:coordinateLeHieu imageSalon:img];
        
        arrAnnotations = [NSArray arrayWithObjects:annotationSanBay, annotationHairBar,annotationHair,annotationLeHieu, nil];
        
        [self.mapKit addAnnotations:arrAnnotations];
        
        CLLocation *locationUser = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        
        Annotation *annotation = [[self getDistanceClosest:arrAnnotations CLLocationUser:locationUser] firstObject];
        
      //  self.btnNearByAnnotation.tag = [arrAnnotations indexOfObject:annotation];
        [self drawLineLocation:newLocation.coordinate desLocation:[annotation getCoordinate]];
        
    }
    
    [localManager stopUpdatingLocation];
}
@end
