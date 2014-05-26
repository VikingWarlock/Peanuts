//
//  UserCell.h
//  Peanut_Mark1
//
//  Created by 张众 on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMPAvatarView.h"
@interface UserCell : UITableViewCell
@property (strong,nonatomic) AMPAvatarView *avatar;
@property (strong,nonatomic) UILabel *unverified;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UIButton *passVerify;
@property (strong,nonatomic) UIButton *deleteMember;
@end
