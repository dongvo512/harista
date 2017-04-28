//
//  MapDetailSalonViewController.m
//  hairista
//
//  Created by Dong Vo on 4/28/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "MapDetailSalonViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "Salon.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface MapDetailSalonViewController ()<CLLocationManagerDelegate>{

    CLLocationManager *localManager;
    Salon *salonCurr;
    NSArray *arrAnnotations;
    MKPolyline *polylineCurr;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapKit;

@end

@implementation MapDetailSalonViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil Salon:(Salon *)salon{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        salonCurr = salon;
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    localManager = [[CLLocationManager alloc] init];
    
    localManager.delegate = self;
    localManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    
    if([localManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        
        [localManager requestWhenInUseAuthorization];
        
        [localManager startUpdatingLocation];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
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

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
         UIImage *img = [UIImage imageNamed:@"ic_salon"];
        
         CLLocationCoordinate2D coordinateSalon = CLLocationCoordinate2DMake(salonCurr.lastLat.floatValue, salonCurr.lastLng.floatValue);
       
        Annotation *annotationSalon = [[Annotation alloc] init:salonCurr.name address:salonCurr.homeAddress coordinate:coordinateSalon imageSalon:img];
        
       arrAnnotations = [NSArray arrayWithObjects:annotationSalon, nil];
        
        [self.mapKit addAnnotations:arrAnnotations];
        self.mapKit.showsUserLocation = YES;
        CLLocation *locationUser = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
        
        Annotation *annotation = [[self getDistanceClosest:arrAnnotations CLLocationUser:locationUser] firstObject];
        
        [self drawLineLocation:newLocation.coordinate desLocation:[annotation getCoordinate]];

    
    }
    
    // Stop Location Manager
    [localManager stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    // NSLog(@"%@",error.userInfo);
    if([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied){
            
            UIImage *img = [UIImage imageNamed:@"ic_salon"];
            
            CLLocationCoordinate2D coordinateSalon = CLLocationCoordinate2DMake(salonCurr.lastLat.floatValue, salonCurr.lastLng.floatValue);
            
            Annotation *annotationSalon = [[Annotation alloc] init:salonCurr.name address:salonCurr.homeAddress coordinate:coordinateSalon imageSalon:img];
            
            arrAnnotations = [NSArray arrayWithObjects:annotationSalon, nil];
            
            [self.mapKit addAnnotations:arrAnnotations];
            self.mapKit.showsUserLocation = YES;
            
            MKCoordinateRegion region;
            MKCoordinateSpan span;
            span.latitudeDelta = 0.005;
            span.longitudeDelta = 0.005;
            CLLocationCoordinate2D location;
            location.latitude = salonCurr.lastLat.floatValue;
            location.longitude = salonCurr.lastLng.floatValue;
            region.span = span;
            region.center = location;
            self.mapKit.showsUserLocation = NO;
            [self.mapKit setRegion:region animated:YES];
            
            [Common showAlert:self title:@"Thông báo" message:@"Bạn chưa xác nhận định vị toạ độ" buttonClick:nil];
        }
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
            // NSLog(@"%d",[arrAnnotations indexOfObject:annotation]);
            [btnGo setTag:[arrAnnotations indexOfObject:annotation]];
            
            [btnGo setImage:[UIImage imageNamed:@"ic_go"] forState:UIControlStateNormal];
            
           // [btnGo addTarget:self action:@selector(touchBtnGo:) forControlEvents:UIControlEventTouchUpInside];
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

@end
