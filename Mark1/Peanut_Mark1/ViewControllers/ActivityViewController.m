//
//  ActivityViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivityViewController.h"
#import "PublicLib.h"
#import "ActivityTableViewCell.h"
#import "ActivityDetailViewController.h"
#import "MJRefresh.h"
#import "CoreData-Helper.h"

#define PRESENT_TITLE_COLOR Dark_Red
#define PAST_TITLE_COLOR [UIColor grayColor]
#define COUNT_OF_PAGE 10
@interface ActivityViewController ()
{
    NSMutableArray *onlineArrayPrg;
    NSMutableArray *onlineArrayReviewed;
    NSMutableArray *offlineArrayPrg;
    NSMutableArray *offlineArrayReviewed;
    
    unsigned int onlinePagePrg;
    unsigned int offlinePagePrg;
    unsigned int onlinePageReviewed;
    unsigned int offlinePageReviewed;
    
    NSArray *bindingFooterToBottom;
    NSArray *bindingFooterToTop;
    BOOL status;//1代表展示正在进行的活动，0代表展示往期活动
    BOOL oldStatus;
    BOOL shouldLoadReviewedTableView;
    CGPoint upPoint;
    CGPoint downPoint;
    UIView *separatorLine;
    NSMutableArray *sweepSpeed;
    NSMutableArray *downSpeed;
    
}
@property (nonatomic,strong) UITableView *progressingTableView;
@property (nonatomic,strong) UITableView *ReviewedTableView;
@property (nonatomic,strong) UIView *progressingHeadView;
@property (nonatomic,strong) UIView *ReviewedFooterView;
@property (nonatomic,strong) CustomSegmentedControl *progressingSegmentedControl;
@property (nonatomic,strong) CustomSegmentedControl *ReviewedSegmentedControl;
@property (nonatomic,strong) UILabel *progressing;
@property (nonatomic,strong) UILabel *reviewed;

@end

@implementation ActivityViewController

#pragma mark -vc life cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        shouldLoadReviewedTableView  = YES;
        status = 1;
        oldStatus = 1;
        
        onlinePagePrg = 2;
        onlinePageReviewed = 2;
        offlinePagePrg = 2;
        offlinePageReviewed = 2;
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
//    UIBarButtonItem *Button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
//    [self.navigationItem setRightBarButtonItem:Button];
    [self.view addSubview:self.progressingTableView];
    [self.view addSubview:self.progressingHeadView];
    [self.view addSubview:self.ReviewedFooterView];
    [self.progressingTableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"progressingCell"];
    sweepSpeed = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0", nil];
    downSpeed = [[NSMutableArray alloc] initWithObjects:@"0",@"0",@"0" ,nil];

    [_progressingTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_progressingTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingTableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_progressingTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingTableView)]];
    
    __weak ActivityViewController *weakSelf =self;
    [self.progressingTableView addHeaderWithCallback:^{
        [weakSelf pullDownProgressingIsOnline:YES IsProgressing:YES];
    }];
    [self.progressingTableView addFooterWithCallback:^{
        [weakSelf pullUpProgressingIsOnline:YES IsProgressing:YES];
    }];
    [self.ReviewedTableView addHeaderWithCallback:^{
        [weakSelf pullDownReviewedIsOnline:YES IsProgressing:NO];
    }];
    [self.ReviewedTableView addFooterWithCallback:^{
        [weakSelf pullUpReviewedIsOnline:YES IsProgressing:NO];
    }];
    
    upPoint = CGPointMake(self.view.frame.size.width / 2,HEIGHT_OF_HEADER_OR_FOOTER + HEIGHT_OF_HEADER_OR_FOOTER / 2 + 1);
    [self.progressingTableView headerBeginRefreshing];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"活动";
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

