//
//  MustReadViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "MustReadViewController.h"
#import "MustReadTableViewCell.h"
#import "MustReaddetialViewController.h"
#import "PullRefreshTableView.h"
#import "CoreData-Helper.h"
#import "PublicLib.h"
#define COUNT_OF_PAGE 5
@interface MustReadViewController ()
{
    NSDateFormatter *formatter;
    NSString *timeStr;
    NSString *timeSp;
    NSMutableArray *data;
    NSMutableArray *userinfo;
}
@property (nonatomic,strong) UIView *dateHeadView;
@property (nonatomic,strong) PullRefreshTableView *readTableView;
@end

@implementation MustReadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.title = @"必读";
    [self.readTableView beginRefreshing];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY年MM月dd日"];
    timeStr = [formatter stringFromDate:[NSDate date]];
    timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    [self.view addSubview:self.dateHeadView];
    [self.view addSubview:self.readTableView];
    
    [_dateHeadView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_dateHeadView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_dateHeadView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_dateHeadView(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_dateHeadView)]];
    
    [_readTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_readTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_readTableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_readTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_readTableView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_readTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_dateHeadView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    [self.readTableView registerClass:[MustReadTableViewCell class] forCellReuseIdentifier:@"mustreadCell"];
    
//    [self.readTableView setPullDownBeginRefreshAction:@selector(pullDownBeginRefreshAction)];
//    [self.readTableView setPullUpBeginRefreshAction:@selector(pullUpBeginRefreshAction)];
    __weak MustReadViewController *weakSelf =self;
    [_readTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDownBeginRefreshAction:refreshView];
    }];
    [_readTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUpBeginRefreshAction:refreshView];
    }];

    [self.readTableView beginRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self.readTableView freeHeaderFooter];
}

- (void)pullDownBeginRefreshAction:(MJRefreshBaseView *)tableView
{
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Daily&act=dailyread_list" parameters:@{@"page":@"1",@"count":[NSString stringWithFormat:@"%d",COUNT_OF_PAGE]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            data = [[responseObject valueForKey:@"data"] mutableCopy];
            userinfo = [[[responseObject valueForKey:@"data"] valueForKey:@"user_info"] mutableCopy];
            [_readTableView reloadData];
            [tableView endRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [tableView endRefreshing];
    }];
}

- (void)pullUpBeginRefreshAction:(MJRefreshBaseView *)tableView
{
    unsigned int page = [data count]/COUNT_OF_PAGE+1;
    if ([data count]%COUNT_OF_PAGE == 0) {
        [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Daily&act=dailyread_list" parameters:@{@"page":[NSString stringWithFormat:@"%d",page],@"count":[NSString stringWithFormat:@"%d",COUNT_OF_PAGE]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
            {
                [data addObjectsFromArray:[responseObject valueForKey:@"data"]];
                [userinfo addObjectsFromArray:[[responseObject valueForKey:@"data"] valueForKey:@"user_info"]];
                [_readTableView reloadData];
                [tableView endRefreshing];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [tableView endRefreshing];
        }];
    }
    else
        [tableView endRefreshing];
}

#pragma mark UITableView datasource and delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MustReaddetialViewController *detialView = [[MustReaddetialViewController alloc] init];
    [detialView.picture setImageWithURL:[data[indexPath.section] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [detialView setTitle:[data[indexPath.section] valueForKey:@"title"]];
    [detialView.atitle setText:[data[indexPath.section] valueForKey:@"title"]];
    [detialView.avatar setImageWithURL:[userinfo[indexPath.section] valueForKey:@"avatar_tiny"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [detialView.user setText:[userinfo[indexPath.section] valueForKey:@"uname"]];
    [detialView.like setTitle:[data[indexPath.section] valueForKey:@"digg_count"] forState:UIControlStateNormal];
    [detialView.comment setTitle:[data[indexPath.section] valueForKey:@"comment_count"] forState:UIControlStateNormal];
    [detialView.content loadHTMLString:[data[indexPath.section] valueForKey:@"content"] baseURL:nil];
    [self.readTableView deselectRowAtIndexPath: indexPath animated:YES];
    [self.NavigationController pushViewController:detialView animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mustreadCell";
    MustReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    [cell.picture setImageWithURL:[data[indexPath.section] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell.title setText:[data[indexPath.section] valueForKey:@"title"]];
    [cell.avatar setImageWithURL:[userinfo[indexPath.section] valueForKey:@"avatar_tiny"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    [cell.user setText:[userinfo[indexPath.section] valueForKey:@"uname"]];
    [cell.like setTitle:[data[indexPath.section] valueForKey:@"digg_count"] forState:UIControlStateNormal];
    [cell.comment setTitle:[data[indexPath.section] valueForKey:@"comment_count"] forState:UIControlStateNormal];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [data count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205.0;
}
#pragma mark Head
- (UIView *)dateHeadView
{
    if (!_dateHeadView) {
        _dateHeadView = [[UIView alloc] init];
        
        
        UILabel *datelabel = [[UILabel alloc] init];
        _dateHeadView.backgroundColor = [UIColor whiteColor];
        datelabel.text = timeStr;
        datelabel.textAlignment = NSTextAlignmentLeft;
        datelabel.textColor = [UIColor redColor];
        datelabel.font = [UIFont systemFontOfSize:12];
        [_dateHeadView addSubview:datelabel];
        [datelabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_dateHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[datelabel(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(datelabel)]];
        [_dateHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[datelabel(==_dateHeadView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(datelabel,_dateHeadView)]];
        
    }
    return _dateHeadView;
}
- (PullRefreshTableView *)readTableView
{
    if(!_readTableView)
    {
        _readTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_readTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _readTableView.delegate = self;
        _readTableView.dataSource = self;
    }
    return _readTableView;
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

@end
