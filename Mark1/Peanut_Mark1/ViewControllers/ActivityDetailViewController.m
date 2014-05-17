//
//  ActivityDetailViewController.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/16/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "Mask.h"
#import "ActivityDetailInfoViewController.h"
#import "ActivityDetailUserViewController.h"
#import "BottomView.h"
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
@property (strong,nonatomic) Mask *mask;
@property (strong,nonatomic) BottomView *bottomView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UILabel *join;
@property (nonatomic,strong) UILabel *interest;
@property (nonatomic,strong) UIImageView *interestImage;
@property (nonatomic,strong) UIImageView *joinImage;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UITabBarController *tabBar;

@end

@implementation ActivityDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _tabBar = [[UITabBarController alloc] init];
        _tabBar.delegate = self;
        ActivityDetailInfoViewController *blueViewController = [[ActivityDetailInfoViewController alloc] init];
         ActivityDetailUserViewController *yellowViewController = [[ActivityDetailUserViewController alloc] init];
        NSArray *viewControllerArray = [NSArray arrayWithObjects:blueViewController,yellowViewController,nil];
        _tabBar.viewControllers = viewControllerArray;
        _tabBar.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        //[self.view addSubview:_tabBar.view];
        [self setTabBar:_tabBar];
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
    [self.view addSubview:self.bottomView];
    [self.tableview registerClass:[CustomCell class] forCellReuseIdentifier:@"cell"];
    
    [_picture setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_picture]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture]-252-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
    
    [_leftButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_rightButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture][_leftButton(42)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture,_leftButton)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture][_rightButton(42)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture,_rightButton)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_leftButton(==_rightButton)][_rightButton(==_leftButton)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_leftButton,_rightButton)]];
    
    [_tableview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableview)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_tableview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableview)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_tableview attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_leftButton attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0 ]];
    
    [_bottomView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_bottomView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bottomView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_bottomView(42)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_bottomView)]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = _mask.headline.text;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"";
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            ActivityDetailInfoViewController *vc = [[ActivityDetailInfoViewController alloc] init];
            vc.title = self.title;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            break;

        }
        case 2:
        {
            ActivityDetailUserViewController *vc = [[ActivityDetailUserViewController alloc] init];
            vc.title = self.title;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
            break;
        default:
            break;
    }
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
        [_picture addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_mask(57)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    }
    return _picture;
}

- (Mask *)mask
{
    if (!_mask) {
        _mask = [[Mask alloc] init];
    }
    return _mask;
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
        [_tableview setContentInset:UIEdgeInsetsMake(0, 0, 42, 0)];
    }
    return _tableview;
}

- (BottomView *)bottomView
{
    if (!_bottomView) {
        _bottomView = [[BottomView alloc] init];
    }
    return _bottomView;
}

@end
