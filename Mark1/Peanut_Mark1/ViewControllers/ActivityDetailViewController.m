//
//  ActivityDetailViewController.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/16/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivityDetailViewController.h"

@interface CustomCell : UITableViewCell
@property (strong,nonatomic) UILabel *label;
@property (strong,nonatomic) UIImageView *imageView1;
@property (strong,nonatomic) UIImageView *imageView2;
@property (strong,nonatomic) UIImageView *imageView3;
@end

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
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_imageView1]-7.5-[_imageView2]-7.5-[_imageView3]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_imageView1,_imageView2,_imageView3)]];
        
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
        
        _imageView1.backgroundColor = [UIColor blueColor];
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
        
        _imageView2.backgroundColor = [UIColor redColor];
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
        
        _imageView3.backgroundColor = [UIColor blackColor];
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






@interface ActivityDetailViewController ()
@property (nonatomic,strong) UIImageView *picture;
@property (nonatomic,strong) UIView *mask;
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UIImageView *calendar;
@property (nonatomic,strong) UIImageView *flag;
@property (nonatomic,strong) UILabel *headline;
@property (nonatomic,strong) UILabel *user;
@property (nonatomic,strong) UILabel *Date;
@property (nonatomic,strong) UILabel *type;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UILabel *join;
@property (nonatomic,strong) UILabel *interest;
@property (nonatomic,strong) UIImageView *interestImage;
@property (nonatomic,strong) UIImageView *joinImage;
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation ActivityDetailViewController

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
    [self.view addSubview:self.picture];
    [self.view addSubview:self.leftButton];
    [self.view addSubview:self.rightButton];
    [self.view addSubview:self.tableview];
    [self.tableview registerClass:[CustomCell class] forCellReuseIdentifier:@"cell"];
    
    [_picture setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_picture]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture(==251.5)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
    
    [_leftButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_rightButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture][_leftButton(42)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture,_leftButton)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture][_rightButton(42)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture,_rightButton)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_leftButton(==_rightButton)][_rightButton(==_leftButton)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton,_rightButton)]];
    
    [_tableview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableview)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableview]-42-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableview)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_leftButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0 ]];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tableView datasource and delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    switch (indexPath.row) {
        case 0:
            cell.label.text = @"活动详细";
            break;
        case 1:
            cell.label.text = @"活动作品";
            break;
        case 2:
            cell.label.text = @"活动成员";
            break;
        case 3:
            cell.label.text = @"感兴趣的人";
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 42;
}

#pragma mark lazy initialization

- (UIImageView *)picture
{
    if (!_picture) {
        _picture = [[UIImageView alloc] init];
        _picture.image = nil;
        _picture.clipsToBounds = YES;
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        
        _picture.backgroundColor = [UIColor blueColor];
        
        [_picture addSubview:self.mask];
        [_mask setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_picture addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mask]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
        [_picture addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_mask(>=57)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    }
    return _picture;
}

- (UIView *)mask
{
    if (!_mask) {
        _mask = [[UIView alloc] init];
        _mask.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
        [_mask addSubview:self.headline];
        [_mask addSubview:self.user];
        [_mask addSubview:self.avatar];
        [_mask addSubview:self.calendar];
        [_mask addSubview:self.Date];
        [_mask addSubview:self.flag];
        [_mask addSubview:self.type];
        
        
        [_headline setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_headline]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headline)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=8-[_headline]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_headline)]];
        
        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_avatar(>=13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(>=13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_avatar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:_headline attribute:NSLayoutAttributeBottom multiplier:1.0 constant:8 ]];
        
        [_user setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:6 ]];
        
        [_Date setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_Date attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_mask attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:10 ]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_Date attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];

        [_calendar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_calendar attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_Date attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-6 ]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_calendar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_calendar(>=13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_calendar)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_calendar(>=13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_calendar)]];

        [_type setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_type]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_type)]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_type attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_flag setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_flag attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_type attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-6 ]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_flag attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_flag(>=13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flag)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_flag(>=13)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_flag)]];
    }
    return _mask;
}

- (UILabel *)user
{
    if (!_user) {
        _user = [[UILabel alloc] init];
        _user.text = @"ZAKER";
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
        _avatar.image = nil;
        _avatar.backgroundColor = [UIColor blueColor];
    }
    return _avatar;
}

- (UILabel *)Date
{
    if (!_Date) {
        _Date = [[UILabel alloc] init];
        _Date.textColor = [UIColor whiteColor];
        _Date.text = @"2014/05/12 - 2014/11/02";
        _Date.font = [UIFont boldSystemFontOfSize:10];
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
        _type.textColor = [UIColor whiteColor];
        _type.text = @"线上活动";
        _type.font = [UIFont boldSystemFontOfSize:10];
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

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        _leftButton.backgroundColor = [UIColor purpleColor];
        
        [_leftButton addSubview:self.join];
        [_leftButton addSubview:self.joinImage];
        
        [_joinImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_leftButton addConstraint:[NSLayoutConstraint constraintWithItem:_joinImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_leftButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_leftButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_joinImage(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_joinImage)]];
        [_leftButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_joinImage(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_joinImage)]];
        
        [_join setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_leftButton addConstraint:[NSLayoutConstraint constraintWithItem:_join attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_joinImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_leftButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-45-[_joinImage]-6-[_join]-45-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_joinImage,_join)]];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.backgroundColor = [UIColor brownColor];
        
        [_rightButton addSubview:self.interest];
        [_rightButton addSubview:self.interestImage];
        
        [_interestImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_rightButton addConstraint:[NSLayoutConstraint constraintWithItem:_interestImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_rightButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_rightButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_interestImage(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_interestImage)]];
        [_rightButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_interestImage(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_interestImage)]];
        
        [_interest setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_rightButton addConstraint:[NSLayoutConstraint constraintWithItem:_interest attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_interestImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_rightButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-45-[_interestImage]-6-[_interest]-45-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_interestImage,_interest)]];
    }
    return _rightButton;
}

- (UILabel *)join
{
    if (!_join) {
        _join = [[UILabel alloc] init];
        _join.textColor = [UIColor whiteColor];
        _join.font = [UIFont systemFontOfSize:12];
        _join.text = @"我要参加";
    }
    return _join;
}

- (UILabel *)interest
{
    if (!_interestImage) {
        _interest = [[UILabel alloc] init];
        _interest.textColor = [UIColor whiteColor];
        _interest.font = [UIFont systemFontOfSize:12];
        _interest.text = @"我感兴趣";
    }
    return _interest;
}

- (UIImageView *)interestImage
{
    if (!_interestImage) {
        _interestImage = [[UIImageView alloc] init];
        _interestImage.image = nil;
        _interestImage.backgroundColor = [UIColor yellowColor];
    }
    return _interestImage;
}

- (UIImageView *)joinImage
{
    if (!_joinImage) {
        _joinImage = [[UIImageView alloc] init];
        _joinImage.image = nil;
        _joinImage.backgroundColor = [UIColor greenColor];
    }
    return _joinImage;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorInset = UIEdgeInsetsZero;
        _tableview.backgroundColor = [UIColor whiteColor];
        UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
        [_tableview setTableFooterView:v];
    }
    return _tableview;
}

@end
