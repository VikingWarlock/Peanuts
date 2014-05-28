//
//  ActivityTableViewCell.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/15/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivityTableViewCell.h"

@implementation ActivityTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.picture];
        [self.contentView addSubview:self.title];
        [self.contentView addSubview:self.user];
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.Date];
        [self.contentView addSubview:self.calendar];
        [self.contentView addSubview:self.type];
        [self.contentView addSubview:self.flag];
        
        [_picture setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7.5-[_picture]-7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-10-[_picture]-42.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
        
        [_title setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7.5-[_title]-7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_title)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_title attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_picture attribute:NSLayoutAttributeBottom multiplier:1.0 constant:6 ]];
        
        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-7.5-[_avatar(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_avatar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_title attribute:NSLayoutAttributeBottom multiplier:1.0 constant:6 ]];
        
        [_user setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:6 ]];
        
        [_Date setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_Date attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:8 ]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_Date attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_calendar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_calendar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_Date attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-6 ]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_calendar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_calendar(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_calendar)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_calendar(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_calendar)]];
        
        [_type setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_type]-7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_type)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_type attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_flag setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_flag attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_type attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-6 ]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_flag attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_flag(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flag)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_flag(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flag)]];
        
        [self.contentView layoutIfNeeded];
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
        _picture.backgroundColor = [UIColor redColor];
    }
    return _picture;
}

- (UILabel *)title
{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.text = @"活动未定义！";
        _title.font = [UIFont systemFontOfSize:10.0f];
    }
    return _title;
}

- (UILabel *)user
{
    if (!_user) {
        _user = [[UILabel alloc] init];
        _user.text = @"UnKnown!";
        _user.textColor = [UIColor grayColor];
        _user.font = [UIFont systemFontOfSize:8.0];
    }
    return _user;
}

- (UIImageView *)avatar
{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.image = nil;
    }
    return _avatar;
}

- (UILabel *)Date
{
    if (!_Date) {
        _Date = [[UILabel alloc] init];
        _Date.textColor = [UIColor grayColor];
        _Date.text = @"2014/05/12 - 2014/11/02";
        _Date.font = [UIFont systemFontOfSize:8.0];
    }
    return _Date;
}

- (UIImageView *)calendar
{
    if (!_calendar) {
        _calendar = [[UIImageView alloc] init];
        _calendar.image = nil;
        _calendar.backgroundColor = [UIColor orangeColor];
    }
    return _calendar;
}

- (UILabel *)type
{
    if (!_type) {
        _type = [[UILabel alloc] init];
        _type.textColor = [UIColor grayColor];
        _type.text = @"线上活动";
        _type.font = [UIFont systemFontOfSize:8.0];
    }
    return _type;
}

- (UIImageView *)flag
{
    if (!_flag) {
        _flag = [[UIImageView alloc] init];
        _flag.image = nil;
        _flag.backgroundColor = [UIColor greenColor];
    }
    return _flag;
}

@end
