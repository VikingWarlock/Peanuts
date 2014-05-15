//
//  CommentTableViewCell.h
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AMPAvatarView.h"

@protocol DeleteCommentDelegate <NSObject>
-(void)deleteBtnClickAtIndexPath:(NSIndexPath*)indexPath;
-(void)replayBtnClickAtIndexPath:(NSIndexPath*)indexPath;

@end

@interface CommentTableViewCell : UITableViewCell

@property (nonatomic,weak) id <DeleteCommentDelegate> delegate;
@property (nonatomic,strong) AMPAvatarView * iconView;
@property (nonatomic,strong) UILabel * userName;
@property (nonatomic,strong) UILabel * timeLabel;
@property (nonatomic,strong) UILabel * commentLabel;
@property (nonatomic,strong) UIButton * replayBtn;
@property (nonatomic,strong) UIButton * deleteBtn;
@property (nonatomic,strong) NSIndexPath * indexPath;
@property (nonatomic,strong) UITextView * commentView;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath;

-(void)changeCell;
-(void)reChangeCell;
@end
