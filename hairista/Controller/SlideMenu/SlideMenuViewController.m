//
//  SlideMenuViewController.m
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "SlideMenuViewController.h"
#import "FindSalonViewController.h"
#import "MenuLeftView.h"
#import "CommonDefine.h"
#import "UserInfoViewController.h"
#import "FavoriteViewController.h"
#import "BookingsViewController.h"
#import "ManageBookingViewController.h"
#import "ListUserViewController.h"
#import "EditServiceViewController.h"
#import "ImagesViewController.h"
#import "ListSalonUploadedImage.h"
#import "CommentController.h"
#import "SalonsAdminViewController.h"
#import "UserAdminViewController.h"


@interface SlideMenuViewController ()<UIGestureRecognizerDelegate>{

    UINavigationController *vcNavigation;
    
    NSLayoutConstraint *leftContraint;
    
    UIView *viewBackground;
    
    CGFloat ratioWidthMenuLeft;
    
    NSInteger indexSelectedCurr;
}

@property (weak, nonatomic) IBOutlet UIView *viewContent;

@end

@implementation SlideMenuViewController

static SlideMenuViewController *sharedInstance = nil;
+ (id)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[SlideMenuViewController alloc] initWithNibName:@"SlideMenuViewController" bundle:nil];
            
        }
        return sharedInstance;
    }
    
}

+ (void)resetSharedInstance {
    
    @synchronized(self) {
        
        sharedInstance = nil;
        
    }
}


#pragma mark - Init
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        ratioWidthMenuLeft = 0.75;
    }
    
    return self;
}

