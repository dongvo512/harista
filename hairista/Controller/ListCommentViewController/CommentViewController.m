//
//  CommentViewController.m
//  hairista
//
//  Created by Dong Vo on 2/7/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentCellTableViewCell.h"
#import "Comment.h"


@interface CommentViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrComments;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContraint;
@property (weak, nonatomic) IBOutlet UITextField *txtComment;

@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tblView.estimatedRowHeight = 80;
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    
    [self createDataTemp];
    
    [self.tblView registerNib:[UINib nibWithNibName:@"CommentCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Method

-(void)createDataTemp{

    self.arrComments = [NSMutableArray array];
    
    Comment *cm_1 = [[Comment alloc] init];
    cm_1.strName = @"Trần Thu Hà";
    cm_1.imgName = @"bg_avatar";
    cm_1.numLike = @"1";
    cm_1.comment = @"Tiệm quá tuyệt vời, không còn gì để có thể diễn tả hết độ tuyệt với chưa tiệm";
    [self.arrComments addObject:cm_1];
    
    Comment *cm_2 = [[Comment alloc] init];
    cm_2.strName = @"Võ Nguyên Đông";
    cm_2.imgName = @"bg_avatar";
    cm_2.numLike = @"1";
    cm_2.comment = @"Trên cả tuyệt vời";
    [self.arrComments addObject:cm_2];
    
    
}
- (IBAction)touchTblView:(id)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)send:(id)sender {
    
    if(self.txtComment.text.length > 0){
    
        Comment *cm_more = [[Comment alloc] init];
        cm_more.strName = @"Trần Thu Hà";
        cm_more.imgName = @"bg_avatar";
        cm_more.numLike = @"1";
        cm_more.comment = self.txtComment.text;
        [self.arrComments addObject:cm_more];
        
        [self.tblView beginUpdates];
        [self.tblView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:[self.arrComments indexOfObject:cm_more] inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        
        [self.tblView endUpdates];

        [self.tblView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.arrComments indexOfObject:cm_more] inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
    
     [self.view endEditing:YES];
}

- (void)keyboardWillChange:(NSNotification *)notification {
    CGRect keyboardRect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
  
    keyboardRect = [self.view convertRect:keyboardRect fromView:nil]; //
    
     self.bottomContraint.constant = keyboardRect.size.height;
    
    [UIView animateWithDuration:.25
                     animations:^{
                         [self.view layoutIfNeeded];

                     }
                     completion:^(BOOL finished){
                         
                         [self.tblView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.arrComments.count -1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

                     }];
    }

- (void)keyboardWillHide:(NSNotification *)notification {
    
    self.bottomContraint.constant = 0;
    
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded];
    }];

}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
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
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

/*- (CGFloat)tableView:(UITableView *)tableView
 heightForRowAtIndexPath:(NSIndexPath *)indexPath{
 
 return 60;
 }*/


@end
