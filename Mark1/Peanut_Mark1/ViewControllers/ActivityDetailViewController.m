//
//  ActivityDetailViewController.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/16/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailInfoViewController.h"
#import "ActivityDetailUserViewController.h"
#import "ActivitDetailInterestedPeopleViewController.h"
#import "BottomView.h"
#import "CustomCell.h"
#import "CoreData-Helper.h"
@interface ActivityDetailViewController ()
{
    NSMutableArray *pictures;
    NSMutableArray *user;
    NSMutableArray *interesteUser;
}
@property (strong,nonatomic) BottomView *bottomView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UILabel *join;
@property (nonatomic,strong) UILabel *interest;
@property (nonatomic,strong) UIImageView *interestImage;
@property (nonatomic,strong) UIImageView *joinImage;
@property (nonatomic,strong) UITableView *tableview;

@end

@implementation ActivityDetailViewController

- (id)initWithFeedId:(int)feedId bgImageUrl:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getFirstPage];
    [self.picture setImageWithURL:[NSURL URLWithString:[CoreData_Helper GetActivityEntity:self.feedid].cover_url] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
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
    self.navigationItem.title = _mask.headline.text;
    ((UIViewController *)(self.navigationController.viewControllers)[[self.navigationController.viewControllers indexOfObject:self] - 1]).navigationItem.title = @"";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -network stuff

- (void)getFirstPage
{   //活动作品
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_work_list" parameters:@{@"page":@"1",@"count":@"10",@"feed_id":_feedid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            pictures = [responseObject valueForKey:@"data"];
//            if ([pictures count] == 1) {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView1 setImageWithURL:[pictures[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
//            else if ([pictures count] == 2)
//            {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView2 setImageWithURL:[pictures[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
//            else if ([pictures count] >= 3)
//            {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView3 setImageWithURL:[pictures[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
//
            NSLog(@"%@",_feedid);
            NSLog(@"%@\n\n\n",responseObject);

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //活动成员
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_user_list" parameters:@{@"page":@"1",@"count":@"10",@"feed_id":_feedid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            user = [responseObject valueForKey:@"data"];
//            if ([user count] == 1) {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView1 setImageWithURL:[user[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
//            else if ([user count] == 2)
//            {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView2 setImageWithURL:[user[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
//            else if ([user count] >= 3)
//            {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView3 setImageWithURL:[user[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
            
            //NSLog(@"%@",responseObject);
            

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //感兴趣的人
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_work_list" parameters:@{@"page":@"1",@"count":@"10",@"feed_id":_feedid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
//            interesteUser = [responseObject valueForKey:@"data"];
//            if ([interesteUser count] == 1) {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView1 setImageWithURL:[interesteUser[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
//            else if ([interesteUser count] == 2)
//            {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView2 setImageWithURL:[interesteUser[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
//            else if ([interesteUser count] >= 3)
//            {
//                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView3 setImageWithURL:[interesteUser[0] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
//            }
            
            //NSLog(@"%@",[responseObject valueForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark -tableView datasource and delegate

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
            cell.imageView1.hidden = YES;
            cell.imageView2.hidden = YES;
            cell.imageView3.hidden = YES;
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
            vc.navigationItem.title = self.navigationItem.title;
            vc.mask.avatar.image = self.mask.avatar.image;
            vc.mask.headline.text = self.mask.headline.text;
            vc.mask.user.text = self.mask.user.text;
            vc.mask.Date.text = self.mask.Date.text;
            vc.mask.type.text = self.mask.type.text;
            vc.description = [CoreData_Helper GetActivityEntity:_feedid].descriptions;
            vc.backImage = self.picture.image;
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
            vc.navigationItem.title = self.navigationItem.title;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            ActivitDetailInterestedPeopleViewController *vc = [[ActivitDetailInterestedPeopleViewController alloc] init];
            vc.navigationItem.title = self.navigationItem.title;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark lazy initialization

- (UIImageView *)picture
{
    if (!_picture) {
        _picture = [[UIImageView alloc] init];
        _picture.clipsToBounds = YES;
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        _picture.image = [UIImage imageNamed:@"placeholder.png"];
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
