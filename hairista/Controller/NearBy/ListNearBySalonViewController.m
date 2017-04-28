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

@interface ListNearBySalonViewController ()

@property (weak, nonatomic) IBOutlet iCarousel *iCarousel;
@property (nonatomic, strong) NSMutableArray *arrSalons;
@end

@implementation ListNearBySalonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    self.iCarousel.type = iCarouselTypeLinear;
    float widthOffset = 10;
    [self.iCarousel setViewpointOffset:CGSizeMake(widthOffset, 0)];
    [self.iCarousel setPagingEnabled:YES];
    self.iCarousel.bounces = NO;
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - iCarousel DataSource - Delegate

- (NSInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    //return the total number of items in the carousel
    
  //  return self.arrSalons.count;
    return 10;
    
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSInteger)index reusingView:(UIView *)view
{
    
    Salon *salon = [self.arrSalons objectAtIndex:index];
    
    if (view == nil)
    {
       // view = [[SalonNearByView alloc] initWithFrame:CGRectMake(0, 0, (self.arrSalons.count == 1)?SW - 20:SW - 70, SW * 103/375)];
        view = [[SalonNearByView alloc] initWithFrame:CGRectMake(0, 4, SW - 30, 74)];
    }
    else{
        
        SalonNearByView *showHotView = (SalonNearByView *)view;
      // [showHotView setDataForView:videoInfo];
    }
    
    return view;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    
    
    if (option == iCarouselOptionSpacing) {
        
         return 1.02;
//        if(self.arrSalons.count > 1){
//            return 1.02;
//        }
    }
    else if(option == iCarouselOptionWrap) {
        
        return NO;
    }
    else if (option == iCarouselOptionVisibleItems) {
        
        return 3;
    }
    
     return value;
  //  return value;
    
}


- (CGFloat)carouselItemWidth:(iCarousel *)carousel{
    
 //   return  (self.arrSalons.count == 1)?SW - 20:SW - 70;
    return SW - 30;
    
}
- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index{
    
//    VideoInfo *videoInfo = [self.arrSalons objectAtIndex:index];
//    
//    if([[self delegate] respondsToSelector:@selector(selectItemShow:)]){
//        
//        [[self delegate] selectItemShow:videoInfo];
//    }
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
    
    
}

/*
 self.iCarousel.type = iCarouselTypeLinear;
 float widthOffset = 10;
 [self.iCarousel setViewpointOffset:CGSizeMake(widthOffset, 0)];
 [self.iCarousel setPagingEnabled:YES];
 self.iCarousel.bounces = NO;

 */

@end
