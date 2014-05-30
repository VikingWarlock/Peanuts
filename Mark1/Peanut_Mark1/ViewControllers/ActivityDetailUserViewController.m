//
//  ActivityDetailUserViewController.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/17/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivityDetailUserViewController.h"
#import "AMPAvatarView.h"
#import "UserCell.h"
#import "PullRefreshTableView.h"

@interface ActivityDetailUserViewController ()
{
    NSIndexPath *deletedIndexPath;
    NSMutableDictionary *isVerified1;
    NSMutableDictionary *isVerified2;
    NSMutableDictionary *isVerified3;
    NSMutableDictionary *isVerified4;
    NSMutableDictionary *d;
    BOOL isEdit;
}
@property (strong,nonatomic) UIView *header;
@property (nonatomic,strong) PullRefreshTableView *tableview;
@property (nonatomic,strong) UIAlertView *alertView;
@end

@implementation ActivityDetailUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.users = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(showEditButton)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    self.tableview.allowsSelection = NO;
    [self setBackgroundImage:self.bkImage andBlurEnable:YES];
    isEdit = NO;
    deletedIndexPath = [[NSIndexPath alloc] init];
//    
//    isVerified1 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"isVerified", nil];
//    isVerified2 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0",@"isVerified", nil];
//    isVerified3 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"0",@"isVerified", nil];
//    isVerified4 = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"1",@"isVerified", nil];
//    users = [[NSMutableArray alloc] initWithObjects:isVerified1,isVerified2,isVerified3,isVerified4, nil];
    
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
    
    __weak ActivityDetailUserViewController *weakSelf =self;
    [self.tableview setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDown:refreshView];
    }];
    [self.tableview setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUp:refreshView];
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ((UIViewController *)(self.navigationController.viewControllers)[[self.navigationController.viewControllers indexOfObject:self] - 1]).navigationItem.title = @"";
    //[self sortArrayByIsVerified];
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

- (void)dealloc
{
    [self.tableview freeHeaderFooter];
}

#pragma mark -Network stuff

-(void)pullDown:(MJRefreshBaseView*)refreshView
{
    NSLog(@"this is pull down");
    [refreshView endRefreshing];
}

-(void)pullUp:(MJRefreshBaseView*)refreshView
{
    NSLog(@"this is pull up");
    [refreshView endRefreshing];
}

#pragma mark -method

- (void)addMember:(id)sender
{
    NSIndexPath *indexPath = [_tableview indexPathForCell:(UserCell *)((UIButton *)sender).superview.superview.superview];
    ((UserCell *)[_tableview cellForRowAtIndexPath:indexPath]).unverified.hidden = YES;
    ((UserCell *)[_tableview cellForRowAtIndexPath:indexPath]).passVerify.hidden = YES;
    [_users[indexPath.row] setValue:[NSString stringWithFormat:@"1"] forKey:@"isVerified"];
}

- (void)deleteMember
{
    [_users removeObjectAtIndex:deletedIndexPath.row];
    [_tableview deleteRowsAtIndexPaths:@[deletedIndexPath] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)showEditButton
{
    isEdit = !isEdit;
    for (int i = 0; i< [_users count]; i++) {
        if ([[_users[i] valueForKey:@"isVerified"] boolValue] == NO && isEdit == YES) {
            [_users[i] setValue:[NSString stringWithFormat:@"%D",!isEdit] forKey:@"isVerified"];
        }
    }
    [_tableview reloadData];
}

-(void)showAlert:(id)sender
{
    deletedIndexPath = [_tableview indexPathForCell:(UserCell *)((UIButton *)sender).superview.superview.superview];
    [self.alertView show];
}

- (void)sortArrayByIsVerified
{
    [_users sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        int a = [[obj1 valueForKey:@"isVerified"] intValue];
        int b = [[obj2 valueForKey:@"isVerified"] intValue];
        if (a > b)
            return NSOrderedDescending;
        else
            return NSOrderedAscending;
    }];
}

#pragma mark -tableView datasource and delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"usercell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.name.text = [_users[indexPath.row] valueForKey:@"uname"];
    
    
    
    
    [cell.deleteMember addTarget:self action:@selector(showAlert:) forControlEvents:UIControlEventTouchUpInside];
    [cell.passVerify addTarget:self action:@selector(addMember:) forControlEvents:UIControlEventTouchUpInside];
    
    cell.passVerify.hidden = [[_users[indexPath.row] valueForKey:@"isVerified"] boolValue] || !isEdit;
    cell.deleteMember.hidden = !isEdit;
    cell.unverified.hidden = [[_users[indexPath.row] valueForKey:@"isVerified"] boolValue];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_users count];
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

- (PullRefreshTableView *)tableview
{
    if (!_tableview) {
        _tableview = [[PullRefreshTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
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
