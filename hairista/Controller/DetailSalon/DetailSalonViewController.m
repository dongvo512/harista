//
//  DetailSalonViewController.m
//  hairista
//
//  Created by Dong Vo on 2/2/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

// Dong vo

#import "DetailSalonViewController.h"
#import "Salon.h"
#import "CatagoriesHairViewController.h"
#import "ServicesViewController.h"
#import "ImagePickerViewController.h"
#import "CommentViewController.h"
#import "BookingViewController.h"
#import "SalonManage.h"
#import "DKScrollingTabController.h"
#import "UIColor+Method.h"
#import "SalonDetailViewController.h"
#import "ImgurAnonymousAPIClient.h"
#import "ChooseImageView.h"


@interface DetailSalonViewController ()<ImagePickerViewControllerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{

    Salon *salon;
    ImagePickerViewController *vcImagePicker;
    DKScrollingTabController *tabController;
}
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollMaster;

@property (nonatomic, strong) SalonDetailViewController *vcSalonDetal;
@property (nonatomic, strong) CommentViewController *vcComment;
@property (nonatomic, strong) ServicesViewController *vcService;
@property (nonatomic, strong) NSArray *arrViews;

@end

@implementation DetailSalonViewController

#pragma mark - Init
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salon:(Salon *)aSalon{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        salon = aSalon;
    }
    
    return self;
}

#pragma mark - CircleView
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createTabSalon];
    
    [self loadTabbar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)touchBtnCamera:(id)sender {
    
    if(!vcImagePicker){
        
        vcImagePicker = [[ImagePickerViewController alloc] init];
        vcImagePicker.delegateImg = self;
    }
    
    [vcImagePicker takeAPickture:self];

}

#pragma mark - Method

- (void)createTabSalon{
    
    self.vcSalonDetal = [[SalonDetailViewController alloc] initWithNibName:@"SalonDetailViewController" bundle:nil salon:salon];
    
    self.vcComment = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
    
    self.vcService = [[ServicesViewController alloc] initWithNibName:@"ServicesViewController" bundle:nil];
    
}


- (void)configUI{
    
    tabController = [[DKScrollingTabController alloc] init];
    [self addChildViewController:tabController];
    tabController.view.backgroundColor = [UIColor whiteColor];
    tabController.translucent = YES;
    [tabController didMoveToParentViewController:self];
    [self.tabView addSubview:tabController.view];
    tabController.view.frame = self.tabView.bounds;
    
    CGRect frame = tabController.toolbar.frame;
    //        frame.size.width = 12000;
    tabController.toolbar.frame = frame;
    tabController.buttonPadding = 25;
    tabController.buttonsScrollView.showsHorizontalScrollIndicator = NO;
    tabController.selectionFont = [UIFont fontWithName:FONT_ROBOTO_MEDIUM size:15];
    tabController.buttonInset = 0;
    tabController.buttonPadding = 20;
    tabController.firstButtonInset = 0;
    tabController.selectedTextColor = [UIColor colorFromHexString:@"BF0A6A"];
    tabController.selection = @[@"Salon", @"Dịch vụ", @"Bình luận"];
    tabController.buttonsScrollView.decelerationRate = 0.5;
    tabController.delegate = self;
    tabController.underlineIndicator = YES;
    [tabController selectButtonWithIndex:0];
}


#pragma mark - Getdata

//-(void)getDetailSalon{
//
//    [[SalonManage sharedInstance] getDetailSalon:salon.idSalon dataResult:^(NSError *error, id idObject) {
//        
//        if(error){
//        
//            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
//        }
//        else{
//        
//            
//        }
//    }];
//    
//}



#pragma mark - DKScrollingTabControllerDelegate
- (void)ScrollingTabController:(DKScrollingTabController*)controller selection:(NSUInteger)selection{
    
    CGPoint scrollPoint = CGPointMake(selection * self.scrollMaster.frame.size.width, 0);
    [self.scrollMaster setContentOffset:scrollPoint animated:YES];
}

