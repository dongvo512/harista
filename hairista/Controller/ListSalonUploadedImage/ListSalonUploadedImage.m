//
//  ListSalonUploadedImage.m
//  hairista
//
//  Created by Dong Vo on 5/25/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ListSalonUploadedImage.h"
#import "SalonManage.h"
#import "SalonCell.h"
#import "Salon.h"
#import "AlbumImageViewController.h"

@interface ListSalonUploadedImage ()

@property (nonatomic, strong) NSMutableArray *arrSalon;
@property (weak, nonatomic) IBOutlet UITableView *tblView;

@end

@implementation ListSalonUploadedImage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 59;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"SalonCell" bundle:nil] forCellReuseIdentifier:@"SalonCell"];
    
    [self getListSalonUploadedImage];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)touchBtnShowMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}

#pragma mark - Method
-(void)getListSalonUploadedImage{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListSalonUpdateImage:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            self.arrSalon = [NSMutableArray arrayWithArray:idObject];
            [self.tblView reloadData];
        }
        
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return  self.arrSalon.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SalonCell"];
    Salon *salon = [self.arrSalon objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setDataForCell:salon];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Salon *salon = [self.arrSalon objectAtIndex:indexPath.row];
    
    AlbumImageViewController *vcAlbumImage = [[AlbumImageViewController alloc] initWithNibName:@"AlbumImageViewController" bundle:nil salon:salon];
    
    [self.navigationController pushViewController:vcAlbumImage animated:YES];
    
}

@end
