//
//  Mask.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/16/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "Mask.h"

@implementation Mask

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [self addSubview:self.headline];
        [self addSubview:self.user];
        [self addSubview:self.avatar];
        [self addSubview:self.calendar];
        [self addSubview:self.Date];
        [self addSubview:self.flag];
        [self addSubview:self.type];
        
        [_headline setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_headline]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headline)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8-[_headline]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headline)]];
        
        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_avatar(13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_avatar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:_headline attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8 ]];
        
        [_user setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:6 ]];
        
        [_Date setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_Date attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_calendar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_calendar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-93-[_calendar]-6-[_Date]-93-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_calendar,_Date)]];

        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_calendar(13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_calendar)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_calendar(13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_calendar)]];
        
        [_type setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_type]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_type)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_type attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_flag setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_flag attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_type attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-6 ]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_flag attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_flag(13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flag)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_flag(13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flag)]];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
#pragma mark lazy initialization

- (UILabel *)user
{
    if (!_user) {
        _user = [[UILabel alloc] init];
        _user.text = @"未知";
        _user.textColor = [UIColor whiteColor];
        _user.font = [UIFont boldSystemFontOfSize:10];
    }
    return _user;
}

- (UILabel *)headline
{
    if (!_headline) {
        _headline = [[UILabel alloc] init];
        _headline.text = @"活动未定义！";
        _headline.font = [UIFont boldSystemFontOfSize:15];
        _headline.textColor = [UIColor whiteColor];
        
    }
    return _headline;
}

- (UIImageView *)avatar
{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.image = [UIImage imageNamed:@"placeholder.png"];
    }
    return _avatar;
}

- (UILabel *)Date
{
    if (!_Date) {
        _Date = [[UILabel alloc] init];
        _Date.textColor = [UIColor whiteColor];
        _Date.text = @"1970/01/01 - 1970/01/01";
        _Date.font = [UIFont boldSystemFontOfSize:10];
    }
    return _Date;
}

- (UIImageView *)calendar
{
    if (!_calendar) {
        _calendar = [[UIImageView alloc] init];
        _calendar.image = [UIImage imageNamed:@"activity-detail-info-calendar.png"];
    }
    return _calendar;
}

- (UILabel *)type
{
    if (!_type) {
        _type = [[UILabel alloc] init];
        _type.textColor = [UIColor whiteColor];
        _type.text = @"未知错误";
        _type.font = [UIFont boldSystemFontOfSize:10];
    }
    return _type;
}

- (void)setTypeText:(NSString *)typeText
{
    _typeText = typeText;
    if ([_typeText isEqualToString:@"0"]) {
        self.type.text = @"线上活动";
    }
    else if ([_typeText isEqualToString:@"1"])
    {
        self.type.text = @"线下活动";
    }
    else
    {
        self.type.text = @"未知错误";
    }
}

- (UIImageView *)flag
{
    if (!_flag) {
        _flag = [[UIImageView alloc] init];
        _flag.image = [UIImage imageNamed:@"activity-detail-info-location.png"];
    }
    return _flag;
}
@end
