//
//  UserCell.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "UserCell.h"

@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.deleteMember];
        [self.contentView addSubview:self.unverified];
        [self.contentView addSubview:self.passVerify];
        
        
        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_avatar(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_avatar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0] ];
        
        [_name setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_avatar]-15-[_name]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar,_name)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0] ];
        
        [_unverified setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_name]-6-[_unverified]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_name,_unverified)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_unverified attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_name attribute:NSLayoutAttributeTop multiplier:1.0 constant:0] ];
        
        [_passVerify setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_passVerify(42)]-7.5-[_deleteMember]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_passVerify,_deleteMember)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_passVerify(16)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_passVerify)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_passVerify attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0] ];
        
        [_deleteMember setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_deleteMember(42)]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deleteMember)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_deleteMember(16)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deleteMember)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_deleteMember attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0] ];
        
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

#pragma mark -lazy initialization

- (AMPAvatarView *)avatar
{
    if (!_avatar) {
        _avatar = [[AMPAvatarView alloc] init];
        [_avatar setImage:[UIImage imageNamed:@"iron.png"]];
        _avatar.borderWith = 0;
        _avatar.shadowRadius = 0;
    }
    return _avatar;
}

- (UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = [UIColor whiteColor];
        _name.font = [UIFont systemFontOfSize:12];
        _name.text = @"马大姐";
    }
    return _name;
}

- (UILabel *)unverified
{
    if (!_unverified) {
        _unverified = [[UILabel alloc] init];
        _unverified.backgroundColor = [UIColor redColor];
        _unverified.textColor = [UIColor whiteColor];
        _unverified.font = [UIFont systemFontOfSize:8];
        _unverified.text = @"未审核";
        _unverified.layer.cornerRadius = 2.0;
    }
    return _unverified;
}

- (UIButton *)passVerify
{
    if (!_passVerify) {
        _passVerify = [[UIButton alloc] init];
        _passVerify.backgroundColor = [UIColor greenColor];
        _passVerify.titleLabel.textColor = [UIColor whiteColor];
        _passVerify.titleLabel.font = [UIFont systemFontOfSize:9];
        [_passVerify setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [_passVerify setTitle:@"通过审核" forState:UIControlStateNormal];
        _passVerify.layer.cornerRadius = 2.0;
        _passVerify.hidden = YES;
    }
    return _passVerify;
}

- (UIButton *)deleteMember
{
    if (!_deleteMember) {
        _deleteMember = [[UIButton alloc] init];
        _deleteMember.backgroundColor = [UIColor grayColor];
        _deleteMember.titleLabel.font = [UIFont systemFontOfSize:9];
        _deleteMember.titleLabel.textColor = [UIColor whiteColor];
        [_deleteMember setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [_deleteMember setTitle:@"删除成员" forState:UIControlStateNormal];
        _deleteMember.layer.cornerRadius = 2.0;
        _deleteMember.hidden = YES;
    }
    return _deleteMember;
}


@end