#pragma mark -UITableView datasource and delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"progressingCell";
    ActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (tableView.tag == 0 && _progressingSegmentedControl.isOnline) {
        [cell.picture setImageWithURL:[NSURL URLWithString:[onlineArrayPrg[indexPath.section] valueForKey:@"cover"] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [cell.avatar setImageWithURL:[[onlineArrayPrg[indexPath.section] valueForKey:@"user_info"] valueForKey:@"avatar_tiny"]];
        cell.user.text = [[onlineArrayPrg[indexPath.section] valueForKey:@"user_info"] valueForKey:@"uname"];
        cell.Date.text = [self DateFromTimestamp:[onlineArrayPrg[indexPath.section] valueForKey:@"begin_time"] endTimestamp:[onlineArrayPrg[indexPath.section] valueForKey:@"end_time"] ];
        cell.title.text = [onlineArrayPrg[indexPath.section] valueForKey:@"topic"];
        cell.feedid = [onlineArrayPrg[indexPath.section] valueForKey:@"feed_id"];
        cell.typeText = [onlineArrayPrg[indexPath.section] valueForKey:@"activityType"];
    }
    else if (tableView.tag == 0 && !_progressingSegmentedControl.isOnline) {
        [cell.picture setImageWithURL:[NSURL URLWithString:[offlineArrayPrg[indexPath.section] valueForKey:@"cover"] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [cell.avatar setImageWithURL:[[offlineArrayPrg[indexPath.section] valueForKey:@"user_info"] valueForKey:@"avatar_tiny"]];
        cell.user.text = [[offlineArrayPrg[indexPath.section] valueForKey:@"user_info"] valueForKey:@"uname"];
        cell.Date.text = [self DateFromTimestamp:[offlineArrayPrg[indexPath.section] valueForKey:@"begin_time"] endTimestamp:[offlineArrayPrg[indexPath.section] valueForKey:@"end_time"] ];
        cell.title.text = [offlineArrayPrg[indexPath.section] valueForKey:@"topic"];
        cell.feedid = [offlineArrayPrg[indexPath.section] valueForKey:@"feed_id"];
        cell.typeText = [offlineArrayPrg[indexPath.section] valueForKey:@"activityType"];
    }
    else if (tableView.tag == 1 && _ReviewedSegmentedControl.isOnline) {
        [cell.picture setImageWithURL:[NSURL URLWithString:[onlineArrayReviewed[indexPath.section] valueForKey:@"cover"] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [cell.avatar setImageWithURL:[[onlineArrayReviewed[indexPath.section] valueForKey:@"user_info"] valueForKey:@"avatar_tiny"]];
        cell.user.text = [[onlineArrayReviewed[indexPath.section] valueForKey:@"user_info"] valueForKey:@"uname"];
        cell.Date.text = [self DateFromTimestamp:[onlineArrayReviewed[indexPath.section] valueForKey:@"begin_time"] endTimestamp:[onlineArrayReviewed[indexPath.section] valueForKey:@"end_time"] ];
        cell.title.text = [onlineArrayReviewed[indexPath.section] valueForKey:@"topic"];
        cell.feedid = [onlineArrayReviewed[indexPath.section] valueForKey:@"feed_id"];
        cell.typeText = [onlineArrayReviewed[indexPath.section] valueForKey:@"activityType"];
    }
    else if (tableView.tag == 1 && !_ReviewedSegmentedControl.isOnline) {
        [cell.picture setImageWithURL:[NSURL URLWithString:[offlineArrayReviewed[indexPath.section] valueForKey:@"cover"] ] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
        [cell.avatar setImageWithURL:[[offlineArrayReviewed[indexPath.section] valueForKey:@"user_info"] valueForKey:@"avatar_tiny"]];
        cell.user.text = [[offlineArrayReviewed[indexPath.section] valueForKey:@"user_info"] valueForKey:@"uname"];
        cell.Date.text = [self DateFromTimestamp:[offlineArrayReviewed[indexPath.section] valueForKey:@"begin_time"] endTimestamp:[offlineArrayReviewed[indexPath.section] valueForKey:@"end_time"] ];
        cell.title.text = [offlineArrayReviewed[indexPath.section] valueForKey:@"topic"];
        cell.feedid = [offlineArrayReviewed[indexPath.section] valueForKey:@"feed_id"];
        cell.typeText = [offlineArrayReviewed[indexPath.section] valueForKey:@"activityType"];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 0 && _progressingSegmentedControl.isOnline) {
        return [onlineArrayPrg count];
    }
    else if(tableView.tag == 0 && !_progressingSegmentedControl.isOnline)
    {
        return [offlineArrayPrg count];
    }
    else if(tableView.tag == 1 && _ReviewedSegmentedControl.isOnline)
    {
        return [onlineArrayReviewed count];
    }
    else if(tableView.tag == 1 && !_ReviewedSegmentedControl.isOnline)
    {
        return [offlineArrayReviewed count];
    }
    else
        return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return 10.0;
    else
        return 15.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 205.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityTableViewCell *cell = (ActivityTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] init];
    vc.feedid = cell.feedid;

    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -Network stuff

- (void)ClickedButtonIsOnline:(NSInteger)isOnline IsPresenting:(NSInteger)ispresenting IsProgressing:(NSInteger)isprogressing
{
    __weak ActivityViewController *weakSelf =self;
    if (isprogressing) {
        [self.progressingTableView addHeaderWithCallback:^{
            [weakSelf pullDownProgressingIsOnline:isOnline IsProgressing:isprogressing];
        }];
        [self.progressingTableView addFooterWithCallback:^{
            [weakSelf pullUpProgressingIsOnline:isOnline IsProgressing:isprogressing];
        }];
        if (ispresenting) {
            [_progressingTableView headerBeginRefreshing];
        }
    }
        else
        {
            [self.ReviewedTableView addHeaderWithCallback:^{
                [weakSelf pullDownReviewedIsOnline:isOnline IsProgressing:isprogressing];
            }];
            [self.ReviewedTableView addFooterWithCallback:^{
                [weakSelf pullUpReviewedIsOnline:isOnline IsProgressing:isprogressing];
            }];
            if (ispresenting) {
                [_ReviewedTableView headerBeginRefreshing];
        }
    }
}

-(void)pullDownProgressingIsOnline:(BOOL)isOline IsProgressing:(BOOL)isprogressing
{
    unsigned int *page;
    
    if (isOline) {
        page = &onlinePagePrg;
    }
    else if (!isOline)
    {
        page = &offlinePagePrg;
    }
    
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_list" parameters:@{@"page":@"1",@"count":[NSString stringWithFormat:@"%d",COUNT_OF_PAGE],@"activityType":[NSString stringWithFormat:@"%d",!isOline],@"isCurrent":[NSString stringWithFormat:@"%d",isprogressing]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            if (isOline) {
                onlineArrayPrg = [[responseObject valueForKey:@"data"] mutableCopy];
            }
            else
            {
                offlineArrayPrg = [[responseObject valueForKey:@"data"] mutableCopy];;
            }
            [_progressingTableView reloadData];
            [_progressingTableView headerEndRefreshing];
            *page = 2;
            for (NSDictionary *dic in [responseObject valueForKey:@"data"]) {
                [CoreData_Helper addActivityEntity:dic];
                [CoreData_Helper addUserInfoEntity:[dic objectForKey:@"user_info"]];
            }
            NSLog(@"%@",[responseObject valueForKey:@"data"]);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [_progressingTableView headerEndRefreshing];
    }];
}

-(void)pullUpProgressingIsOnline:(BOOL)isOline IsProgressing:(BOOL)isprogressing
{
    unsigned int *page = NULL;
    NSMutableArray *array;
    if (isOline) {
        page = &onlinePagePrg;
        array = onlineArrayPrg;
    }
    else if (!isOline)
    {
        page = &offlinePagePrg;
        array = offlineArrayPrg;
    }
    
    if ([array count]%COUNT_OF_PAGE == 0) {//如果一页没填满就不刷新
        
        [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_list" parameters:@{@"page":[NSString stringWithFormat:@"%D",*page],@"count":[NSString stringWithFormat:@"%d",COUNT_OF_PAGE],@"activityType":[NSString stringWithFormat:@"%d",!isOline],@"isCurrent":[NSString stringWithFormat:@"%d",isprogressing]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
            {
                if (isOline) {
                    [onlineArrayPrg addObjectsFromArray:[responseObject valueForKey:@"data"]];
                    (*page)++;
                }
                else
                {
                    [offlineArrayPrg addObjectsFromArray:[responseObject valueForKey:@"data"]];
                    (*page)++;
                }
                [_progressingTableView reloadData];
                [_progressingTableView footerEndRefreshing];
                for (NSDictionary *dic in [responseObject valueForKey:@"data"]) {
                    [CoreData_Helper addActivityEntity:dic];
                    [CoreData_Helper addUserInfoEntity:[dic objectForKey:@"user_info"]];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [_progressingTableView footerEndRefreshing];
        }];
            
    }
    else
        [_progressingTableView footerEndRefreshing];
}

-(void)pullDownReviewedIsOnline:(BOOL)isOline IsProgressing:(BOOL)isprogressing
{
    unsigned int *page;
    
    if (isOline) {
        page = &onlinePageReviewed;
    }
    else if (!isOline)
    {
        page = &offlinePageReviewed;
    }
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_list" parameters:@{@"page":@"1",@"count":[NSString stringWithFormat:@"%d",COUNT_OF_PAGE],@"activityType":[NSString stringWithFormat:@"%d",!isOline],@"isCurrent":[NSString stringWithFormat:@"%d",isprogressing]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            if (isOline) {
                onlineArrayReviewed = [[responseObject valueForKey:@"data"] mutableCopy];
            }
            else
            {
                offlineArrayReviewed = [[responseObject valueForKey:@"data"] mutableCopy];
            }
            *page = 2;
            [_ReviewedTableView reloadData];
            [_ReviewedTableView headerEndRefreshing];
            for (NSDictionary *dic in [responseObject valueForKey:@"data"]) {
                [CoreData_Helper addActivityEntity:dic];
                [CoreData_Helper addUserInfoEntity:[dic objectForKey:@"user_info"]];
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        [_ReviewedTableView headerEndRefreshing];
    }];
}

-(void)pullUpReviewedIsOnline:(BOOL)isOline IsProgressing:(BOOL)isprogressing
{
    unsigned int *page = NULL;
    NSMutableArray *array;
    if (isOline) {
        page = &onlinePageReviewed;
        array = onlineArrayReviewed;
    }
    else if (!isOline)
    {
        page = &offlinePageReviewed;
        array = offlineArrayReviewed;
    }
    
    if ([array count]%COUNT_OF_PAGE == 0) {//如果一页没填满就不刷新
        
        [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Activity&act=activity_list" parameters:@{@"page":[NSString stringWithFormat:@"%D",*page],@"count":[NSString stringWithFormat:@"%d",COUNT_OF_PAGE],@"activityType":[NSString stringWithFormat:@"%d",!isOline],@"isCurrent":[NSString stringWithFormat:@"%d",isprogressing]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
            {
                if (isOline) {
                    [onlineArrayReviewed addObjectsFromArray:[responseObject valueForKey:@"data"]];
                    (*page)++;
                }
                else
                {
                    [offlineArrayReviewed addObjectsFromArray:[responseObject valueForKey:@"data"]];
                    (*page)++;
                }
                [_ReviewedTableView reloadData];
                [_ReviewedTableView footerEndRefreshing];
                for (NSDictionary *dic in [responseObject valueForKey:@"data"]) {
                    [CoreData_Helper addActivityEntity:dic];
                    [CoreData_Helper addUserInfoEntity:[dic objectForKey:@"user_info"]];
                }
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            [_ReviewedTableView footerEndRefreshing];
        }];
        
    }
    else
        [_ReviewedTableView footerEndRefreshing];
}

- (NSString *)DateFromTimestamp:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp
{
    NSDate *begin = [NSDate dateWithTimeIntervalSince1970:[beginTimestamp intValue]];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:[endTimestamp intValue]];

    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *date = [NSString stringWithFormat:@"%@ - %@",[formatter stringFromDate:begin],[formatter stringFromDate:end]];
    return date;
}

#pragma mark -status switch

- (void)handleTap:(UITapGestureRecognizer *)recognizer//顶部的tableview的点击事件
{
    downPoint = CGPointMake(self.view.frame.size.width / 2,self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER / 2);

    if (shouldLoadReviewedTableView == YES) {
        shouldLoadReviewedTableView = NO;
        [self.view addSubview:self.ReviewedTableView];
        _ReviewedTableView.frame = CGRectMake(0, recognizer.view.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
        [_ReviewedTableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"progressingCell"];
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (status == 0) {
            _ReviewedFooterView.center = downPoint;
            status = !status;
            oldStatus = status;
            _progressing.textColor = PRESENT_TITLE_COLOR;
            _reviewed.textColor = PAST_TITLE_COLOR;
            _progressingSegmentedControl.isPresenting = YES;
            _ReviewedSegmentedControl.isPresenting = NO;
            separatorLine.hidden =_progressingSegmentedControl.isPresenting;
        }
        else
        {
            _ReviewedFooterView.center = upPoint;
            status = !status;
            oldStatus = status;
            _progressing.textColor = PAST_TITLE_COLOR;
            _reviewed.textColor = PRESENT_TITLE_COLOR;
            _progressingSegmentedControl.isPresenting = NO;
            _ReviewedSegmentedControl.isPresenting = YES;
            [_ReviewedTableView headerBeginRefreshing];
        }
        _ReviewedTableView.frame = CGRectMake(0, recognizer.view.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
    } completion:^(BOOL finished) {
        separatorLine.hidden =_progressingSegmentedControl.isPresenting;
    }];
}

- (void)handleTap2:(UITapGestureRecognizer *)recognizer//底部的tableview的点击事件
{
    downPoint = CGPointMake(self.view.frame.size.width / 2,self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER / 2);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (status == NO) {
            _ReviewedFooterView.center = downPoint;
            status = !status;//1代表展示正在进行的活动，0代表展示往期活动
            oldStatus = status;
            _progressing.textColor = PRESENT_TITLE_COLOR;
            _reviewed.textColor = PAST_TITLE_COLOR;
            _progressingSegmentedControl.isPresenting = YES;
            _ReviewedSegmentedControl.isPresenting = NO;
            separatorLine.hidden =_progressingSegmentedControl.isPresenting;
            _ReviewedTableView.frame = CGRectMake(0, _ReviewedFooterView.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
        }
    } completion:nil];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer//底部的tableview拖拽事件
{
    downPoint = CGPointMake(self.view.frame.size.width / 2,self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER / 2);
    static long i = 0;
    i++;
    BOOL flag1 = NO;
    BOOL flag2 = NO;
    
    if (shouldLoadReviewedTableView == YES) {
        shouldLoadReviewedTableView = NO;
        [self.view addSubview:self.ReviewedTableView];
        _ReviewedTableView.frame = CGRectMake(0, recognizer.view.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
        [_ReviewedTableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"progressingCell"];
    }

    CGPoint translation = [recognizer translationInView:self.view];
    if (recognizer.view.center.y + translation.y < upPoint.y) {
        recognizer.view.center = upPoint;
    }
    else if(recognizer.view.center.y + translation.y > downPoint.y)
    {
        recognizer.view.center = downPoint;
    }else
    {
        recognizer.view.center = CGPointMake(recognizer.view.center.x,recognizer.view.center.y + translation.y);
    }
    
    sweepSpeed[i%3] = [NSString stringWithFormat:@"%f",translation.y ];
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

    for (NSString *str in sweepSpeed) {
        if ([str intValue] < -10) {
            flag1 = YES;
            break;
        }
        if ([str intValue] > 10) {
            flag2 = YES;
            break;
        }
    }
    _ReviewedTableView.frame = CGRectMake(0, recognizer.view.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
    separatorLine.hidden = YES;
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (recognizer.view.center.y < self.view.frame.size.height / 2 || flag1) {
                recognizer.view.center = upPoint;
                status = NO;
                _progressing.textColor = PAST_TITLE_COLOR;
                _reviewed.textColor = PRESENT_TITLE_COLOR;
                _progressingSegmentedControl.isPresenting = NO;
                _ReviewedSegmentedControl.isPresenting = YES;
                if (oldStatus != status) {
                    [_ReviewedTableView headerBeginRefreshing];
                }
                oldStatus = status;
            }
            if(recognizer.view.center.y > self.view.frame.size.height / 2 || flag2)
            {
                recognizer.view.center = downPoint;
                status = YES;
                oldStatus = status;
                _progressing.textColor = PRESENT_TITLE_COLOR;
                _reviewed.textColor = PAST_TITLE_COLOR;
                _progressingSegmentedControl.isPresenting = YES;
                _ReviewedSegmentedControl.isPresenting = NO;
            }
            _ReviewedTableView.frame = CGRectMake(0, recognizer.view.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
        } completion:^(BOOL finished) {
            separatorLine.hidden =_progressingSegmentedControl.isPresenting;
        }];
    }
}

#pragma mark -lazy initialization

- (UILabel *)progressing
{
    if (!_progressing) {
        _progressing = [[UILabel alloc] init];
        _progressing.text = @"正在进行";
        _progressing.textAlignment = NSTextAlignmentLeft;
        _progressing.textColor = PRESENT_TITLE_COLOR;
        _progressing.font = [UIFont systemFontOfSize:12];
    }
    return _progressing;
}

- (UIView *)progressingHeadView
{
    if (!_progressingHeadView) {
        _progressingHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, HEIGHT_OF_HEADER_OR_FOOTER)];
        _progressingHeadView.backgroundColor = [UIColor whiteColor];
        
        [_progressingHeadView addSubview:self.progressing];
        [_progressing setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_progressing]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressing)]];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_progressing(==_progressingHeadView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressing,_progressingHeadView)]];
        
        self.progressingSegmentedControl = [[CustomSegmentedControl alloc] initWithisProgressing:YES];
        [_progressingHeadView addSubview:self.progressingSegmentedControl];
        _progressingSegmentedControl.delegate = self;
        [_progressingSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-255-[_progressingSegmentedControl]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingSegmentedControl)]];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=7.5-[_progressingSegmentedControl]->=7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingSegmentedControl)]];
        [_progressingHeadView addConstraint:[NSLayoutConstraint constraintWithItem:_progressingSegmentedControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_progressingHeadView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_progressingHeadView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap2:)]];

        
        separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, _progressingHeadView.frame.size.height, self.view.frame.size.width, 1)];
        separatorLine.backgroundColor = _progressingTableView.separatorColor;
        separatorLine.hidden = YES;
        [self.view addSubview:separatorLine];
    }
    return _progressingHeadView;
}

