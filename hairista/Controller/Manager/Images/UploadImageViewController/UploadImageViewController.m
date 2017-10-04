//
//  UploadImageViewController.m
//  hairista
//
//  Created by Dong Vo on 5/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "UploadImageViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "ELCImagePickerHeader.h"
#import "ImageUploadObject.h"
#import "ImageUpdateCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ImgurAnonymousAPIClient.h"
#import "SalonManage.h"
#import "QBImagePickerController.h"

@interface UploadImageViewController ()<ELCImagePickerControllerDelegate, QBImagePickerControllerDelegate>
{

    NSInteger countUpload;
}
@property (nonatomic, strong) NSMutableArray *arrImages;
@property (nonatomic, strong) NSMutableArray *arrProgress;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) PHImageRequestOptions *requestOptions;
@end

@implementation UploadImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.requestOptions = [[PHImageRequestOptions alloc] init];
    self.requestOptions.resizeMode   = PHImageRequestOptionsResizeModeExact;
    self.requestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
    
    // this one is key
    self.requestOptions.synchronous = true;

    
    self.arrImages = [NSMutableArray array];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"ImageUpdateCell" bundle:nil] forCellWithReuseIdentifier:@"ImageUpdateCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma marl - Action
- (IBAction)upload:(id)sender {
    
    countUpload = 0;
    
    if(self.arrImages.count > 0){
    
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
       // self.arrProgress = [NSMutableArray array];
      
        for(int i = 0; i < self.arrImages.count; i ++){
        
            ImageUploadObject *img = [self.arrImages objectAtIndex:i];
            
            NSData *data= nil;
            float imgValue = MAX(img.image.size.width, img.image.size.height);
            
            if(imgValue > 3000){
                
                data = UIImageJPEGRepresentation(img.image, 0.1);
            }
            
            else if(imgValue > 2000){
                
                data = UIImageJPEGRepresentation(img.image, 0.3);
            }
            else{
                
                data = UIImagePNGRepresentation(img.image);
            }
            
            NSString *base64 = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
            base64 = [NSString stringWithFormat:@"%@%@",@"data:image/jpeg;base64,",base64];
            
            img.urlImage = base64;
            
            [self uploadImageForSalon:img];
            
            //[progress setTotalUnitCount:1];
           // [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:NULL];
        }
    
    }
    else{
    
        [Common showAlert:self title:@"Thông báo" message:@"Bạn chưa chọn hình để upload" buttonClick:nil];
    }
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)uploadImageForSalon:(ImageUploadObject *)img{
    
    [[SalonManage sharedInstance] uploadUrlImageForSalon:img.urlImage name:img.name idSalon:Appdelegate_hairista.sessionUser.idUser.stringValue     dataResult:^(NSError *error, id idObject, NSString *strError) {
        
        if(error){
            
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:strError buttonClick:nil];
            
        }
        else{
        
            countUpload ++;
            
            if(countUpload == self.arrImages.count){
            
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
                [Common showAlert:self title:@"Thông báo" message:@"Hoàn tất upload hình ảnh" buttonClick:^(UIAlertAction *alertAction) {
                    
                    if([[self delegate] respondsToSelector:@selector(finishUploadImages:)]){
                        
                        [[self delegate] finishUploadImages:self];
                    }

                }];
            }
        }
        
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
        
        NSLog(@"%.21g",progress.fractionCompleted);
        
        if(progress.fractionCompleted <= 1){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                ImageUpdateCell *cell = (ImageUpdateCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[self.arrProgress indexOfObject:progress] inSection:0]];
                [cell updatingProgress:progress.fractionCompleted * 100];
                
            });
        }
        
    }
}
- (IBAction)touchBtnAddImage:(id)sender {
    
    QBImagePickerController *imagePickerController = [QBImagePickerController new]; imagePickerController.delegate = self;
    imagePickerController.mediaType = QBImagePickerMediaTypeImage;
    imagePickerController.allowsMultipleSelection = YES;
    imagePickerController.minimumNumberOfSelection = 1;
    imagePickerController.maximumNumberOfSelection = 5;
    imagePickerController.showsNumberOfSelectedAssets = YES;
    [self presentViewController:imagePickerController animated:YES completion:NULL];
    
//    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
//
//    elcPicker.maximumImagesCount = 10; //Set the maximum number of images to select to 100
//    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
//    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
//    elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
//    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage, (NSString *)kUTTypeMovie]; //Supports image and movie types
//
//    elcPicker.imagePickerDelegate = self;
//
//    [self presentViewController:elcPicker animated:YES completion:nil];
}

#pragma mark - QBImagePickerControllerDelegate

- (void)qb_imagePickerController:(QBImagePickerController *)imagePickerController didFinishPickingAssets:(NSArray *)assets {
  
    PHImageManager *manager = [PHImageManager defaultManager];

    for (PHAsset *asset in assets) {
        // Do something with the asset
        [manager requestImageForAsset:asset
                           targetSize:PHImageManagerMaximumSize
                          contentMode:PHImageContentModeDefault
                              options:self.requestOptions
                        resultHandler:^void(UIImage *image, NSDictionary *info) {
                            
                            ImageUploadObject *imageOjb = [[ImageUploadObject alloc] init];
                            imageOjb.image = image;
                            imageOjb.name = @"Hình salon";
                            [self.arrImages addObject:imageOjb];
                        }];

    }
    
    [self.collectionView reloadData];
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)qb_imagePickerControllerDidCancel:(QBImagePickerController *)imagePickerController{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
}
//#pragma mark ELCImagePickerControllerDelegate Methods
//
//- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//
//
//    for (NSDictionary *dict in info) {
//        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
//            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
//
//                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
//
//                ImageUploadObject *imageOjb = [[ImageUploadObject alloc] init];
//                imageOjb.image = image;
//                imageOjb.name = @"Hình salon";
//                [self.arrImages addObject:imageOjb];
//
//
//            } else {
//                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
//            }
//        } else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo){
//            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
//
//                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
//
//                ImageUploadObject *imageOjb = [[ImageUploadObject alloc] init];
//                imageOjb.image = image;
//                imageOjb.name = @"Hình salon";
//                [self.arrImages addObject:imageOjb];
//
//
//            } else {
//                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
//            }
//        } else {
//            NSLog(@"Uknown asset type");
//        }
//    }
//
//    [self.collectionView reloadData];
//}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UICollectionViewDataSource - Delegate

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.arrImages.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
//    ImageUploadObject *image = [self.arrImages objectAtIndex:indexPath.row];
//    
//    HairFullView *hairFull = [[HairFullView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) imgName:image.url title:image.name];
//    
//    [UIView transitionWithView:self.view duration:0.5
//                       options:UIViewAnimationOptionTransitionCrossDissolve //change to whatever animation you like
//                    animations:^ { [[[SlideMenuViewController sharedInstance] view] addSubview:hairFull];
//                        
//                    }
//                    completion:nil];
//    
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ImageUpdateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageUpdateCell" forIndexPath:indexPath];
    
    ImageUploadObject *img = [self.arrImages objectAtIndex:indexPath.row];
    
     [cell setDataForCell:img];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return CGSizeMake((SW -24)/2, (SW -24)/2 + 30);
}

@end
