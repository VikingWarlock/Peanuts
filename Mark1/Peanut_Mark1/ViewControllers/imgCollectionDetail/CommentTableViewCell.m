//
//  CommentTableViewCell.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//
#define gap 5.0
#define commentTVHeight 40.0
#define cellHeight_origin 120
#define cellHeight_changed 140

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier atIndexPath:(NSIndexPath *)indexPath
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.indexPath = indexPath;
        [self setBackgroundColor:[UIColor clearColor]];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.commentLabel];
        
        CGRect rect = self.commentLabel.frame;
        rect.origin.y += (rect.size.height + gap);
        rect.size.height = 20;
        rect.size.width = 40;
        _replayBtn = [[UIButton alloc] initWithFrame:rect];
        [_replayBtn setBackgroundColor:[UIColor clearColor]];
        [_replayBtn setTitle:@"回复" forState:UIControlStateNormal];
        [_replayBtn setTitle:@"回复" forState:UIControlStateHighlighted];
        [_replayBtn setTitle:@"回复" forState:UIControlStateSelected];
        [_replayBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_replayBtn.layer setBorderWidth:1.0f];
        [_replayBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_replayBtn addTarget:self action:@selector(replayBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_replayBtn];
        
        rect.origin.x += (rect.size.width + 20);
        _deleteBtn = [[UIButton alloc] initWithFrame:rect];
        [_deleteBtn setBackgroundColor:[UIColor clearColor]];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateHighlighted];
        [_deleteBtn setTitle:@"删除" forState:UIControlStateSelected];
        [_deleteBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_deleteBtn.layer setBorderWidth:1.0f];
        [_deleteBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteBtn];
        
        rect = self.frame;
        rect.size.height = cellHeight_origin;
        self.frame = rect;
    }
    return self;
}

-(AMPAvatarView *)iconView{
    if (!_iconView) {
        _iconView = [[AMPAvatarView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        [_iconView setImage:[UIImage imageNamed:@"iron.png"]];
    }
    return _iconView;
}

-(UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc] initWithFrame:CGRectMake(self.iconView.frame.origin.x, self.iconView.frame.origin.y + self.iconView.frame.size.height + gap, self.iconView.frame.size.width, 15)];
        _userName.font = [UIFont systemFontOfSize:13.0];
        _userName.textAlignment = NSTextAlignmentCenter;
        [_userName setTextColor:[UIColor whiteColor]];
    }
    return _userName;
    

}

-(UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.iconView.frame.origin.x + self.iconView.frame.size.width + 20, self.iconView.frame.origin.y, 60, 15)];
        _timeLabel.adjustsFontSizeToFitWidth = YES;
        [_timeLabel setTextColor:[UIColor whiteColor]];
    }
    return _timeLabel;
}

-(UILabel *)commentLabel{
    if (!_commentLabel) {
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.timeLabel.frame.origin.x, self.timeLabel.frame.origin.y + self.timeLabel.frame.size.height + gap, self.frame.size.width - self.timeLabel.frame.origin.x,20)];
        [_commentLabel setTextColor:[UIColor whiteColor]];
    }
    return _commentLabel;
}

-(void)deleteBtnClick:(UIButton *)sender{

        [self.delegate deleteBtnClickAtIndexPath:self.indexPath];
}

-(void)changeCell{
    CGRect rect = self.commentLabel.frame;
    rect.origin.y += (rect.size.height + gap);
    rect.size.height = commentTVHeight;
    _commentView = [[UITextView alloc]initWithFrame:rect];
    [_commentView setBackgroundColor:[UIColor clearColor]];
    _commentView.textColor = [UIColor whiteColor];
    [_commentView.layer setBorderWidth:1.0];
    [_commentView.layer setBorderColor:[UIColor whiteColor].CGColor];
    
    [self.contentView addSubview:_commentView];
    rect = self.replayBtn.frame;
    rect.origin.y += commentTVHeight + gap;
    self.replayBtn.frame = rect;
    rect = self.deleteBtn.frame;
    rect.origin.y += commentTVHeight + gap;
    self.deleteBtn.frame = rect;
    [self.deleteBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.deleteBtn setTitle:@"取消" forState:UIControlStateHighlighted];
    [self.deleteBtn setTitle:@"取消" forState:UIControlStateSelected];
    
    rect = self.frame;
    rect.size.height = cellHeight_changed;
    self.frame = rect;
}

-(void)reChangeCell{
    self.commentView.hidden = YES;
    CGRect rect = self.commentLabel.frame;
    rect.origin.y += (rect.size.height + gap);
    rect.size.height = 20;
    rect.size.width = 40;
    self.replayBtn.frame = rect;
    rect.origin.x += (rect.size.width + 20);
    self.deleteBtn.frame = rect;
    
    rect = self.frame;
    rect.size.height = cellHeight_origin;
    self.frame = rect;
}

-(void)replayBtnClick:(UIButton *)sender{
    [self changeCell];
    [self.delegate replayBtnClickAtIndexPath:self.indexPath];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
