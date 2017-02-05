//
//  ServicesViewController.m
//  hairista
//
//  Created by Dong Vo on 2/4/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "ServicesViewController.h"
#import "GroupService.h"
#import "Service.h"
#import "ServiceCell.h"

@interface ServicesViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) NSMutableArray *arrGroupService;
@property (weak, nonatomic) IBOutlet UICollectionView *cllService;

@end

@implementation ServicesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self createDataTemp];
    
    [self.cllService registerNib:[UINib nibWithNibName:@"ServiceCell" bundle:nil] forCellWithReuseIdentifier:@"ServiceCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method
-(void)createDataTemp{

    self.arrGroupService = [NSMutableArray array];
    
    // Group 1
    GroupService *group_1 = [[GroupService alloc] init];
    group_1.groupServiceName = @"Cắt tóc";
    
    Service *service_1_1 = [[Service alloc] init];
    service_1_1.name = @"tóc hàn quốc";
    service_1_1.price = @"100.000";
    
    Service *service_1_2 = [[Service alloc] init];
    service_1_2.name = @"tóc ba bảy";
    service_1_2.price = @"120.000";
    
    Service *service_1_3 = [[Service alloc] init];
    service_1_3.name = @"tóc tầng";
    service_1_3.price = @"150.000";
    
    group_1.arrSerives = [NSArray arrayWithObjects:service_1_1,service_1_2, service_1_3, nil];
    
    
    // Group 2
    GroupService *group_2 = [[GroupService alloc] init];
    group_2.groupServiceName = @"Nhuộm tóc";
    
    Service *service_2_1 = [[Service alloc] init];
    service_2_1.name = @"tóc hàn quốc";
    service_2_1.price = @"100.000";
    
    Service *service_2_2 = [[Service alloc] init];
    service_2_2.name = @"tóc ba bảy";
    service_2_2.price = @"120.000";
    
    Service *service_2_3 = [[Service alloc] init];
    service_2_3.name = @"tóc tầng";
    service_2_3.price = @"150.000";
    
    group_2.arrSerives = [NSArray arrayWithObjects:service_2_1,service_2_2, service_2_3, nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

    return self.arrGroupService.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    GroupService *group = [self.arrGroupService objectAtIndex:section];
    
    return group.arrSerives.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    ServiceCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ServiceCell" forIndexPath:indexPath];
    
    return cell;
}

@end