#pragma mark - CircleView
- (void)viewDidLoad {
    [super viewDidLoad];
    
    indexSelectedCurr = Item_Salon;
    
    [self createNavigationContent];
    [self createBackgroundView];
    [self createMenuLeft];
    [self addSwipeGestureForViewContent];
   // [self addPanGestureForViewContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

- (void)selectItemMemeber:(NSInteger)index{

    switch (index) {
            
        case Item_Salon:{
            
            FindSalonViewController *vcFindSalon = [FindSalonViewController sharedInstance];
            [vcNavigation setViewControllers:@[vcFindSalon] animated:YES];
        }
            break;
            
        case Item_Images:{
            
            ListSalonUploadedImage *vcAlbumImage = [[ListSalonUploadedImage alloc] initWithNibName:@"ListSalonUploadedImage" bundle:nil];
            [vcNavigation setViewControllers:@[vcAlbumImage] animated:YES];
        }
            break;
            
        case Item_Favorite:{
            
            FavoriteViewController *vcFavorite = [[FavoriteViewController alloc] initWithNibName:@"FavoriteViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcFavorite] animated:YES];
        }
            break;
        case Item_Bookings:{
            
            BookingsViewController *vcBooking = [[BookingsViewController alloc] initWithNibName:@"BookingsViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcBooking] animated:YES];
        }
            break;
            
        case Item_InfoUser:{
            
            UserInfoViewController *vcUpdateUser = [[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcUpdateUser] animated:YES];
        }
            break;
            
        default:
            break;
    }

}

- (void)selectItemAdmin:(NSInteger)index{

    switch (index) {
            
        case ItemAdminSalon:{
            
            SalonsAdminViewController *vcSalon = [[SalonsAdminViewController alloc] initWithNibName:@"SalonsAdminViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcSalon] animated:YES];
        }
            break;
        case ItemAdminUser:{
            
            UserAdminViewController *vcUser = [[UserAdminViewController alloc] initWithNibName:@"UserAdminViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcUser] animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)selectItemManager:(NSInteger)index{

    switch (index) {
            
        case ItemManagerBooking:{
            
            ManageBookingViewController *vcManageBooking = [ManageBookingViewController sharedInstance];
            [vcNavigation setViewControllers:@[vcManageBooking] animated:YES];
        }
            break;
        case ItemMangeUser:{
            
            ListUserViewController *vcManageListUser = [[ListUserViewController alloc] initWithNibName:@"ListUserViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcManageListUser] animated:YES];
        }
            break;
        case ItemManageService:{
            
            EditServiceViewController *vcEditService = [[EditServiceViewController alloc] initWithNibName:@"EditServiceViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcEditService] animated:YES];
        }
            break;
        case Item_Image:{
            
            ImagesViewController *vcImage = [[ImagesViewController alloc] initWithNibName:@"ImagesViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcImage] animated:YES];
        }
            break;
        case Item_Comment:{
            
            CommentController *vcComment = [[CommentController alloc] initWithNibName:@"CommentController" bundle:nil];
            [vcNavigation setViewControllers:@[vcComment] animated:YES];
        }
            break;
        case Item_InFoUserManger:{
            
            UserInfoViewController *vcUpdateUser = [[UserInfoViewController alloc] initWithNibName:@"UserInfoViewController" bundle:nil];
            [vcNavigation setViewControllers:@[vcUpdateUser] animated:YES];
        }
            break;
       
        default:
            break;
    }

}

- (void)selectedItemInMenu:(NSInteger )index{

    if(index == indexSelectedCurr){
    
        [self toggle];
        return;
    }
    
    if(self.isUserManager){
    
        [self selectItemManager:index];
    }
    else if (self.isAdmin){
        
        [self selectItemAdmin:index];
    }
    else{
    
        [self selectItemMemeber:index];
    }
  
    indexSelectedCurr = index;
    
    [self toggle];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
- (void)addSwipeGestureForViewContent{

    UISwipeGestureRecognizer *swipeRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(toggle)];
    [self.view addGestureRecognizer:swipeRecognizer];
}

-(void)setRatioWidthMenuLeft:(CGFloat)ratio{
    
    ratioWidthMenuLeft = ratio;
}

- (void)toggle{

    if(leftContraint.constant == 0){
    
        leftContraint.constant = -(SW*ratioWidthMenuLeft);
        
    }
    else{
    
        leftContraint.constant = 0;
        
    }
    
    [UIView animateWithDuration:0.3 animations:^{
       
        [self.view layoutIfNeeded];
        
        if(leftContraint.constant == 0){
            
            [viewBackground setAlpha:1.0];
           
        }
        else{
            
            [viewBackground setAlpha:0];
        }
        
    } completion:nil];
    
}

- (void)createNavigationContent{

    if(self.isUserManager){
    
        ManageBookingViewController *vcManageBooking = [[ManageBookingViewController alloc] initWithNibName:@"ManageBookingViewController" bundle:nil];
      
        vcNavigation = [[UINavigationController alloc] initWithRootViewController:vcManageBooking];
        vcNavigation.navigationBarHidden = YES;
        vcNavigation.view.frame = self.view.bounds;
        
        [self.view addSubview:vcNavigation.view];
    }
    else if (self.isAdmin){
    
        SalonsAdminViewController *vcSalon = [[SalonsAdminViewController alloc] initWithNibName:@"SalonsAdminViewController" bundle:nil];
        vcNavigation = [[UINavigationController alloc] initWithRootViewController:vcSalon];
        vcNavigation.navigationBarHidden = YES;
        vcNavigation.view.frame = self.view.bounds;
        
        [self.view addSubview:vcNavigation.view];
    }
    else{
    
        FindSalonViewController *vcListSalon = [[FindSalonViewController alloc] initWithNibName:@"FindSalonViewController" bundle:nil];
        
        vcNavigation = [[UINavigationController alloc] initWithRootViewController:vcListSalon];
        vcNavigation.navigationBarHidden = YES;
        vcNavigation.view.frame = self.view.bounds;
        
        [self.view addSubview:vcNavigation.view];

    }
    
}

- (void)createBackgroundView{

    viewBackground = [[UIView alloc] init];
    
    viewBackground.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
  
    [viewBackground setTranslatesAutoresizingMaskIntoConstraints:NO];
    [viewBackground setAlpha:0];
    
    UITapGestureRecognizer *singleFingerTap =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(handleSingleTap:)];
    [viewBackground addGestureRecognizer:singleFingerTap];
    

    
    [self.view addSubview:viewBackground];
    
    leftContraint = [NSLayoutConstraint constraintWithItem:viewBackground attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1  constant:0];
    
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:viewBackground attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *right = [NSLayoutConstraint constraintWithItem:viewBackground attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1 constant:0];
    
    NSLayoutConstraint *bottom = [NSLayoutConstraint constraintWithItem:viewBackground attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    
    [self.view addConstraints:@[leftContraint, top, right, bottom]];
    
}

-(void)createMenuLeft{

    self.viewMenuLeft = [[MenuLeftView alloc] init:self.isUserManager isAdmin:self.isAdmin];

    self.viewMenuLeft.backgroundColor = [UIColor whiteColor];

    [self.viewMenuLeft setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addSubview:self.viewMenuLeft];
    
     leftContraint = [NSLayoutConstraint constraintWithItem:self.viewMenuLeft attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1  constant:-(SW*ratioWidthMenuLeft)];
  
    NSLayoutConstraint *top = [NSLayoutConstraint constraintWithItem:self.viewMenuLeft attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    
    NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:self.viewMenuLeft attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1     constant:0];
    NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.viewMenuLeft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:ratioWidthMenuLeft constant:0];
    
    [self.view addConstraints:@[leftContraint, top, height, width]];
   
    
}
- (void)handleSingleTap:(UITapGestureRecognizer *)recognizer {
   
    [self toggle];
}

@end
