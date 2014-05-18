//
//  ActivityDetailUserViewController.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/17/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivityDetailUserViewController.h"
#import "AMPAvatarView.h"
@interface UserCell : UITableViewCell
@property (strong,nonatomic) AMPAvatarView *avatar;
@property (strong,nonatomic) UILabel *unverified;
@property (strong,nonatomic) UILabel *name;
@property (strong,nonatomic) UIButton *passVerify;
@property (strong,nonatomic) UIButton *deleteMember;
@end

@implementation UserCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.avatar];
        [self.contentView addSubview:self.name];
        [self.contentView addSubview:self.unverified];
        [self.contentView addSubview:self.passVerify];
        [self.contentView addSubview:self.deleteMember];
        
        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_avatar(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(40)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_avatar attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0] ];
        
        [_name setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_avatar]-15-[_name]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar,_name)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_name attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0] ];
        
        [_unverified setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_name]-6-[_unverified]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_name,_unverified)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_unverified attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_name attribute:NSLayoutAttributeTop multiplier:1.0 constant:0] ];
        
        [_passVerify setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_passVerify(42)]-7.5-[_deleteMember]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_passVerify,_deleteMember)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_passVerify(16)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_passVerify)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_passVerify attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0] ];
        
        [_deleteMember setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_deleteMember(42)]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deleteMember)]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_deleteMember(16)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_deleteMember)]];
        [self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_deleteMember attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0] ];
        
    }
    return self;
}

#pragma mark lazy initialization

- (AMPAvatarView *)avatar
{
    if (!_avatar) {
        _avatar = [[AMPAvatarView alloc] init];
        [_avatar setImage:[UIImage imageNamed:@"iron.png"]];
        _avatar.borderWith = 0;
        _avatar.shadowRadius = 0;
    }
    return _avatar;
}

- (UILabel *)name
{
    if (!_name) {
        _name = [[UILabel alloc] init];
        _name.textColor = [UIColor whiteColor];
        _name.font = [UIFont systemFontOfSize:12];
        _name.text = @"马大姐";
    }
    return _name;
}

- (UILabel *)unverified
{
    if (!_unverified) {
        _unverified = [[UILabel alloc] init];
        _unverified.backgroundColor = [UIColor redColor];
        _unverified.textColor = [UIColor whiteColor];
        _unverified.font = [UIFont systemFontOfSize:8];
        _unverified.text = @"未审核";
        _unverified.layer.cornerRadius = 2.0;
    }
    return _unverified;
}

- (UIButton *)passVerify
{
    if (!_passVerify) {
        _passVerify = [[UIButton alloc] init];
        _passVerify.backgroundColor = [UIColor greenColor];
        _passVerify.titleLabel.textColor = [UIColor whiteColor];
        _passVerify.titleLabel.font = [UIFont systemFontOfSize:9];
        [_passVerify setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [_passVerify setTitle:@"通过审核" forState:UIControlStateNormal];
        _passVerify.layer.cornerRadius = 2.0;
    }
    return _passVerify;
}

- (UIButton *)deleteMember
{
    if (!_deleteMember) {
        _deleteMember = [[UIButton alloc] init];
        _deleteMember.backgroundColor = [UIColor grayColor];
        _deleteMember.titleLabel.font = [UIFont systemFontOfSize:9];
        _deleteMember.titleLabel.textColor = [UIColor whiteColor];
        [_deleteMember setTitleEdgeInsets:UIEdgeInsetsMake(2, 2, 2, 2)];
        [_deleteMember setTitle:@"删除成员" forState:UIControlStateNormal];
        _deleteMember.layer.cornerRadius = 2.0;
        [_deleteMember addTarget:self action:@selector(dayin) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteMember;
}

- (void)dayin

{
    NSLog(@"sajkasjkasjkasjkjkas");
}

@end




@interface ActivityDetailUserViewController ()
@property (strong,nonatomic) UIView *header;
@property (nonatomic,strong) UITableView *tableview;
@end

@implementation ActivityDetailUserViewController

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
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:nil];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.tableview.allowsSelection = NO;
    [self setBackgroundImage:[UIImage imageNamed:@"pic.jpg"] andBlurEnable:YES];
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableview];
    [_tableview registerClass:[UserCell class] forCellReuseIdentifier:@"usercell"];
    
    [_header setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_header]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_header)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_header(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_header)]];
    
    [_tableview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableview)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_header][_tableview]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_header,_tableview)]];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((UIViewController *)(self.navigationController.viewControllers)[[self.navigationController.viewControllers indexOfObject:self] - 1]).navigationItem.title = @"";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark tableView datasource and delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"usercell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark lazy initialization

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] init];
        _header.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"活动用户";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:12];
        [_header addSubview:label];
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_header addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        [_header addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label(==_header)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label,_header)]];

    }
    return _header;
}

- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_tableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        _tableview.backgroundColor = [UIColor clearColor];
    }
    return _tableview;
    
}

@end
