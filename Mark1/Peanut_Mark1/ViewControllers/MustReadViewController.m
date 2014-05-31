//
//  MustReadViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "MustReadViewController.h"
#import "NoReadCell.h"
#import "DateCell.h"
#import "MustReadTableViewCell.h"
#import "MustReaddetialViewController.h"
#import "MJRefresh.h"
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
    NSMutableArray *cellinfo;
    UILabel *datelabel;
}
@property (nonatomic,strong) UIView *dateHeadView;
@property (nonatomic,strong) UITableView *readTableView;
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
//    [self.readTableView beginRefreshing];
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
    timeSp = [NSString stringWithFormat:@"%d",(int)[[NSDate date] timeIntervalSince1970]];
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
    [self.readTableView registerClass:[NoReadCell class] forCellReuseIdentifier:@"noreadCell"];
    [self.readTableView registerClass:[DateCell class] forCellReuseIdentifier:@"dateCell"];
    
//    __weak MustReadViewController *weakSelf =self;
//    [self.readTableView addHeaderWithCallback:^{
//        [weakSelf pullDownBeginRefreshAction];
//    }];
//    [self.readTableView addFooterWithCallback:^{
//        [weakSelf pullUpBeginRefreshAction];
//    }];
    
//    [self.readTableView setPullDownBeginRefreshAction:@selector(pullDownBeginRefreshAction)];
//    [self.readTableView setPullUpBeginRefreshAction:@selector(pullUpBeginRefreshAction)];
    __weak MustReadViewController *weakSelf =self;
    [_readTableView addHeaderWithCallback:^{
        [weakSelf pullDownBeginRefreshAction];
    }];
    
    [_readTableView addFooterWithCallback:^{
        [weakSelf pullUpBeginRefreshAction];
    }];

    [self.readTableView headerBeginRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)processData:(NSMutableArray *)sourcedata
{
    NSMutableArray *outdata;
    outdata = nil;
    outdata = [[NSMutableArray alloc] init];
    int n = [data count];
    for (int i = 0; i < n; i++) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[data[i] valueForKey:@"publish_time"] intValue]];
        NSString *datestr = [formatter stringFromDate:date];
        if (i == 0) {
            if ([datestr isEqualToString:timeStr]) {
                [outdata addObject:@{@"type":@"0",@"index":[NSString stringWithFormat:@"%d",i]}];
            }
            else{
                [outdata addObject:@{@"type":@"2"}];
                [outdata addObject:@{@"type":@"1",@"date":[NSString stringWithFormat:@"%@",datestr]}];
                [outdata addObject:@{@"type":@"0",@"index":[NSString stringWithFormat:@"%d",i]}];
            }
        }
        else{
            NSDate *date2 = [NSDate dateWithTimeIntervalSince1970:[[data[i-1] valueForKey:@"publish_time"] intValue]];
            NSString *datestr2 = [formatter stringFromDate:date2];
            if ([datestr isEqualToString:datestr2]) {
                [outdata addObject:@{@"type":@"0",@"index":[NSString stringWithFormat:@"%d",i]}];
            }
            else{
                [outdata addObject:@{@"type":@"1",@"date":[NSString stringWithFormat:@"%@",datestr]}];
                [outdata addObject:@{@"type":@"0",@"index":[NSString stringWithFormat:@"%d",i]}];
            }
        }
    }
    cellinfo = outdata;
}

- (void)pullDownBeginRefreshAction
{
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Daily&act=dailyread_list" parameters:@{@"page":@"1",@"count":[NSString stringWithFormat:@"%d",COUNT_OF_PAGE]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            data = [[responseObject valueForKey:@"data"] mutableCopy];
            userinfo = [[[responseObject valueForKey:@"data"] valueForKey:@"user_info"] mutableCopy];
            [self processData:data];
            [_readTableView reloadData];
            [_readTableView headerEndRefreshing];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [_readTableView headerEndRefreshing];
    }];
}

- (void)pullUpBeginRefreshAction
{
    unsigned int page = [data count]/COUNT_OF_PAGE+1;
    if ([data count]%COUNT_OF_PAGE == 0) {
        [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Daily&act=dailyread_list" parameters:@{@"page":[NSString stringWithFormat:@"%d",page],@"count":[NSString stringWithFormat:@"%d",COUNT_OF_PAGE]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
            {
                [data addObjectsFromArray:[responseObject valueForKey:@"data"]];
                [userinfo addObjectsFromArray:[[responseObject valueForKey:@"data"] valueForKey:@"user_info"]];
                [self processData:data];
                [_readTableView reloadData];
                [_readTableView headerEndRefreshing];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [_readTableView headerEndRefreshing];
        }];
    }
    else
        [_readTableView headerEndRefreshing];
}

