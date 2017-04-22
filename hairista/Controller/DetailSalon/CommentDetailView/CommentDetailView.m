//
//  CommentDetailView.m
//  hairista
//
//  Created by Dong Vo on 4/21/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CommentDetailView.h"
#import "CommentStarCell.h"


@interface CommentDetailView ()<UIGestureRecognizerDelegate>{

    CGFloat widthItem;
}

@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation CommentDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    
    if(self){
    
        [self setup];
    }
    
    return self;
}

-(void)setup{
    
    self.view = [[NSBundle mainBundle] loadNibNamed:@"CommentDetailView" owner:self options:nil].firstObject;
    self.clipsToBounds = YES;
    self.view.frame = self.bounds;
    self.alpha = 0;

    [self addSubview:self.view];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    self.alpha = 1;
    [UIView commitAnimations];
    
    [self.txtView.layer setBorderWidth:0.5];
    [self.txtView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    self.txtView.layer.cornerRadius = 3.0;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"CommentStarCell" bundle:nil] forCellWithReuseIdentifier:@"CommentStarCell"];
    
    widthItem = (SW - 64) / 5;
    
}
#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    
    if([touch.view.superview isKindOfClass:[UICollectionViewCell class]] || [touch.view.superview.superview isKindOfClass:[UICollectionViewCell class]]) {
        
        return NO;
        
    }
    
    return YES;
}
#pragma mark - Action
- (IBAction)touchBackground:(id)sender {
    
    [self.view endEditing:YES];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:YES];
    [self removeFromSuperview];
    [UIView commitAnimations];

}
- (IBAction)touchBtnSend:(id)sender {
    
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
   return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentStarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentStarCell" forIndexPath:indexPath];
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(widthItem, widthItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
}
@end
