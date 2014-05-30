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

@interface ActivitDetailInterestedPeopleViewController ()
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
        self.userInfo = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableview.allowsSelection = NO;
    [self setBackgroundImage:[UIImage imageNamed:@"pic.jpg"] andBlurEnable:YES];
    
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
    cell.name.text = [_userInfo[indexPath.row] valueForKey:@"uname"];

    UIImageView *imageview = [[UIImageView alloc] init];
    [imageview setImageWithURL:[NSURL URLWithString:[self.userInfo[indexPath.row] valueForKey:@"avatar_small"]] placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
        [cell.avatar setImage:image];
        NSLog(@"cacheType:%D indexPath:%D name:%@\n", cacheType,indexPath.row,cell.name.text);
    }];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_userInfo count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
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
