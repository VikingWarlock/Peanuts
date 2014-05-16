//
//  PublishCommentTableViewCell.h
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-15.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMPAvatarView.h"

@interface PublishCommentTableViewCell : UITableViewCell

@property (nonatomic,strong) AMPAvatarView * iconView;
@property (nonatomic,strong) UILabel * userName;
@property (nonatomic,strong) UITextView * commentView;
@property (nonatomic,strong) UIButton * publishCommentBtn;
@property (nonatomic,strong) UIButton * confirmBtn;

@end
