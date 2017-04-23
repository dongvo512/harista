//
//  CommentDetailView.m
//  hairista
//
//  Created by Dong Vo on 4/21/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CommentDetailView.h"
#import "CommentStarCell.h"
#import "StarRate.h"
#import "SalonManage.h"
#import "Salon.h"
#import "Comment.h"


@interface CommentDetailView ()<UIGestureRecognizerDelegate>{

    CGFloat widthItem;
    Salon *salonCurr;
    
    NSInteger countStarSelected;
}

@property (weak, nonatomic) IBOutlet UITextView *txtView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrStars;
@end

@implementation CommentDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(id)initWithFrame:(CGRect)frame salon:(Salon *)salon{

    self = [super initWithFrame:frame];
    
    if(self){
   
        salonCurr = salon;
        countStarSelected = 0;
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
    
    [self createListStar];
    
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
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         
                         [self setAlpha:0];
                         
                     }
                     completion:^(BOOL finished){
                         
                         [self removeFromSuperview];
                     }];
    [UIView commitAnimations];
}
- (IBAction)touchBtnSend:(id)sender {
    
    if([self checkValidate]){
        
        return;
    }
    
      [self.view endEditing:YES];
    
    [MBProgressHUD showHUDAddedTo:self animated:YES];
    
    [[SalonManage sharedInstance] sendMessage:salonCurr.idSalon message:self.txtView.text rate:[NSString stringWithFormat:@"%ld",(long)countStarSelected] dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self animated:YES];
        
        if(error){
        
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            Comment *comment = idObject;
            
            if(comment){
                
                comment.user = Appdelegate_hairista.sessionUser;
                
                if([[self delegate] respondsToSelector:@selector(commented:)]){
                
                    [[self delegate] commented:comment];
                }
            }
        }
        
        [UIView animateWithDuration:0.5
                         animations:^{
                             
                             [self setAlpha:0];
                             
                         }
                         completion:^(BOOL finished){
                             
                             [self removeFromSuperview];
                         }];
        [UIView commitAnimations];
        
    }];

}

-(BOOL)checkValidate{

    BOOL isValidate = NO;
    
    if(self.txtView.text.length == 0){
    
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Bạn chưa nhập bình luận" buttonClick:nil];
        isValidate = YES;
    }
    
    
    for(StarRate *star in self.arrStars){
        
        if(star.isSelected){
        
            countStarSelected ++;
        }
    }

    if(countStarSelected == 0){
    
         [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Bạn chưa chọn sao cho Salon" buttonClick:nil];
        
        isValidate = YES;
    }
    
    return isValidate;
}

-(void)createListStar{

    self.arrStars = [NSMutableArray array];
    
    for(int i = 0; i < 5; i++){
    
        StarRate *star = [[StarRate alloc] init];
        
        [self.arrStars addObject:star];
    }
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
   return self.arrStars.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentStarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CommentStarCell" forIndexPath:indexPath];
    
    StarRate *star = [self.arrStars objectAtIndex:indexPath.row];
    
    if(star.isSelected){
    
        [cell.imgStar setImage:[UIImage imageNamed:@"btn_star_larg_yellow"]];
    }
    else{
    
        [cell.imgStar setImage:[UIImage imageNamed:@"btn_star_larg_grey"]];
    }
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(widthItem, widthItem);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self updateStarWithIndex:indexPath.row];
}
-(void)updateStarWithIndex:(NSInteger)index{

    for(int i = 0; i <= index; i++){
    
        StarRate *star = [self.arrStars objectAtIndex:i];
        star.isSelected = YES;
    }
    
    for(NSInteger j = index; j < 4; j++){
    
        StarRate *star = [self.arrStars objectAtIndex:j + 1];
        star.isSelected = NO;
    }
    
    [self.collectionView reloadData];
}

@end
