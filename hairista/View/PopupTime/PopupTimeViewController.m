//
//  PopupTimeViewController.m
//  hairista
//
//  Created by Dong Vo on 5/29/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "PopupTimeViewController.h"

@interface PopupTimeViewController (){

    NSDate *dateSelected;
}
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation PopupTimeViewController

#pragma mark - Init

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil dateSelected:(NSDate *)aDateSelected {

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        dateSelected = (aDateSelected)?aDateSelected:[NSDate date];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.datePicker setDate:dateSelected];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)tapBackground:(id)sender {
    
    [self dismissFromParentViewController];
}

- (IBAction)changeValue:(id)sender {
    
    dateSelected = self.datePicker.date;
}

- (IBAction)touchBtnFinish:(id)sender {
    
    if([[self delegate] respondsToSelector:@selector(touchButtonFinish:controller:)]){
    
        [[self delegate] touchButtonFinish:dateSelected controller:self];
    }
    
    [self dismissFromParentViewController];
}

- (void)presentInParentViewController:(UIViewController *)parentViewController {
    //[self.view removeFromSuperview];
    
    self.view.frame = parentViewController.view.bounds;
    [parentViewController.view addSubview:self.view];
    self.view.center = parentViewController.view.center;
    [parentViewController addChildViewController:self];
    
}

- (void)dismissFromParentViewController {
    
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
