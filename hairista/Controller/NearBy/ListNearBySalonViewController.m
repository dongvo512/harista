//
//  ListNearBySalonViewController.m
//  hairista
//
//  Created by Dong Vo on 4/28/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ListNearBySalonViewController.h"
#import "iCarousel.h"
#import "Salon.h"
#import "SalonNearByView.h"
#import <CoreLocation/CoreLocation.h>
#import "SalonManage.h"
#import <MapKit/MapKit.h>
#import "Annotation.h"
#import "DetailSalonViewController.h"

#define LIMIT_ITEM @"14"

@interface ListNearBySalonViewController ()<CLLocationManagerDelegate>{

    CLLocationManager *localManager;
    NSInteger indexPage;
    BOOL isGetDataSalon;
    
    NSString *laitude;
    NSString *longitude;
    
    BOOL isRegionFirstAnnotation;
    
    BOOL isFullData;
    
}
@property (nonatomic, strong) Annotation *annotationSelected;
@property (weak, nonatomic) IBOutlet MKMapView *mapKit;
@property (weak, nonatomic) IBOutlet iCarousel *iCarousel;
@property (nonatomic, strong) NSMutableArray *arrSalons;
@property (nonatomic, strong) NSMutableArray *arrAnnotationCurr;
@end

@implementation ListNearBySalonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.arrAnnotationCurr = [NSMutableArray array];
    indexPage = 1;
    self.iCarousel.type = iCarouselTypeLinear;
    float widthOffset = 10;
    [self.iCarousel setViewpointOffset:CGSizeMake(widthOffset, 0)];
    [self.iCarousel setPagingEnabled:YES];
    self.iCarousel.bounces = NO;
   
    [self.iCarousel setHidden:YES];
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
-(void)touchBtnGo:(UIButton *)btn{
    
    NSInteger index = [self.arrAnnotationCurr indexOfObject:self.annotationSelected];
    
    DetailSalonViewController *vcDetail = [[DetailSalonViewController alloc] initWithNibName:@"DetailSalonViewController" bundle:nil salon:[self.arrSalons objectAtIndex:index]];
    
    [self.navigationController pushViewController:vcDetail animated:YES];
}
- (IBAction)touchBtnBack:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addListAnnotation:(NSArray *)arrSalon{

    NSMutableArray *arrAnnotation = [NSMutableArray array];
    UIImage *img = [UIImage imageNamed:@"ic_salon"];
  
    for(Salon *salon in arrSalon){
    
        CLLocationCoordinate2D coordinateSalon = CLLocationCoordinate2DMake(salon.lastLat.floatValue, salon.lastLng.floatValue);
        
         Annotation *annotationSalon = [[Annotation alloc] init:salon.name address:salon.homeAddress coordinate:coordinateSalon imageSalon:img];
        [arrAnnotation addObject:annotationSalon];
        
        [self.arrAnnotationCurr addObject:annotationSalon];
      
    }
    
    
    [self.mapKit addAnnotations:arrAnnotation];
    
    if(self.arrAnnotationCurr.count > 0 && !isRegionFirstAnnotation){
    
        Annotation *annotation = [self.arrAnnotationCurr firstObject];
        
        [self scrollToAnnotation:annotation];
        isRegionFirstAnnotation = YES;
    }
    
}

-(void)scrollToAnnotation:(Annotation *)annotation{

     [self.mapKit showAnnotations:@[annotation] animated:YES];
    [self.mapKit selectAnnotation:annotation animated:YES];
}

-(void)loadMore{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[SalonManage sharedInstance] getListSalonNearBy:laitude longLocation:longitude pageindex:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM provinceid:@"" district:@"" name:@"" dataApiResult:^(NSError *error, id idObject, NSString *strError) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                [self performSelector:@selector(addListAnnotation:) withObject:arrData afterDelay:0.0f];
                [self.arrSalons addObjectsFromArray:arrData];
                
                [self.iCarousel reloadData];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
        }
        
    }];

}