#pragma mark - UIScrollView Delegate
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
    if (self.scrollMaster == scrollView) {
        if (!decelerate) {
            int index = scrollView.contentOffset.x/scrollView.frame.size.width;
            [tabController selectButtonWithIndex:index];
        }
        
    }
    
}// called when scroll view grinds to a halt
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.scrollMaster) {
        int index = scrollView.contentOffset.x/scrollView.frame.size.width;
        [tabController selectButtonWithIndex:index];
    }
    
}

-(void)loadTabbar{
    
    [self configUI];
    
    self.arrViews = [NSArray arrayWithObjects:self.vcSalonDetal.view, self.vcService.view, self.vcComment.view, nil];
    
    for (int i = 0 ; i< self.arrViews.count;i++) {
        
        UIView * view = self.arrViews[i];
        CGRect frame = CGRectMake(0, 0, self.scrollMaster.frame.size.width, self.scrollMaster.frame.size.height);
        frame.origin.x = self.scrollMaster.frame.size.width * i;
        view.frame = frame;
        
        [self.scrollMaster addSubview:view];
        
    }
    
    UIView * line = [[UIView alloc]initWithFrame:CGRectMake(0, tabController.view.frame.size.height, self.tabView.frame.size.width, 1)];
    [line setBackgroundColor:[UIColor grayBorder]];
    [self.tabView addSubview:line];
    
    self.scrollMaster.contentSize = CGSizeMake(self.scrollMaster.frame.size.width * tabController.selection.count,self.scrollMaster.frame.size.height);
    
}
- (IBAction)touchBooking:(id)sender {
    
    BookingViewController *vcBooking = [[BookingViewController alloc] initWithNibName:@"BookingViewController" bundle:nil];
    [self.navigationController pushViewController:vcBooking animated:YES];
}


- (IBAction)takePhoto:(id)sender {
    
    if(!vcImagePicker){
    
        vcImagePicker = [[ImagePickerViewController alloc] init];
        vcImagePicker.delegateImg = self;
    }
    
    [vcImagePicker takeAPickture:self];
}

- (IBAction)touchComments:(id)sender {
    
    CommentViewController *vcCommets = [[CommentViewController alloc] initWithNibName:@"CommentViewController" bundle:nil];
    [self.navigationController pushViewController:vcCommets animated:YES];
}

- (IBAction)touchSerices:(id)sender {
    
    ServicesViewController *vcServices = [[ServicesViewController alloc] initWithNibName:@"ServicesViewController" bundle:nil];
    [self.navigationController pushViewController:vcServices animated:YES];
}

- (IBAction)touchCatagoriesHair:(id)sender {
    
    CatagoriesHairViewController *vcCatagoriesHair = [[CatagoriesHairViewController alloc] initWithNibName:@"CatagoriesHairViewController" bundle:nil];
    
    [self.navigationController pushViewController:vcCatagoriesHair animated:YES];
    
}


- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - ImagePickerViewControllerDelegate

- (void)finishGetImage:(NSString *)fileName
                 image:(UIImage *)image{
    
  //  self.imgAvatar.image = image;
    
    ChooseImageView *chooseImageView = [[ChooseImageView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) imgName:fileName image:image salon:salon];
    
    [UIView transitionWithView:self.view duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
                    animations:^ {
                        [self.view addSubview:chooseImageView];
                        
                    }
                    completion:nil];
//    NSData *data= nil;
//    float imgValue = MAX(image.size.width, image.size.height);
//    
//    if(imgValue > 3000){
//        
//        data = UIImageJPEGRepresentation(image, 0.1);
//    }
//    
//    else if(imgValue > 2000){
//        
//        data = UIImageJPEGRepresentation(image, 0.3);
//    }
//    else{
//        
//        data = UIImagePNGRepresentation(image);
//    }
//    
//    Appdelegate_hairista.progressCurr =  [[ImgurAnonymousAPIClient client] uploadImageData:data
//                                                                              withFilename:@"image.jpg"
//                                                                         completionHandler:^(NSURL *imgurURL, NSError *error) {
//                                                                             
//                                                                             [Appdelegate_hairista closeProgress];
//                                                                             
////                                                                             strUrlAvart = imgurURL.absoluteString;
////                                                                             
////                                                                             [self uploadImagUrl:strUrlAvart];
//                                                                             
//                                                                         }];
//    [Appdelegate_hairista showProcessBar:image];
//    
    
    //[progress cancel];
    
}
@end
