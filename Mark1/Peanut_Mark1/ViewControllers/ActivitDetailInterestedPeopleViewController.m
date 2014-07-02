//
//  ActivitDetailInterestedPeopleViewController.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivitDetailInterestedPeopleViewController.h"
#import "UserCell.h"
#import "UIImageView+WebCache.h"
#import "CoreData-Helper.h"
@interface ActivitDetailInterestedPeopleViewController ()
{
    UIImageView *backImage;
    NSMutableArray *avatars;
}
@property (strong,nonatomic) UIView *header;
@property (nonatomic,strong) UITableView *tableview;
@property (nonatomic,strong) UIAlertView *alertView;
@end

@implementation ActivitDetailInterestedPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.interesteUsers = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    backImage = [[UIImageView alloc] init];
    avatars = [[NSMutableArray alloc] initWithCapacity:10];
    __weak ActivitDetailInterestedPeopleViewController *weakself = self;
    [backImage setImageWithURL:[NSURL URLWithString:[CoreData_Helper GetActivityEntity:self.feedid].cover_url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [weakself setBackgroundImage:image andBlurEnable:YES];
    }];
    self.tableview.allowsSelection = NO;
    
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
    
    //[self getAvatar];
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

#pragma mark -tableView datasource and delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"usercell";
    UserCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.unverified.hidden = YES;
    cell.name.text = [_interesteUsers[indexPath.row] valueForKey:@"uname"];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_interesteUsers count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

#pragma mark -network

- (void)getAvatar
{
    for (NSDictionary *dic in _interesteUsers) {
        UIImageView *imageview = [[UIImageView alloc] init];
        [imageview setImageWithURL:[NSURL URLWithString:[dic valueForKey:@"avatar_tiny"]] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [avatars addObject:image];
            ((UserCell *)[_tableview cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]]).avatar.image = image;
        }];
    }
}

#pragma mark -lazy initialization

- (UIView *)header
{
    if (!_header) {
        _header = [[UIView alloc] init];
        _header.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.text = @"感兴趣的人";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = Dark_Red;
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