-(void)getListSalonNearby{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[SalonManage sharedInstance] getListSalonNearBy:laitude longLocation:longitude pageindex:[NSString stringWithFormat:@"%ld",(long)indexPage] limit:LIMIT_ITEM provinceid:@"" district:@"" name:@"" dataApiResult:^(NSError *error, id idObject, NSString *strError) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        
        if(error){
            
            [Common showAlert:self title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
            
                [self.iCarousel setHidden:NO];
                [self performSelector:@selector(addListAnnotation:) withObject:arrData afterDelay:0.0f];
               self.arrSalons = [NSMutableArray arrayWithArray:arrData];
                
                [self.iCarousel reloadData];
            }
           
            if(self.arrSalons.count == 0){
                
                [Common showAlert:self title:@"Thông báo" message:@"Không tìm thấy Salon nào" buttonClick:nil];
                
            }
        }
        
    }];
}


#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        laitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
        
        longitude = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
        
        if(!isGetDataSalon){
        
             [self getListSalonNearby];
            isGetDataSalon = YES;
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
            
            [self getListSalonNearby];
            [Common showAlert:self title:@"Thông báo" message:@"Bạn chưa xác nhận định vị toạ độ" buttonClick:nil];
        }
    }
}
#pragma mark - MKAnnotationView
-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    
    MKAnnotationView *pinView = nil;
    
    if([annotation isKindOfClass:[Annotation class]]){
        
        static NSString *identifier = @"CustomPinAnnotationView";
        pinView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
         Annotation *annotationCurr = (Annotation *)annotation;
        
        if(!pinView){
            
            pinView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
           
            UIButton *btnGo = [UIButton buttonWithType:UIButtonTypeCustom];
        
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
        
        pinView.image = [annotationCurr getImage];
    }
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view
{
    
    if ([view.annotation isKindOfClass:[Annotation class]])
    {
        self.annotationSelected = view.annotation;
        NSInteger index = [self.arrAnnotationCurr indexOfObject:self.annotationSelected];
      
        if(index != self.iCarousel.currentItemIndex){
       
            [self.iCarousel scrollToItemAtIndex:index animated:YES];
        }
    }
}
#pragma mark - iCarousel DataSource - Delegate

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    
    return self.arrSalons.count;
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    Salon *salon = [self.arrSalons objectAtIndex:index];
    
    if (view == nil)
    {
        SalonNearByView *showHotView = [[SalonNearByView alloc] initWithFrame:CGRectMake(0, 4, SW - 30, 74)];
        [showHotView setDataForView:salon];
        view = showHotView;
    }
    else{
        
        SalonNearByView *showHotView = (SalonNearByView *)view;
        [showHotView setDataForView:salon];
    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    
    if (option == iCarouselOptionSpacing) {
        
         return 1.02;
    }
    else if(option == iCarouselOptionWrap) {
        
        return NO;
    }
    else if (option == iCarouselOptionVisibleItems) {
        
        return 3;
    }
    
     return value;
    
}


- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    
    return  (self.arrSalons.count == 1)?SW - 20:SW - 30;

}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{

    
    DetailSalonViewController *vcDetail = [[DetailSalonViewController alloc] initWithNibName:@"DetailSalonViewController" bundle:nil salon:[self.arrSalons objectAtIndex:index]];
    
    [self.navigationController pushViewController:vcDetail animated:YES];

}

- (void)carouselDidScroll:(iCarousel *)carousel{
    
    
    if(self.iCarousel.currentItemIndex == 0){
    
        float widthOffset = 10;
        [self.iCarousel setViewpointOffset:CGSizeMake(widthOffset, 0)];

    }
    else if (self.iCarousel.currentItemIndex == 9){
    
        float widthOffset = -10;
        [self.iCarousel setViewpointOffset:CGSizeMake(widthOffset, 0)];
       
    }
    else{
    
        [self.iCarousel setViewpointOffset:CGSizeMake(0, 0)];

    }
    
    if(isRegionFirstAnnotation){
    
         Annotation *annotation = [self.arrAnnotationCurr objectAtIndex:carousel.currentItemIndex];
        [self scrollToAnnotation:annotation];
        
       
    }
    
}
- (void)carouselDidEndScrollingAnimation:(iCarousel *)carousel{

    if(isRegionFirstAnnotation){
        
        if(carousel.currentItemIndex == self.arrSalons.count - 1 && !isFullData){
            
            indexPage ++;
            [self loadMore];
            
        }
    }
    
}
@end
