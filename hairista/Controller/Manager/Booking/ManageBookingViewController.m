//
//  ManageBookingViewController.m
//  hairista
//
//  Created by Dong Vo on 2/12/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ManageBookingViewController.h"
#import "DKScrollingTabController.h"
#import "UIColor+Method.h"
#import "CommonDefine.h"
#import "ManageListBookingViewController.h"
#import "SlideMenuViewController.h"

typedef NS_ENUM(NSInteger, TypeBooking) {
    
    Today = 0,
    InWeek,
    InMonth
};

@interface ManageBookingViewController (){

    DKScrollingTabController *tabController;
}
@property (nonatomic, strong) ManageListBookingViewController *vcBookingToday;
@property (nonatomic, strong) ManageListBookingViewController *vcBookingInWeek;
@property (nonatomic, strong) ManageListBookingViewController *vcBookingInMonth;
@property (nonatomic, strong) NSArray *arrViews;

@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollMaster;

@end

@implementation ManageBookingViewController

static ManageBookingViewController *sharedInstance = nil;
+ (id)sharedInstance {
    
    @synchronized(self) {
        if (sharedInstance == nil) {
            sharedInstance = [[ManageBookingViewController alloc] initWithNibName:@"ManageBookingViewController" bundle:nil];
            
        }
        return sharedInstance;
    }
    
}

#pragma mark - CircleView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createListBooking];
    
    [self performSelector:@selector(loadTabbar) withObject:nil afterDelay:0.1];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
- (IBAction)touchMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
    
}

- (void)createListBooking{

    self.vcBookingToday = [[ManageListBookingViewController alloc] initWithNibName:@"ManageListBookingViewController" bundle:nil type:Today];
    self.vcBookingToday.vcManageBooking = self;
    
    self.vcBookingInWeek = [[ManageListBookingViewController alloc] initWithNibName:@"ManageListBookingViewController" bundle:nil type:InWeek];
    self.vcBookingInWeek.vcManageBooking = self;

    
    self.vcBookingInMonth = [[ManageListBookingViewController alloc] initWithNibName:@"ManageListBookingViewController" bundle:nil type:InMonth];
    self.vcBookingInMonth.vcManageBooking = self;
    
    
}

-(void)loadTabbar{

     [self configUI];
    
    self.arrViews = [NSArray arrayWithObjects:self.vcBookingToday.view, self.vcBookingInWeek.view, self.vcBookingInMonth.view, nil];
    
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
    tabController.selection = @[@"Hôm nay", @"Trong tuần", @"Trong tháng"];
    tabController.buttonsScrollView.decelerationRate = 0.5;
    tabController.delegate = self;
    tabController.underlineIndicator = YES;
    [tabController selectButtonWithIndex:0];
}
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



@end
