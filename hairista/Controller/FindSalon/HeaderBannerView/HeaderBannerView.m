//
//  HeaderBannerView.m
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "HeaderBannerView.h"
#import "HeaderBannerCell.h"
#import "CommonDefine.h"
#import "Salon.h"


@interface HeaderBannerView ()<UIScrollViewDelegate>{

    NSTimer *timer;
    
    BOOL isEndScrolling;
}
@property (weak, nonatomic) IBOutlet UICollectionView *cllBannerSalon;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *widthContraintPageControl;

@property (nonatomic, strong) NSArray *arrSalonsHeader;


@end

@implementation HeaderBannerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder{
    
    if(self = [super initWithCoder:aDecoder]){
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame listSalonHot:(NSArray *)arraySalonHot{
    
    if(self = [super initWithFrame:frame]){
        
        self.arrSalonsHeader = arraySalonHot;
        [self setup];
    }
    return self;
}

#pragma mark - Method


- (void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"HeaderBannerView" owner:self options:nil].firstObject;
    
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
    [self.cllBannerSalon registerNib:[UINib nibWithNibName:@"HeaderBannerCell" bundle:nil] forCellWithReuseIdentifier:@"HeaderBannerCell"];

    [self.pageControl setNumberOfPages:self.arrSalonsHeader.count];
    self.widthContraintPageControl.constant = 18 * self.arrSalonsHeader.count;
    [self.pageControl setCurrentPage:0];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(autoNextPage)
                                   userInfo:nil
                                    repeats:YES];
    
    
}
-(void)autoNextPage{
    
    if(self.pageControl.currentPage == self.arrSalonsHeader.count - 1){
    
        [self.pageControl setCurrentPage:0];
    }
    else{
    
        [self.pageControl setCurrentPage:self.pageControl.currentPage + 1];
    }
    
    [self.cllBannerSalon scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:self.pageControl.currentPage inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
}


#pragma mark - UICollectionView DataSource - Delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    
   return  self.arrSalonsHeader.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
   
    HeaderBannerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderBannerCell" forIndexPath:indexPath];
    Salon *salon = [self.arrSalonsHeader objectAtIndex:indexPath.row];
    [cell setDataForCell:salon];
    return cell;
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(SW, SW/2);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    if([scrollView isKindOfClass:[UICollectionView class]]){
    
        isEndScrolling = NO;
        [timer invalidate];
        timer = nil;
    }
   
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{

   }
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat pageWidth = self.cllBannerSalon.frame.size.width;
    float currentPage =  self.cllBannerSalon.contentOffset.x / pageWidth;
    
    if (0.0f != fmodf(currentPage, 1.0f))
    {
        self.pageControl.currentPage = currentPage + 1;
    }
    else
    {
        self.pageControl.currentPage = currentPage;
    }
    
    if([scrollView isKindOfClass:[UICollectionView class]]){
        isEndScrolling = YES;
        
        [self performSelector:@selector(regisTimerAgain) withObject:nil afterDelay:3.0];
    }

    
    //  NSLog(@"Page Number : %ld", (long)self.pageControl.currentPage);
}
-(void)regisTimerAgain{
    
    if(isEndScrolling && !timer){
    
        timer = [NSTimer scheduledTimerWithTimeInterval:3.0
                                                 target:self
                                               selector:@selector(autoNextPage)
                                               userInfo:nil
                                                repeats:YES];
    }
   
}
@end
