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

@property (nonatomic, strong) NSMutableArray *arrSalonsHeader;


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

- (id)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        [self setup];
    }
    return self;
}

#pragma mark - Method

-(void)createListSalonBanner{

    self.arrSalonsHeader = [NSMutableArray array];
    
    Salon *salon_1 = [[Salon alloc] init];
    salon_1.strPhone = @"0932188608";
    salon_1.strSalonName = @"Salon Đông Võ";
    salon_1.openTime = @"8:30 - 17:30";
    salon_1.strSalonUrl = @"salon_1";
    [self.arrSalonsHeader addObject:salon_1];
    
    Salon *salon_2 = [[Salon alloc] init];
    salon_2.strPhone = @"0922313456";
    salon_2.strSalonName = @"Salon Duy Hưng";
    salon_2.openTime = @"7:30 - 19:30";
    salon_2.strSalonUrl = @"salon_2";
    [self.arrSalonsHeader addObject:salon_2];
    
    Salon *salon_3 = [[Salon alloc] init];
    salon_3.strPhone = @"099987888";
    salon_3.strSalonName = @"Salon Sa Võ";
    salon_3.openTime = @"8:30 - 17:30";
    salon_3.strSalonUrl = @"salon_3";
    [self.arrSalonsHeader addObject:salon_3];
    
    Salon *salon_4 = [[Salon alloc] init];
    salon_4.strPhone = @"0921122333";
    salon_4.strSalonName = @"Salon Beautyfull Hair";
    salon_4.openTime = @"10:30 - 17:30";
    salon_4.strSalonUrl = @"salon_4";
    [self.arrSalonsHeader addObject:salon_4];
    
    Salon *salon_5 = [[Salon alloc] init];
    salon_5.strPhone = @"099878800";
    salon_5.strSalonName = @"Salon Beautyfull Hair 2";
    salon_5.openTime = @"8:30 - 17:30";
    salon_5.strSalonUrl = @"salon_5";
    [self.arrSalonsHeader addObject:salon_5];
    
}

- (void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"HeaderBannerView" owner:self options:nil].firstObject;
    
    self.view.frame = self.bounds;
    [self addSubview:self.view];
    
    [self.cllBannerSalon registerNib:[UINib nibWithNibName:@"HeaderBannerCell" bundle:nil] forCellWithReuseIdentifier:@"HeaderBannerCell"];
    
    [self createListSalonBanner];
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
