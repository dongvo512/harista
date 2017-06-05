//
//  RegisterViewController.m
//  hairista
//
//  Created by Dong Vo on 4/5/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "RegisterViewController.h"
#import "AuthenticateManage.h"


@interface RegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tfPhone;
@property (weak, nonatomic) IBOutlet UITextField *tfPassword;
@property (weak, nonatomic) IBOutlet UITextField *tfConfirmPass;
@property (weak, nonatomic) IBOutlet UITextField *tfFullName;
@property (weak, nonatomic) IBOutlet UITextField *tfEmail;
@property (weak, nonatomic) IBOutlet UITextField *tfAddress;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)touchBackBtn:(id)sender {
    
     [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

-(BOOL)checkValidate{

    BOOL isValidate = NO;
    
    if(self.tfPhone.text.length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Số điện thoại không được để trống" buttonClick:^(UIAlertAction *alertAction) {
            [self.tfPhone becomeFirstResponder];
        }];
        
        isValidate = YES;
    }
    else if (self.tfPhone.text.length > 11 || self.tfPhone.text.length < 10){
    
        [Common showAlert:self title:@"Thông báo" message:@"Số điện thoại 10 hoặc 11 số" buttonClick:^(UIAlertAction *alertAction) {
            [self.tfPhone becomeFirstResponder];
        }];
        
        isValidate = YES;

    }
    else if (self.tfPassword.text.length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Mật khẩu không được để trống" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.tfPassword becomeFirstResponder];
        }];
        
        isValidate = YES;

    }
    else if (self.tfPassword.text.length < 6){
        
        [Common showAlert:self title:@"Thông báo" message:@"Mật khẩu phải ít nhất 6 chữ số" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.tfPassword becomeFirstResponder];
        }];
        
        isValidate = YES;
        
    }
    else if (self.tfConfirmPass.text.length == 0){
    
        [Common showAlert:self title:@"Thông báo" message:@"Xác nhận mật khẩu không được để trống" buttonClick:^(UIAlertAction *alertAction) {
            
            [self.tfConfirmPass becomeFirstResponder];
        }];
        
        isValidate = YES;

    }
    else if (![self.tfConfirmPass.text isEqualToString:self.tfPassword.text]){
        
        [Common showAlert:self title:@"Thông báo" message:@"Mật khẩu và xác nhận mật khẩu phải trùng nhau" buttonClick:nil];
        
        isValidate = YES;
        
    }
    else if (self.tfFullName.text.length == 0){
        
        [Common showAlert:self title:@"Thông báo" message:@"Họ và tên không được để trống" buttonClick:nil];
        
        isValidate = YES;
        
    }
    else if (self.tfEmail.text.length == 0){
        
        [Common showAlert:self title:@"Thông báo" message:@"Email không được để trống" buttonClick:nil];
        
        isValidate = YES;
        
    }
    else if (![Common  validateEmailAddress:self.tfEmail.text]){
    
        [Common showAlert:self title:@"Thông báo" message:@"Email đúng định dạng (ví dụ: abc@gmail.com)" buttonClick:nil];
        
        isValidate = YES;
    }
    else if (self.tfAddress.text.length == 0){
        
        [Common showAlert:self title:@"Thông báo" message:@"Địa chỉ không được để trống" buttonClick:nil];
        
        isValidate = YES;
        
    }
    
    return isValidate;
}
-(NSString *)changePhoneNumber{
    
    NSString *strNewPhone;
    
    if ([self.tfPhone.text hasPrefix:@"0"] && [self.tfPhone.text length] > 1) {
        
        strNewPhone = [NSString stringWithFormat:@"+84%@",[self.tfPhone.text substringFromIndex:1]];
    }
    else{
    
        strNewPhone = self.tfPhone.text;
    }
    
    
    return strNewPhone;
}
- (IBAction)touchBtnComplete:(id)sender {
    
    if([self checkValidate]){
    
        return;
    }
    
     [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *dicBody = @{@"phone":[self changePhoneNumber],@"password":self.tfPassword.text,@"password_confirmation":self.tfConfirmPass.text,@"name":self.tfFullName.text,@"email":self.tfEmail.text,@"homeAddress":self.tfAddress.text};
    
    [[AuthenticateManage sharedInstance] registerUser:dicBody dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
           [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:^(UIAlertAction *alertAction) {
               
           }];
            
        }
        else{
        
            [Common showAlert:self title:@"Thông báo" message:@"Đăng ký thành công" buttonClick:^(UIAlertAction *alertAction) {
                
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        }
        
    }];
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
