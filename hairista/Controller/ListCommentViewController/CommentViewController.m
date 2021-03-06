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
#import "SalonManage.h"
#import "Salon.h"
#import "CommentDetailView.h"

#define LIMIT_ITEM @"14"

@interface CommentViewController (){

    Salon *salonCurr;
    NSInteger pageIndex;
    
    BOOL isLoading;
    
    BOOL isFullData;
}
@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property (nonatomic, strong) NSMutableArray *arrComments;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomContraint;
@property (weak, nonatomic) IBOutlet UITextField *txtComment;

@end

@implementation CommentViewController

#pragma mark - Init
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil salon:(Salon *)salon{

    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if(self){
    
        salonCurr = salon;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tblView.estimatedRowHeight = 80;
    self.tblView.rowHeight = UITableViewAutomaticDimension;
    
    self.arrComments = [NSMutableArray array];
    
    pageIndex = 1;
    
    [self getListComment];
   // [self createDataTemp];
    
    [self.tblView registerNib:[UINib nibWithNibName:@"CommentCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action
- (IBAction)touchBtnComment:(id)sender {
    
    CommentDetailView *commentView = [[CommentDetailView alloc] initWithFrame:CGRectMake(0, 0, SW, SH) salon:salonCurr];
    commentView.delegate = self;
    [[[SlideMenuViewController sharedInstance] view] addSubview:commentView];
    
}

#pragma mark - CommentDetailViewDelegate
-(void)commented:(Comment *)comment{

    if([[self delegate] respondsToSelector:@selector(finishCommented)]){
    
        [[self delegate] finishCommented];
    }
    
    [self.arrComments insertObject:comment atIndex:0];
    
    [self.tblView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    
//    [self.tblView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationTop];
    
    [self.tblView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
#pragma mark - Method

-(void)getListComment{

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    isLoading = YES;
    
    [[SalonManage sharedInstance] getListCommentSalon:salonCurr.idSalon page:[NSString stringWithFormat:@"%ld",(long)pageIndex] limit:LIMIT_ITEM dataResult:^(NSError *error, id idObject, NSString *strError) {
        
        isLoading = NO;
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if(error){
        
            [Common showAlert:[SlideMenuViewController sharedInstance] title:@"Thông báo" message:strError buttonClick:nil];
        }
        else{
        
            NSArray *arrData = idObject;
            
            if(arrData.count > 0){
            
                [self.arrComments addObjectsFromArray:arrData];
                
                [self.tblView reloadData];
            }
            
            if(arrData.count < LIMIT_ITEM.integerValue){
            
                isFullData = YES;
            }
        }
    }];
    
}

- (IBAction)touchTblView:(id)sender {
    
    [self.view endEditing:YES];
}

- (IBAction)send:(id)sender {
    
    if(self.txtComment.text.length > 0){
    
        Comment *cm_more = [[Comment alloc] init];
       
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
                         
                         if(self.arrComments.count > 0){
                         
                             [self.tblView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:(self.arrComments.count -1) inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

                         }
                        
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
    
    if(indexPath.row == self.arrComments.count - 1 && !isLoading && !isFullData){

        pageIndex ++ ;
        
        [self getListComment];
    }
    
    return cell;
}


@end