#pragma mark UITableView datasource and delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[cellinfo[indexPath.section] valueForKey:@"type"] isEqualToString:@"0"]) {
        MustReaddetialViewController *detialView = [[MustReaddetialViewController alloc] init];
        int index = [[cellinfo[indexPath.section] valueForKey:@"index"] intValue];
        [detialView.picture setImageWithURL:[data[index] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [detialView setTitle:[data[index] valueForKey:@"title"]];
        [detialView.atitle setText:[data[index] valueForKey:@"title"]];
        [detialView.avatar setImageWithURL:[userinfo[index] valueForKey:@"avatar_tiny"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [detialView.user setText:[userinfo[index] valueForKey:@"uname"]];
        [detialView.like setTitle:[data[index] valueForKey:@"digg_count"] forState:UIControlStateNormal];
        [detialView.comment setTitle:[data[index] valueForKey:@"comment_count"] forState:UIControlStateNormal];
        NSString *html = [data[index] valueForKey:@"content"];
        NSString *imghtml = [html stringByReplacingOccurrencesOfString:@"class=\"post-img\">" withString:@"style=\"width:300px;\" class=\"post-img\">"];
        [detialView.content loadHTMLString:imghtml baseURL:nil];
        [self.readTableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.NavigationController pushViewController:detialView animated:YES];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[cellinfo[indexPath.section] valueForKey:@"type"] isEqualToString:@"2"]) {
        static NSString *CellIdentifier = @"noreadCell";
        NoReadCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        return cell;
    }
    else if ([[cellinfo[indexPath.section] valueForKey:@"type"] isEqualToString:@"1"]) {
        static NSString *CellIdentifier = @"dateCell";
        DateCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell.datelabel setText:[cellinfo[indexPath.section] valueForKey:@"date"]];
        return cell;
    }
    else{
        static NSString *CellIdentifier = @"mustreadCell";
        MustReadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        int index = [[cellinfo[indexPath.section] valueForKey:@"index"] intValue];
        [cell.picture setImageWithURL:[data[index] valueForKey:@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [cell.title setText:[data[index] valueForKey:@"title"]];
        [cell.avatar setImageWithURL:[userinfo[index] valueForKey:@"avatar_tiny"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [cell.user setText:[userinfo[index] valueForKey:@"uname"]];
        [cell.like setTitle:[data[index] valueForKey:@"digg_count"] forState:UIControlStateNormal];
        [cell.comment setTitle:[data[index] valueForKey:@"comment_count"] forState:UIControlStateNormal];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath
{
    CGRect rect = [tableView convertRect:cell.frame toView:[tableView superview]];
    if ([[cellinfo[indexPath.section] valueForKey:@"type"] isEqualToString:@"1"] && rect.origin.y <=20) {
        [datelabel setText:[cellinfo[indexPath.section] valueForKey:@"date"]];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGRect rect = [tableView convertRect:cell.frame toView:[tableView superview]];
    if (indexPath.section > 0) {
        if ([[cellinfo[indexPath.section-1] valueForKey:@"type"] isEqualToString:@"2"]){
            [datelabel setText:timeStr];
        }
        else if ([[cellinfo[indexPath.section] valueForKey:@"type"] isEqualToString:@"1"] && rect.origin.y <=20) {
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:[[data[[[cellinfo[indexPath.section-1] valueForKey:@"index"] intValue]] valueForKey:@"publish_time"] intValue]];
            NSString *datestr = [formatter stringFromDate:date];
            [datelabel setText:datestr];
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [cellinfo count];
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
    if ([[cellinfo[indexPath.section] valueForKey:@"type"] isEqualToString:@"0"]) {
        return 205.0;
    }
    return 30.0;
}
#pragma mark Head
- (UIView *)dateHeadView
{
    if (!_dateHeadView) {
        _dateHeadView = [[UIView alloc] init];
        
        
        datelabel = [[UILabel alloc] init];
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
- (UITableView *)readTableView
{
    if(!_readTableView)
    {
        _readTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
