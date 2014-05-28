//
//  CustomCell.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        [self.contentView addSubview:self.imageView1];
        [self.contentView addSubview:self.imageView2];
        [self.contentView addSubview:self.imageView3];
        [self.contentView addSubview:self.label];
        
        [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_label]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_label)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        
        [_imageView1 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_imageView2 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_imageView3 setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8.5-[_imageView1]-8.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView1)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView1 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_imageView1 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8.5-[_imageView2]-8.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView2)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView2 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_imageView2 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-8.5-[_imageView3]-8.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView3)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_imageView3 attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageView3]-7.5-[_imageView2]-7.5-[_imageView1]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView1,_imageView2,_imageView3)]];
        
    }
    return self;
}

- (UIImageView *)imageView1
{
    if (!_imageView1) {
        _imageView1 = [[UIImageView alloc] init];
        _imageView1.image = nil;
        _imageView1.contentMode = UIViewContentModeScaleAspectFill;
        _imageView1.clipsToBounds = YES;
        _imageView1.backgroundColor = [UIColor redColor];
    }
    return _imageView1;
}

- (UIImageView *)imageView2
{
    if (!_imageView2) {
        _imageView2 = [[UIImageView alloc] init];
        _imageView2.image = nil;
        _imageView2.contentMode = UIViewContentModeScaleAspectFill;
        _imageView2.clipsToBounds = YES;
        _imageView2.backgroundColor = [UIColor greenColor];
    }
    return _imageView2;
}

- (UIImageView *)imageView3
{
    if (!_imageView3) {
        _imageView3 = [[UIImageView alloc] init];
        _imageView3.image = nil;
        _imageView3.contentMode = UIViewContentModeScaleAspectFill;
        _imageView3.clipsToBounds = YES;
        _imageView3.backgroundColor = [UIColor blueColor];
        
    }
    return _imageView3;
}

- (UILabel *)label
{
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:12];
        _label.text = @"(null)";
    }
    return _label;
}

@end
