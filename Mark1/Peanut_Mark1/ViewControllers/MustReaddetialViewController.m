//
//  MustReaddetialViewController.m
//  Peanut_Mark1
//
//  Created by Grayon on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "MustReaddetialViewController.h"
@interface MustReaddetialViewController ()
@property(nonatomic,strong) UIImageView *picture;
@property(nonatomic,strong) UIView *mask;
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UILabel *atitle;
@property (nonatomic,strong) UILabel *user;
@property (nonatomic,strong) UIButton *like;
@property (nonatomic,strong) UIButton *comment;
@end

@implementation MustReaddetialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"title";
    [self.view addSubview:self.picture];
    [self.view addSubview:self.mask];
    
    [_picture setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_picture]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture(255)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
    
    [_mask setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mask]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_mask(57)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_mask attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_picture attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0 ]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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

- (UIView *)mask
{
    if(!_mask){
        _mask = [[UIView alloc] init];
        [_mask setBackgroundColor:[UIColor blackColor]];
        [_mask setAlpha:0.8];
        
        [_mask addSubview:self.atitle];
        [_mask addSubview:self.avatar];
        [_mask addSubview:self.user];
        [_mask addSubview:self.like];
        [_mask addSubview:self.comment];
        
        [_atitle setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_atitle]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_atitle)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_atitle(25)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_atitle)]];
        
        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_avatar(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(12)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        
        [_user setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:6 ]];
        
        [_comment setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_comment(30)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_comment)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_comment(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_comment)]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_comment attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_like setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_like(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_like)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_like(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_like)]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_like attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_like attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_comment attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-6]];

    }
    return _mask;
}

- (UILabel *)atitle
{
    if (!_atitle) {
        _atitle = [[UILabel alloc] init];
        _atitle.text = @"MustRead";
        _atitle.textColor = [UIColor whiteColor];
        _atitle.font = [UIFont systemFontOfSize:12];
    }
    return _atitle;
}

- (UIImageView *)avatar
{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.image = nil;
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 6.0;
        _avatar.backgroundColor = [UIColor blueColor];
    }
    return _avatar;
}


- (UILabel *)user
{
    if (!_user) {
        _user = [[UILabel alloc] init];
        _user.text = @"ZAKER";
        _user.textColor = [UIColor whiteColor];
        _user.font = [UIFont systemFontOfSize:10];
    }
    return _user;
}

- (UIButton *)like
{
    if (!_like) {
        _like = [[UIButton alloc] init];
        [_like setTitle:@"100" forState:UIControlStateNormal];
        [_like setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
        [_comment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_comment.titleLabel setFont:[UIFont systemFontOfSize:9.0]];
        [_comment setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        [_comment setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
        _comment.backgroundColor = [UIColor clearColor];
    }
    return _comment;
}

@end
