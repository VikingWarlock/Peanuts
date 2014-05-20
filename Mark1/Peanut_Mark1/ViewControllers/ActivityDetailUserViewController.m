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
        [self.contentView addSubview:self.deleteMember];
        [self.contentView addSubview:self.unverified];
        [self.contentView addSubview:self.passVerify];

        
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

#pragma mark -lazy initialization

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
        _passVerify.hidden = YES;
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
        _deleteMember.hidden = YES;
    }
    return _deleteMember;
}

@end




@interface ActivityDetailUserViewController ()
{
    NSMutableArray *users;
    NSIndexPath *deletedIndexPath;
    NSMutableDictionary *isVerified1;
    NSMutableDictionary *isVerified2;
    NSMutableDictionary *isVerified3;
    NSMutableDictionary *isVerified4;
    NSMutableDictionary *d;
    BOOL isEdit;
}
@property (strong,nonatomic) UIView *header;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIAlertView *alertView;
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
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showEditButton)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    self.tableview.allowsSelection = NO;
    [self setBackgroundImage:[UIImage imageNamed:@"pic.jpg"] andBlurEnable:YES];
    isEdit = NO;
    deletedIndexPath = [[NSIndexPath alloc] init];
    
    isVerified1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"isVerified", nil];
    isVerified2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0",@"isVerified", nil];
    isVerified3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0",@"isVerified", nil];
    isVerified4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"isVerified", nil];
    users = [[NSMutableArray alloc] initWithObjects:isVerified1,isVerified2,isVerified3,isVerified4, nil];
    
    [self.view addSubview:self.header];
    [self.view addSubview:self.tableview];
    [self.view addSubview:self.alertView];
    [_tableview registerClass:[UserCell class] forCellReuseIdentifier:@"usercell"];
    
    [_header setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_header]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_header)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_header(%f)]",HEIGHT_OF_HEADER_OR_FOOTER] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_header)]];
    
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
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -method

- (void)addMember:(id)sender
{
    NSIndexPath *indexPath = [_tableview indexPathForCell:(UserCell *)((UIButton *)sender).superview.superview.superview];
    ((UserCell *)[_tableview cellForRowAtIndexPath:indexPath]).unverified.hidden = YES;
    ((UserCell *)[_tableview cellForRowAtIndexPath:indexPath]).passVerify.hidden = YES;
    [users[indexPath.row] setValue:[NSString stringWithFormat:@"1"] forKey:@"isVerified"];
}

- (void)deleteMember
{
    [users removeObjectAtIndex:deletedIndexPath.row];
    [_tableview deleteRowsAtIndexPaths:@[deletedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)showEditButton
{
    isEdit = !isEdit;
    for (int i = 0; i< [users count]; i++) {
        if ([[users[i] valueForKey:@"isVerified"] boolValue] == NO && isEdit == YES) {
            [users[i] setValue:[NSString stringWithFormat:@"%D",!isEdit] forKey:@"isVerified"];
        }
    }
    [_tableview reloadData];
}

-(void)showAlert:(id)sender
{
    deletedIndexPath = [_tableview indexPathForCell:(UserCell *)((UIButton *)sender).superview.superview.superview];
    [self.alertView show];
}

#pragma mark -tableView datasource and delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"usercell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    [cell.deleteMember addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    [cell.passVerify addTarget:self action:@selector(addMember:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.passVerify.hidden = [[users[indexPath.row] valueForKey:@"isVerified"] boolValue] || !isEdit;
    cell.deleteMember.hidden = !isEdit;
    cell.unverified.hidden = [[users[indexPath.row] valueForKey:@"isVerified"] boolValue];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [users count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark -UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self deleteMember];
    }
}

#pragma mark -lazy initialization

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

- (UIAlertView *)alertView
{
    if (!_alertView) {
        _alertView = [[UIAlertView alloc] initWithTitle:nil message:@"确认删除该成员？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        _alertView.alertViewStyle = UIAlertViewStyleDefault;
    }
    return _alertView;
}

@end
