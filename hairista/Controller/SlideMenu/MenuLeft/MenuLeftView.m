//
//  MenuLeftView.m
//  hairista
//
//  Created by Dong Vo on 1/26/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "MenuLeftView.h"
#import "MenuCell.h"
#import "ItemMenu.h"
#import "SlideMenuViewController.h"
#import "UIColor+Method.h"

#define HEIGHT_CELL_MENU 60


@interface MenuLeftView ()

@property (weak, nonatomic) IBOutlet UITableView *tblViewMenu;
@property (nonatomic, strong) NSMutableArray *arrMenus;

@end

@implementation MenuLeftView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    
    if(self){
        
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if(self){
        
        [self setup];
    }
    
    return self;
}
- (id) init{

    self = [super init];
    
    if(self){
        
        [self setup];
    }
    
    return self;
}
- (void)setup{
    
     self.view = [[NSBundle mainBundle] loadNibNamed:@"MenuLeftView" owner:self options:nil].firstObject;
    self.clipsToBounds = YES;
    
    self.view.frame = self.bounds;
    
    [self addSubview:self.view];
    
    [self.tblViewMenu registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"MenuCell"];

    [self createListMenu];
    
}

#pragma mark - Method

- (IBAction)touchAvatar:(id)sender {
    
     [[SlideMenuViewController sharedInstance] selectedItemInMenu:4];
}


- (void)createListMenu{

    self.arrMenus = [NSMutableArray array];
    
    ItemMenu *item_1 = [[ItemMenu alloc] init];
    item_1.itemName = @"Salon tóc";
    item_1.itemIconName = @"ic_salon";
    
    [self.arrMenus addObject:item_1];
    
    ItemMenu *item_2 = [[ItemMenu alloc] init];
    item_2.itemName = @"Hình ảnh";
    item_2.itemIconName = @"ic_hair";
    
    [self.arrMenus addObject:item_2];

    
    ItemMenu *item_3 = [[ItemMenu alloc] init];
    item_3.itemName = @"Salon yêu thích";
    item_3.itemIconName = @"ic_favorite";
    
    [self.arrMenus addObject:item_3];
    
    ItemMenu *item_4 = [[ItemMenu alloc] init];
    item_4.itemName = @"Lịch hẹn";
    item_4.itemIconName = @"ic_booking";
    
    [self.arrMenus addObject:item_4];

    
    
}

#pragma mark - Table view DataSource - Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrMenus.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuCell"];
    
    ItemMenu *item = [self.arrMenus objectAtIndex:indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
   /* cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    UIView *bgColorView = [[UIView alloc] init];
    bgColorView.backgroundColor = [UIColor colorFromHexString:@"BF0A6A"];
    [cell setSelectedBackgroundView:bgColorView];*/
    [cell setDataForCell:item];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView
heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return HEIGHT_CELL_MENU;
    
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [[SlideMenuViewController sharedInstance] selectedItemInMenu:indexPath.row];
    
}

@end
