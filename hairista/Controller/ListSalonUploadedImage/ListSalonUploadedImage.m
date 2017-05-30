//
//  ListSalonUploadedImage.m
//  hairista
//
//  Created by Dong Vo on 5/25/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ListSalonUploadedImage.h"
#import "SalonManage.h"

@interface ListSalonUploadedImage ()
@property (nonatomic, strong) NSMutableArray *arrSalon;
@end

@implementation ListSalonUploadedImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self getListSalonUploadedImage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
-(void)getListSalonUploadedImage{

    [[SalonManage sharedInstance] getListSalonUpdateImage:^(NSError *error, id idObject) {
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            self.arrSalon = [NSMutableArray arrayWithArray:idObject];
        }
        
    }];
}

@end
