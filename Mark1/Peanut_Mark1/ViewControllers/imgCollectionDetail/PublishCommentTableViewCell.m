//
//  PublishCommentTableViewCell.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-15.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "PublishCommentTableViewCell.h"

@implementation PublishCommentTableViewCell{
    UIImage * image;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(180, 120, 90, 15)];
        label.text = @"同时转发到我的动态";
        [label setBackgroundColor:[UIColor clearColor]];
        label.textColor = [UIColor whiteColor];
        label.adjustsFontSizeToFitWidth = YES;
        
        [self.contentView addSubview:label];

        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.userName];
        [self.contentView addSubview:self.commentView];
        [self.contentView addSubview:self.publishCommentBtn];
        [self.contentView addSubview:self.confirmBtn];
        
        [self.commentView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self.publishCommentBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [self.confirmBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_iconView]-20-[_commentView]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_iconView,_commentView)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[_commentView]-40-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_commentView)]];
        
        
        CGRect rect = self.frame;
        rect.size.height = 150;
        self.frame = rect;
        
    }
    return self;
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

-(AMPAvatarView *)iconView{
    if (!_iconView) {
        _iconView = [[AMPAvatarView alloc] initWithFrame:CGRectMake(20, 20, 60, 60)];
        [_iconView setImage:[UIImage imageNamed:@"iron.png"]];
    }
    return _iconView;
}

-(UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc]initWithFrame:CGRectMake(20, 85, 60, 20)];
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.text = @"aa";
    }
    return _userName;
}

-(UITextView *)commentView{
    if (!_commentView) {
        _commentView = [[UITextView alloc] initWithFrame:CGRectMake(100, 20, 200, 90)];
        [_commentView setBackgroundColor:[UIColor clearColor]];
        [_commentView setTextColor:[UIColor whiteColor]];
        [_commentView.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_commentView.layer setBorderWidth:1.0f];
    }
    return _commentView;
}

-(UIButton *)publishCommentBtn{
    if (!_publishCommentBtn) {
        _publishCommentBtn = [[UIButton alloc] initWithFrame:CGRectMake(100, 120, 50, 20)];
        [_publishCommentBtn setBackgroundColor:[UIColor clearColor]];
        [_publishCommentBtn setTitle:@"评论" forState:UIControlStateNormal];
        [_publishCommentBtn setTitle:@"评论" forState:UIControlStateHighlighted];
        [_publishCommentBtn setTitle:@"评论" forState:UIControlStateSelected];
        [_publishCommentBtn.titleLabel setFont:[UIFont systemFontOfSize:13.0]];
        [_publishCommentBtn setBackgroundColor:[UIColor redColor]];
        [_publishCommentBtn.layer setBorderWidth:1.0f];
        [_publishCommentBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        [_publishCommentBtn addTarget:self action:@selector(publishCommentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _publishCommentBtn;
}

-(void)publishCommentBtnClick:(UIButton *)sender{
    [self.delegate publishCommentBtnClick];
}

-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn = [[UIButton alloc]initWithFrame:CGRectMake(160, 124, 12, 12)];
//        [_confirmBtn setTitle:@"*" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:[UIColor clearColor]];
        [_confirmBtn.layer setBorderColor:[UIColor whiteColor].CGColor];
        image =[UIImage imageNamed:@"yes.png"];
        [_confirmBtn setBackgroundImage:image forState:UIControlStateNormal];
        [_confirmBtn setBackgroundImage:image forState:UIControlStateSelected];
        [_confirmBtn setBackgroundImage:image forState:UIControlStateHighlighted];
        [_confirmBtn.layer setBorderWidth:1.0f];
        [_confirmBtn addTarget:self action:@selector(confirmBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _confirmBtn.enabled = YES;
    }
    return _confirmBtn;
}

-(void)confirmBtnClick:(UIButton *)sender{
    //
    if (image!=nil) {
        [sender setBackgroundImage:nil forState:UIControlStateNormal];
        [sender setBackgroundImage:nil forState:UIControlStateHighlighted];
        [sender setBackgroundImage:nil forState:UIControlStateSelected];
        image = nil;
    }else{
        image = [UIImage imageNamed:@"yes.png"];
        [sender setBackgroundImage:image forState:UIControlStateNormal];
        [sender setBackgroundImage:image forState:UIControlStateHighlighted];
        [sender setBackgroundImage:image forState:UIControlStateSelected];
    }

}

-(void)commentBtnClick:(UIButton *)sender{
    
}

@end
