//
//  BookingsViewController.m
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "BookingsViewController.h"
#import "SlideMenuViewController.h"
#import "BookingManage.h"
#import "Booking.h"
#import "BookingOfMeCell.h"
#import "DetailSalonViewController.h"

#define LIMIT_ITEM @"14"

@interface BookingsViewController (){

    BOOL isFullData;
    NSInteger pageIndex;
}

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrBooking;
@end

@implementation BookingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    pageIndex = 1;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"BookingOfMeCell" bundle:nil] forCellReuseIdentifier:@"BookingOfMeCell"];
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    self.tblView.estimatedRowHeight = 68;
   
    [self getListBookingOfMe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

-(void)loadMore{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    
    [[BookingManage sharedInstance] getListBookingOfMe:[NSString stringWithFormat:@"%ld",pageIndex] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSArray *arrBooking = idObject;
        
        if(arrBooking.count > 0){
            
            [self.arrBooking addObjectsFromArray:arrBooking];
            
            NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                                sortDescriptorWithKey:@"startDate"
                                                ascending:NO];
            NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
            NSArray *arrSort = [self.arrBooking
                                sortedArrayUsingDescriptors:sortDescriptors];
            self.arrBooking = [NSMutableArray arrayWithArray:arrSort];
            
            [self.tblView reloadData];
            
            if(arrBooking.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
        }
        
    }];

}

-(void)getListBookingOfMe{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[BookingManage sharedInstance] getListBookingOfMe:@"1" limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        NSArray *arrBooking = idObject;
        
        if(arrBooking.count > 0){
            
            self.arrBooking = [NSMutableArray arrayWithArray:arrBooking];
            
            NSSortDescriptor *dateDescriptor = [NSSortDescriptor
                                                sortDescriptorWithKey:@"startDate"
                                                ascending:NO];
            NSArray *sortDescriptors = [NSArray arrayWithObject:dateDescriptor];
            NSArray *arrSort = [self.arrBooking
                                sortedArrayUsingDescriptors:sortDescriptors];
            self.arrBooking = [NSMutableArray arrayWithArray:arrSort];
            
            [self.tblView reloadData];
            
            if(arrBooking.count < LIMIT_ITEM.integerValue){
                
                isFullData = YES;
            }
        }
        else{
            
            [Common showAlert:self title:@"Thông báo" message:@"Bạn  chưa đặt chỗ" buttonClick:nil];
        }
        
    }];
    
}

- (IBAction)showMenu:(id)sender {
    
    [[SlideMenuViewController sharedInstance] toggle];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrBooking.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    BookingOfMeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BookingOfMeCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Booking *salon = [self.arrBooking objectAtIndex:indexPath.row];
    [cell setDataForCell:salon];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == self.arrBooking.count - 1 &&!isFullData){
        
        pageIndex ++;
        [self loadMore];
    }
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Booking *booking = [self.arrBooking objectAtIndex:indexPath.row];
    
    DetailSalonViewController *vcDetail = [[DetailSalonViewController alloc] initWithNibName:@"DetailSalonViewController" bundle:nil salon:booking.salon];
    
    [self.navigationController pushViewController:vcDetail animated:YES];
    
}
@end
