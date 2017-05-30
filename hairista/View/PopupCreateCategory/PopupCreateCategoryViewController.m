//
//  PopupCreateCategoryViewController.m
//  hairista
//
//  Created by Dong Vo on 5/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "PopupCreateCategoryViewController.h"

@interface PopupCreateCategoryViewController (){

    BOOL isEditCurr;
    NSString *catNameCurr;
}
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITextField *tfCatName;

@end

@implementation PopupCreateCategoryViewController

#pragma mark - Init
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil edit:(BOOL)isEdit cateName:(NSString *)catName{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        isEditCurr = isEdit;
        catNameCurr = catName;
    }
    
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    if(isEditCurr){
    
        self.tfCatName.text = catNameCurr;
        self.lblTitle.text = @"Chỉnh sửa danh mục";
    }
    else{
    
        self.tfCatName.text = @"";
        self.lblTitle.text = @"Tạo danh mục";
    }
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - Action

- (IBAction)tapCancel:(UITapGestureRecognizer *)sender {
    
    [self dismissFromParentViewController];
}


- (IBAction)touchBtnFinish:(id)sender {
    
    if(self.tfCatName.text.length == 0){
    
        [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:@"Bạn chưa nhập tên cho danh mục mới" buttonClick:nil];
        
        return;
    }
    
    if([[self delegate] respondsToSelector:@selector(touchButtonFinish:edit:)]){
    
        [[self delegate] touchButtonFinish:self.tfCatName.text edit:isEditCurr];
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
}

@end
