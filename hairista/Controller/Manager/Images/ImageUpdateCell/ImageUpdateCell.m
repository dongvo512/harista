//
//  ImageUpdateCell.m
//  hairista
//
//  Created by Dong Vo on 5/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ImageUpdateCell.h"
#import "ImageUploadObject.h"

@interface ImageUpdateCell ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UITextField *tfName;
@property (weak, nonatomic) IBOutlet UIView *viewUpload;

@property (weak, nonatomic) IBOutlet MBCircularProgressBarView *viewProgress;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewError;
@property (nonatomic, weak) ImageUploadObject *imgCurr;

@end

@implementation ImageUpdateCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 4; // if you like rounded corners
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowRadius = 5;
    self.layer.shadowOpacity = 0.2;
    self.tfName.delegate = self;
}

-(void)setDataForCell:(ImageUploadObject *)image{

    self.imgCurr = image;
    [self.imgView setImage:image.image];
    self.tfName.text = image.name;
}

-(void)updatingProgress:(NSInteger)value{

    [self.viewUpload setHidden:NO];
    self.viewProgress.value = value;
}
-(void)showError{

    [self.viewProgress setHidden:YES];
    [self.imgViewError setHidden:NO];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{

    self.imgCurr.name = textField.text;
}
@end
