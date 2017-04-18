//
//  ChangePassword.m
//  hairista
//
//  Created by Dong Vo on 4/9/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ChangePassword.h"
#import "AuthenticateManage.h"

@interface ChangePassword ()
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPassword;

@end

@implementation ChangePassword

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action


-(BOOL)checkValidate{

    BOOL isValidate = NO;
    
    if(self.tfPassword.text.length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Mật khẩu không được để trống" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.tfPassword becomeFirstResponder];
        }];

        isValidate = YES;
    }
    else if (self.tfConfirmPassword.text.length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Xác nhận mật khẩu không được để trống" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.tfConfirmPassword becomeFirstResponder];
        }];
        
        isValidate = YES;
    }
    else if (self.tfPassword.text.length < 6){
        
        [Common showAlert:self title:@"Thông báo" message:@"Mật khẩu phải ít nhất 6 chữ số" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.tfPassword becomeFirstResponder];
        }];
        
        isValidate = YES;
    }
    else if (self.tfConfirmPassword.text.length < 6){
        
        [Common showAlert:self title:@"Thông báo" message:@"Xác nhận mật khẩu phải ít nhất 6 chữ số" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.tfConfirmPassword becomeFirstResponder];
        }];
        
        isValidate = YES;
    }
    else if (![self.tfPassword.text isEqualToString:self.tfConfirmPassword.text]){
    
        [Common showAlert:self title:@"Thông báo" message:@"Mật khẩu và xác nhận mật khẩu phải giống nhau" buttonClick:nil];
        
        isValidate = YES;
    }
    
    
    return isValidate;

}

- (IBAction)touchBtnChangePassword:(id)sender {
    
    if([self checkValidate]){
    
        return;
    }
    
     [self.view endEditing:YES];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AuthenticateManage sharedInstance] changePassword:self.tfPassword.text confirmPassword:self.tfConfirmPassword.text dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            [Common showAlert:self title:@"Thông báo" message:@"Đổi mật khẩu thành công" buttonClick:^(UIAlertAction *alertAction) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }];
        }
        
    }];
    
}


- (IBAction)touchBtnPop:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
