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
#import "imgCollectionViewController.h"

@interface ActivityDetailViewController ()
{
    NSMutableArray *pictures;
    NSMutableArray *users;
    NSMutableArray *interesteUsers;
}
@property (strong,nonatomic) BottomView *bottomView;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong) UIButton *rightButton;
@property (nonatomic,strong) UILabel *join;
@property (nonatomic,strong) UILabel *interest;
@property (nonatomic,strong) UIImageView *interestImage;
@property (nonatomic,strong) UIImageView *joinImage;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIImageView *picture;


@end

@implementation ActivityDetailViewController

- (id)initWithFeedId:(int)feedId bgImageUrl:(NSURL *)url
{
    self = [super init];
    if (self)
    {
        _feedid = [NSString stringWithFormat:@"%D",feedId];
    }
    return self;
}

- (id)initWithFeedId:(id)feedId
{
    self = [super init];
    if (self)
    {
        _feedid = feedId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getFirstPage];
    [self.picture setImageWithURL:[NSURL URLWithString:[CoreData_Helper GetActivityEntity:self.feedid].cover_url] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"activity－detial-upload.png"] forState:UIControlStateNormal];
    [button addTarget:self action:nil forControlEvents:UIControlEventTouchUpInside];
    button.frame = CGRectMake(0, 0, 18, 18);
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem setRightBarButtonItem:rightButton];

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
    
    NSLog(@"\n\nfeed_id:%@\n PHPSESSID:%@\n\n",self.feedid,USER_PHPSESSID);
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
            if ([pictures count] == 1) {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString:[pictures[0] valueForKey:@"cover"]]];
            }
            else if ([pictures count] == 2)
            {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString:[pictures[0] valueForKey:@"cover"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView2 setImageWithURL:[NSURL URLWithString:[pictures[1] valueForKey:@"cover"]]];
            }
            else if ([pictures count] >= 3)
            {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString:[pictures[0] valueForKey:@"cover"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView2 setImageWithURL:[NSURL URLWithString:[pictures[1] valueForKey:@"cover"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]]).imageView3 setImageWithURL:[NSURL URLWithString:[pictures[2] valueForKey:@"cover"]]];
            }
            for (NSDictionary *dic in [responseObject valueForKey:@"data"]) {
                [CoreData_Helper addPhotoSeriesEntity:dic];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //活动成员
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_user_list" parameters:@{@"page":@"1",@"count":@"10",@"feed_id":_feedid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            users = [responseObject valueForKey:@"data"];
            if ([users count] == 1) {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString:[users[0] valueForKey:@"avatar_small"]]];
            }
            else if ([users count] == 2)
            {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString:[users[0] valueForKey:@"avatar_small"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView2 setImageWithURL:[NSURL URLWithString:[users[1] valueForKey:@"avatar_small"]]];
            }
            else if ([users count] >= 3)
            {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString:[users[0] valueForKey:@"avatar_small"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView2 setImageWithURL:[NSURL URLWithString:[users[1] valueForKey:@"avatar_small"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]]).imageView3 setImageWithURL:[NSURL URLWithString:[users[2] valueForKey:@"avatar_small"]]];
            }
            for (NSDictionary *dic in [responseObject valueForKey:@"data"]) {
                [CoreData_Helper addUserInfoEntity:dic];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    //感兴趣的人
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_love_list" parameters:@{@"page":@"1",@"count":@"10",@"feed_id":_feedid} success:^(AFHTTPRequestOperation *operation, id responseObject) {NSLog(@"\n\nresponseObject:%@\n\n",[responseObject valueForKey:@"data"]);
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            interesteUsers = [responseObject valueForKey:@"data"];
            if ([interesteUsers count] == 1) {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString:[interesteUsers[0] valueForKey:@"avatar_small"]]];
            }
            else if ([interesteUsers count] == 2)
            {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString:[interesteUsers[0] valueForKey:@"avatar_small"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).imageView2 setImageWithURL:[NSURL URLWithString:[interesteUsers[1] valueForKey:@"avatar_small"]]];
            }
            else if ([interesteUsers count] >= 3)
            {
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).imageView1 setImageWithURL:[NSURL URLWithString: [interesteUsers[0] valueForKey:@"avatar_small"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).imageView2 setImageWithURL:[NSURL URLWithString:[interesteUsers[1] valueForKey:@"avatar_small"]]];
                [((CustomCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).imageView3 setImageWithURL:[NSURL URLWithString:[interesteUsers[2] valueForKey:@"avatar_small"]]];
            }
            for (NSDictionary *dic in [responseObject valueForKey:@"data"]) {
                [CoreData_Helper addUserInfoEntity:dic];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)joinActivity:(id)sender
{
    if (USER_PHPSESSID == NULL) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请先登录！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        [alertView show];
    }else
    {
        [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_join" parameters:@{@"PHPSESSID":USER_PHPSESSID,@"feed_id":_feedid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([_join.text isEqualToString:@"我要参加"])
            {
                _join.text = @"已参加";
                _joinImage.image = [UIImage imageNamed:@"activity－detial-joined.png"];
            }
            else if ([_join.text isEqualToString:@"已参加"])
            {
                _join.text = @"我要参加";
                _joinImage.image = [UIImage imageNamed:@"activity－detial-join.png"];
            }
            else
            {
                _join.text = @"未知错误";
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
}

- (void)likeActivity:(id)sender
{
    if (USER_PHPSESSID == NULL) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"请先登录！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alertView.alertViewStyle = UIAlertViewStyleDefault;
        [alertView show];
    }else
    {
        [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_love" parameters:@{@"PHPSESSID":USER_PHPSESSID,@"feed_id":_feedid} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            if ([_interest.text isEqualToString:@"我感兴趣"])
            {
                _interest.text = @"已感兴趣";
                _interestImage.image = [UIImage imageNamed:@"activity－detial-hearted.png"];
            }
            else if ([_interest.text isEqualToString:@"已感兴趣"])
            {
                _interest.text = @"我感兴趣";
                _interestImage.image = [UIImage imageNamed:@"activity－detial-heart.png"];
            }
            else
            {
                _interest.text = @"未知错误";
            }
        }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
    }
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
            vc.feedid = _feedid;
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            imgCollectionViewController *vc = [[imgCollectionViewController alloc] initWithFeedId:[@"162" integerValue] bgImageUrl:[NSURL URLWithString:[CoreData_Helper GetPhotoSeriesEntity:@"162"].cover_url]];
            vc.navigationItem.title = self.navigationItem.title;
            //[self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            ActivityDetailUserViewController *vc = [[ActivityDetailUserViewController alloc] init];
            vc.navigationItem.title = self.navigationItem.title;
            vc.feedid = _feedid;
            vc.users = [users mutableCopy];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 3:
        {
            ActivitDetailInterestedPeopleViewController *vc = [[ActivitDetailInterestedPeopleViewController alloc] init];
            vc.navigationItem.title = self.navigationItem.title;
            vc.interesteUsers = [interesteUsers copy];
            vc.feedid = _feedid;
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
        _mask.headline.text = [CoreData_Helper GetActivityEntity:self.feedid].topic;
        _mask.user.text = [CoreData_Helper GetUserInfEntity:[CoreData_Helper GetActivityEntity:self.feedid].uid].uname;
        _mask.Date.text = [CoreData_Helper DateFromTimestamp:[CoreData_Helper GetActivityEntity:self.feedid].begin_time endTimestamp:[CoreData_Helper GetActivityEntity:self.feedid].end_time];
        _mask.typeText = [CoreData_Helper GetActivityEntity:self.feedid].activityType;
        [_mask.avatar setImageWithURL:[NSURL URLWithString:[CoreData_Helper GetActivityEntity:self.feedid].avatar_tiny_url] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    return _mask;
}

- (UIButton *)leftButton
{
    if (!_leftButton) {
        _leftButton = [[UIButton alloc] init];
        _leftButton.backgroundColor = DarkPink;
        
        [_leftButton addSubview:self.join];
        [_leftButton addSubview:self.joinImage];
        
        [_joinImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_leftButton addConstraint:[NSLayoutConstraint constraintWithItem:_joinImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_leftButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_leftButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_joinImage(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_joinImage)]];
        [_leftButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_joinImage(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_joinImage)]];
        
        [_join setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_leftButton addConstraint:[NSLayoutConstraint constraintWithItem:_join attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_joinImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_leftButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-45-[_joinImage]-6-[_join]-45-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_joinImage,_join)]];
        
        [_leftButton addTarget:self action:@selector(joinActivity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] init];
        _rightButton.backgroundColor = LightPink;
        
        [_rightButton addSubview:self.interest];
        [_rightButton addSubview:self.interestImage];
        
        [_interestImage setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_rightButton addConstraint:[NSLayoutConstraint constraintWithItem:_interestImage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_rightButton attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_rightButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_interestImage(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_interestImage)]];
        [_rightButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_interestImage(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_interestImage)]];
        
        [_interest setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_rightButton addConstraint:[NSLayoutConstraint constraintWithItem:_interest attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_interestImage attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_rightButton addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-45-[_interestImage]-6-[_interest]-45-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_interestImage,_interest)]];
        
        [_rightButton addTarget:self action:@selector(likeActivity:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

@synthesize join = _join;

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
        _interestImage.image = [UIImage imageNamed:@"activity－detial-heart.png"];
    }
    return _interestImage;
}

- (UIImageView *)joinImage
{
    if (!_joinImage) {
        _joinImage = [[UIImageView alloc] init];
        _joinImage.image = [UIImage imageNamed:@"activity－detial-join.png"];
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