- (UITableView *)progressingTableView
{
    if(!_progressingTableView)
    {
        _progressingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _progressingTableView.delegate = self;
        _progressingTableView.dataSource = self;
        _progressingTableView.tag = 0;
        [_progressingTableView setContentInset:UIEdgeInsetsMake(HEIGHT_OF_HEADER_OR_FOOTER, 0, HEIGHT_OF_HEADER_OR_FOOTER, 0)];
    }
    return _progressingTableView;
}

- (UILabel *)reviewed
{
    if (!_reviewed) {
        _reviewed = [[UILabel alloc] init];
        _reviewed.text = @"往期活动";
        _reviewed.textAlignment = NSTextAlignmentLeft;
        _reviewed.textColor = PAST_TITLE_COLOR;
        _reviewed.font = [UIFont systemFontOfSize:12];
    }
    return _reviewed;
}

- (UIView *)ReviewedFooterView
{
    if (!_ReviewedFooterView) {
        _ReviewedFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 64 - HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, HEIGHT_OF_HEADER_OR_FOOTER)];
        _ReviewedFooterView.backgroundColor = [UIColor whiteColor];

        [_ReviewedFooterView addSubview:self.reviewed];
        [_reviewed setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_reviewed]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_reviewed)]];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_reviewed(==_ReviewedFooterView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_reviewed,_ReviewedFooterView)]];
        
        self.ReviewedSegmentedControl = [[CustomSegmentedControl alloc] initWithisProgressing:NO];
        [_ReviewedFooterView addSubview:self.ReviewedSegmentedControl];
        _ReviewedSegmentedControl.delegate = self;
        [_ReviewedSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-255-[_ReviewedSegmentedControl]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedSegmentedControl)]];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=7.5-[_ReviewedSegmentedControl]->=7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedSegmentedControl)]];
        [_ReviewedFooterView addConstraint:[NSLayoutConstraint constraintWithItem:_ReviewedSegmentedControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_ReviewedFooterView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_ReviewedFooterView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [_ReviewedFooterView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
    }
    return _ReviewedFooterView;
}

- (UITableView *)ReviewedTableView
{
    if(!_ReviewedTableView)
    {
        _ReviewedTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _ReviewedTableView.delegate = self;
        _ReviewedTableView.dataSource = self;
        _ReviewedTableView.tag = 1;
    }
    return _ReviewedTableView;
}


@end
