//
//  GetLocationViewController.m
//  hairista
//
//  Created by Dong Vo on 5/25/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "GetLocationViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "Annotation.h"

@interface GetLocationViewController ()<CLLocationManagerDelegate>{
    
     CLLocationManager *localManager;
    
    CGFloat laitudeDrop;
    CGFloat longitudeDrop;
    
    BOOL isLoadedUserLocation;

}
@property (weak, nonatomic) IBOutlet MKMapView *mkMapkit;
@property (weak, nonatomic) IBOutlet UILabel *lblLocation;

@end

@implementation GetLocationViewController


#pragma mark - Init
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil aLat:(NSString *)laitude aLong:(NSString *)longitude{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        laitudeDrop = laitude.floatValue;
        longitudeDrop = longitude.floatValue;
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

#pragma - Method

-(void)loadCordinateCurrent{

    CLLocationCoordinate2D coordinateSalon = CLLocationCoordinate2DMake(laitudeDrop, longitudeDrop);
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:coordinateSalon];
    [self.mkMapkit addAnnotations:@[annotation]];
    
    self.mkMapkit.showsUserLocation = NO;
    
    MKCoordinateRegion region;
    MKCoordinateSpan span;
    span.latitudeDelta = 0.005;
    span.longitudeDelta = 0.005;
    CLLocationCoordinate2D location;
    location.latitude = laitudeDrop;
    location.longitude = longitudeDrop;
    region.span = span;
    region.center = location;
    self.mkMapkit.showsUserLocation = NO;
    [self.mkMapkit setRegion:region animated:YES];
    
    self.lblLocation.text = [NSString stringWithFormat:@"%f  -  %f",laitudeDrop, longitudeDrop];
}
- (IBAction)touchBtnback:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)touchBtnCheck:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(touchButtonCheck:longitude:)]){
    
        [[self delegate] touchButtonCheck:laitudeDrop longitude:longitudeDrop];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        if(!isLoadedUserLocation){
          
            isLoadedUserLocation = YES;
        
            if( laitudeDrop != 0 && longitudeDrop != 0){
                
                [self loadCordinateCurrent];
            }
            else{
                
                CLLocationCoordinate2D coordinateSalon = CLLocationCoordinate2DMake(currentLocation.coordinate.latitude, currentLocation.coordinate.longitude);
                
                laitudeDrop = currentLocation.coordinate.latitude;
                longitudeDrop = currentLocation.coordinate.longitude;
                
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                [annotation setCoordinate:coordinateSalon];
                [self.mkMapkit addAnnotations:@[annotation]];
                
                self.mkMapkit.showsUserLocation = NO;
                
                MKCoordinateRegion region;
                MKCoordinateSpan span;
                span.latitudeDelta = 0.005;
                span.longitudeDelta = 0.005;
                CLLocationCoordinate2D location;
                location.latitude = currentLocation.coordinate.latitude;
                location.longitude = currentLocation.coordinate.longitude;
                region.span = span;
                region.center = location;
                self.mkMapkit.showsUserLocation = NO;
                [self.mkMapkit setRegion:region animated:YES];
                
                self.lblLocation.text = [NSString stringWithFormat:@"%f  -  %f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude];
            }
        }
    }
    
    // Stop Location Manager
    [localManager stopUpdatingLocation];
}
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    // NSLog(@"%@",error.userInfo);
    if([CLLocationManager locationServicesEnabled]){
        
        NSLog(@"Location Services Enabled");
        
        if([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied){
            
            if( laitudeDrop != 0 && longitudeDrop != 0){
                
                [self loadCordinateCurrent];
            }
            else{
            
                NSString *latitude = @"10.788356";
                NSString *longitude = @"106.677276";
                
                laitudeDrop = latitude.floatValue;
                longitudeDrop = longitude.floatValue;
                
                CLLocationCoordinate2D coordinateSalon = CLLocationCoordinate2DMake(latitude.floatValue, longitude.floatValue);
                
                MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
                [annotation setCoordinate:coordinateSalon];
                [self.mkMapkit addAnnotations:@[annotation]];
                
                self.mkMapkit.showsUserLocation = NO;
                
                MKCoordinateRegion region;
                MKCoordinateSpan span;
                span.latitudeDelta = 0.005;
                span.longitudeDelta = 0.005;
                CLLocationCoordinate2D location;
                location.latitude = latitude.floatValue;
                location.longitude = longitude.floatValue;
                region.span = span;
                region.center = location;
                self.mkMapkit.showsUserLocation = NO;
                [self.mkMapkit setRegion:region animated:YES];
                
                self.lblLocation.text = [NSString stringWithFormat:@"%f  -  %f",latitude.floatValue,longitude.floatValue];
            }
        }
    }
}
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKPinAnnotationView *pin = (MKPinAnnotationView *) [self.mkMapkit dequeueReusableAnnotationViewWithIdentifier: @"myPin"];
    if (pin == nil) {
        pin = [[MKPinAnnotationView alloc] initWithAnnotation: annotation reuseIdentifier: @"myPin"]; // If you use ARC, take out 'autorelease'
    } else {
        pin.annotation = annotation;
    }
    pin.animatesDrop = YES;
    pin.draggable = YES;
    //[pin setSelected:YES animated:YES];
    return pin;
}

- (void)mapView:(MKMapView *)mapView
 annotationView:(MKAnnotationView *)annotationView
didChangeDragState:(MKAnnotationViewDragState)newState
   fromOldState:(MKAnnotationViewDragState)oldState
{
    if (newState == MKAnnotationViewDragStateEnding)
    {
        CLLocationCoordinate2D droppedAt = annotationView.annotation.coordinate;
        NSLog(@"Pin dropped at %f,%f", droppedAt.latitude, droppedAt.longitude);
        
         self.lblLocation.text = [NSString stringWithFormat:@"%f  -  %f",droppedAt.latitude,droppedAt.longitude];
        laitudeDrop = droppedAt.latitude;
        longitudeDrop = droppedAt.longitude;
    }
}
@end
