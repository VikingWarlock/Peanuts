//
//  BottomView.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/17/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
        [self addSubview:self.praiseBtn];
        [self addSubview:self.commentBtn];
        [self addSubview:self.shareBtn];
        
        [_praiseBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-45-[_praiseBtn(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_praiseBtn)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_praiseBtn(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_praiseBtn)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_praiseBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_commentBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_commentBtn(20)]-45-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_commentBtn)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_commentBtn(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_commentBtn)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_commentBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_shareBtn setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_shareBtn(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_shareBtn)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_shareBtn(20)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_shareBtn)]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_shareBtn attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_shareBtn attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0 ]];

    }
    return self;
}

- (UIButton *)praiseBtn
{
    if (!_praiseBtn) {
        _praiseBtn = [[UIButton alloc] init];
        _praiseBtn.backgroundColor = [UIColor greenColor];
    }
    return _praiseBtn;
}

- (UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        _commentBtn.backgroundColor = [UIColor redColor];
    }
    return _commentBtn;
}

- (UIButton *)shareBtn
{
    if (!_shareBtn) {
        _shareBtn = [[UIButton alloc] init];
        _shareBtn.backgroundColor = [UIColor blueColor];
    }
    return _shareBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
