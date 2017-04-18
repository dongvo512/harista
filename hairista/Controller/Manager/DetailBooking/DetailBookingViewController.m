//
//  DetailBookingViewController.m
//  hairista
//
//  Created by Dong Vo on 2/14/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "DetailBookingViewController.h"
#import "ServiceBookingCell.h"

#define HEIGHT_CELL_SERVICE 44


@interface DetailBookingViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *heightContraintService;

@end

@implementation DetailBookingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tblView registerNib:[UINib nibWithNibName:@"ServiceBookingCell" bundle:nil] forCellReuseIdentifier:@"ServiceBookingCell"];
    
    self.heightContraintService.constant = 3 * HEIGHT_CELL_SERVICE;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ServiceBookingCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceBookingCell"];
  //  Booking *booking = [self.arrBooking objectAtIndex:indexPath.row];
  //  [cell setDataForCell:booking];
    switch (indexPath.row) {
        case 0:
            cell.lblSerivceName.text = @"Cắt tóc";
            break;
            
        case 1:
            cell.lblSerivceName.text = @"Gội đầu";
            break;
            
        case 2:
            cell.lblSerivceName.text = @"Nhuộm";
            break;
            
        default:
            break;
    }
    
    return cell;
}
@end
