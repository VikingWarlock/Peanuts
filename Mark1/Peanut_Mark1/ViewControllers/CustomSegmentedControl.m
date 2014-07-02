//
//  CustomSegmentedControl.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "CustomSegmentedControl.h"
@interface CustomSegmentedControl()
{
    BOOL tag1;
    BOOL tag2;
}

@end
@implementation CustomSegmentedControl
#define SELECTED_COLOR Dark_Red
#define NOT_SELECTED_COLOR [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]
#define SELECTED_COLOR_GRAY [UIColor colorWithRed:178.0/255.0 green:178.0/255.0 blue:178.0/255.0 alpha:1]
#define NOT_SELECTED_COLOR_GRAY [UIColor colorWithRed:218.0/255.0 green:218.0/255.0 blue:218.0/255.0 alpha:1]

- (id)initWithisProgressing:(BOOL)isProgressing
{
    self = [super init];
    if (self) {
        tag1 = 
        _isOnline = YES;
        [self addSubview:self.leftButton];
        [self addSubview:self.rightButton];
        self.isProgressing = isProgressing;
        self.isPresenting = isProgressing;
        
        [_leftButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_rightButton setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_leftButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_rightButton]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_rightButton)]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_leftButton(_rightButton)][_rightButton(_leftButton)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton,_rightButton)]];
    }
    return self;
}

- (void)switchStatus:(id)sender
{
    if (((UIButton *)sender).titleLabel.tag == 0) {
        UIColor *temp = _leftButton.backgroundColor;
        _leftButton.backgroundColor = _rightButton.backgroundColor;
        _rightButton.backgroundColor = temp;
        _isOnline = ((UIButton *)sender).tag;
        
        int tempTag = _rightButton.titleLabel.tag;
        _rightButton.titleLabel.tag = _leftButton.titleLabel.tag;
        _leftButton.titleLabel.tag = tempTag;
        [self.delegate ClickedButtonIsOnline:_isOnline IsPresenting:_isPresenting IsProgressing:_isProgressing];
    }
}

- (void)setIsPresenting:(BOOL)isProgressing
{
    _isPresenting = isProgressing;
    if (isProgressing) {
        if (_isOnline == YES) {
            _leftButton.backgroundColor = SELECTED_COLOR;
            _rightButton.backgroundColor = NOT_SELECTED_COLOR;
            
            _leftButton.titleLabel.tag = 1;
            _rightButton.titleLabel.tag = 0;
        }
        else
        {
            _leftButton.backgroundColor = NOT_SELECTED_COLOR;
            _rightButton.backgroundColor = SELECTED_COLOR;
            
            _leftButton.titleLabel.tag = 0;
            _rightButton.titleLabel.tag = 1;
        }
    }
    else
    {
        if (_isOnline == YES) {
            _leftButton.backgroundColor = SELECTED_COLOR_GRAY;
            _rightButton.backgroundColor = NOT_SELECTED_COLOR_GRAY;
            
            _leftButton.titleLabel.tag = 1;
            _rightButton.titleLabel.tag = 0;
        }
        else
        {
            _leftButton.backgroundColor = NOT_SELECTED_COLOR_GRAY;
            _rightButton.backgroundColor = SELECTED_COLOR_GRAY;
            
            _leftButton.titleLabel.tag = 0;
            _rightButton.titleLabel.tag = 1;
        }
    }
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        [_leftButton setTitle:@"线上" forState:UIControlStateNormal];
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        _leftButton.backgroundColor = SELECTED_COLOR;
        [_leftButton addTarget:self action:@selector(switchStatus:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton.tag = 1;
        _leftButton.titleLabel.tag = 1;
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        [_rightButton setTitle:@"线下" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:9.0f];
        _rightButton.backgroundColor = NOT_SELECTED_COLOR;
        [_rightButton addTarget:self action:@selector(switchStatus:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.tag = 0;
        _rightButton.titleLabel.tag = 0;
    }
    return _rightButton;
}

@end

