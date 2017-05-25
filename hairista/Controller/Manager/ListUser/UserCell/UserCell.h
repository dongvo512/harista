//
//  UserCell.h
//  hairista
//
//  Created by Dong Vo on 2/18/17.
//  Copyright © 2017 Dong Vo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SessionUser;

@interface UserCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *btnAddUser;
@property (nonatomic, weak) id delegate;
-(void)setDataForCell:(SessionUser *)user;

@end
@protocol UserCellDelegate <NSObject>

-(void)touchButtonAddUser:(SessionUser *)user;

@end
