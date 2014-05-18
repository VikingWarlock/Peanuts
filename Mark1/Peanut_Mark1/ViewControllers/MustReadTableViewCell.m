//
//  MustReadTableViewCell.m
//  Peanut_Mark1
//
//  Created by Grayon on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "MustReadTableViewCell.h"

@implementation MustReadTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView addSubview:self.picture];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.user];
        [self.contentView addSubview:self.like];
        [self.contentView addSubview:self.comment];
        
        [_picture setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7.5-[_picture]-7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_picture(152.5)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
        
        [_title setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7.5-[_title]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_title)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_title attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_picture attribute:NSLayoutAttributeBottom multiplier:1.0 constant:6 ]];

        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7.5-[_avatar(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(10)]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        
        [_user setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:6 ]];
        
        [_comment setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_comment(30)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_comment)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_comment(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_comment)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_comment attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_like setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_like(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_like)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_like(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_like)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_like attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_like attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_comment attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-6]];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 15;
    frame.size.width -= 2 * 15;
    [super setFrame:frame];
}

#pragma mark lazy initialization

- (UIImageView *)picture
{
    if (!_picture) {
        _picture = [[UIImageView alloc] init];
        _picture.image = nil;
        _picture.clipsToBounds = YES;
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        _picture.backgroundColor = [UIColor grayColor];
    }
    return _picture;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"MustRead";
        _title.font = [UIFont systemFontOfSize:10];
    }
    return _title;
}

- (UIImageView *)avatar
{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.image = nil;
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 5.0;
        _avatar.backgroundColor = [UIColor blueColor];
    }
    return _avatar;
}


- (UILabel *)user
{
    if (!_user) {
        _user = [[UILabel alloc] init];
        _user.text = @"ZAKER";
        _user.textColor = [UIColor grayColor];
        _user.font = [UIFont systemFontOfSize:8.0];
    }
    return _user;
}

- (UIButton *)like
{
    if (!_like) {
        _like = [[UIButton alloc] init];
        [_like setTitle:@"100" forState:UIControlStateNormal];
        [_like setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_like.titleLabel setFont:[UIFont systemFontOfSize:9.0]];
        [_like setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        [_like setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
        _like.backgroundColor = [UIColor clearColor];
    }
    return _like;
}

- (UIButton *)comment
{
    if (!_comment) {
        _comment = [[UIButton alloc] init];
        [_comment setTitle:@"33" forState:UIControlStateNormal];
        [_comment setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_comment.titleLabel setFont:[UIFont systemFontOfSize:9.0]];
        [_comment setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        [_comment setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
        _comment.backgroundColor = [UIColor clearColor];
    }
    return _comment;
}

@end
