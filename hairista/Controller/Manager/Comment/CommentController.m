//
//  CommentController.m
//  hairista
//
//  Created by Dong Vo on 5/31/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CommentController.h"
#import "CommentCellTableViewCell.h"
#import "SalonManage.h"
#import "Comment.h"

#define LIMIT_ITEM @"14"

@interface CommentController (){

    NSInteger pageIndex;
    
    BOOL isFullData;
    
    BOOL isLoading;
}

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrComments;

@end

@implementation CommentController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.arrComments = [NSMutableArray array];
    
    self.tblView.estimatedRowHeight = 80;
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    
    [self.tblView registerNib:[UINib nibWithNibName:@"CommentCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    
    pageIndex = 1;
    
    [self getListComment];
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

-(void)deleteComment:(Comment *)comment{

    [[SalonManage sharedInstance] deleteComment:comment.idComment dataApiResult:^(NSError *error, id idObject) {
        
        if(error){
        
            [Common showAlert:self title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
        
            [Common showAlert:self title:@"Thông báo" message:@"Đã xoá bình luận thành công" buttonClick:nil];
            
            NSInteger indexObj = [self.arrComments indexOfObject:comment];
            
            [self.arrComments removeObject:comment];
            [self.tblView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:indexObj inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
        }
    }];
}

-(void)getListComment{
    
    isLoading = YES;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[SalonManage sharedInstance] getListCommentSalon:Appdelegate_hairista.sessionUser.idUser page:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject) {
        
        isLoading = NO;
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
            
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:error.localizedDescription buttonClick:nil];
        }
        else{
            
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
                
                [self.arrComments addObjectsFromArray:arrData];
                
                [self.tblView reloadData];
            }
            
            if(arrData.count > LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
            
        }
    }];
    
}

#pragma mark - Table view DataSource - Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrComments.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CommentCell"];
    Comment *comment = [self.arrComments objectAtIndex:indexPath.row];
    [cell setDataForCell:comment];
    
    if(indexPath.row == self.arrComments.count - 1 && !isFullData && !isLoading){
    
        pageIndex ++;
        
        [self getListComment];
    }
    
    return cell;
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [Common showAlert:self title:@"Thông báo" message:@"Bạn có chắc muốn xoá bình luận này" buttonClick:^(UIAlertAction *alertAction) {
            
            Comment *comment = [self.arrComments objectAtIndex:indexPath.row];
            [self deleteComment:comment];
            
        }];
        
    }
}

@end
