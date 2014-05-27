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
#import "PullRefreshTableView.h"
#import "CustomSegmentedControl.h"

#define PRESENT_TITLE_COLOR [UIColor redColor]
#define PAST_TITLE_COLOR [UIColor grayColor]

@interface ActivityViewController ()
{
    NSArray *bindingFooterToBottom;
    NSArray *bindingFooterToTop;
    BOOL isProgressing;
    BOOL shouldLoadReviewedTableView;
    CGPoint upPoint;
    CGPoint downPoint;
    NSMutableArray *sweepSpeed;
    NSMutableArray *downSpeed;
}
@property (nonatomic,strong) PullRefreshTableView *progressingTableView;
@property (nonatomic,strong) PullRefreshTableView *ReviewedTableView;
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
        isProgressing = YES;
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    UIBarButtonItem *Button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    [self.navigationItem setRightBarButtonItem:Button];
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
    [self.progressingTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDownProgressing:refreshView];
    }];
    [self.progressingTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUpProgressing:refreshView];
    }];
    [self.ReviewedTableView setPullDownBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullDownReviewed:refreshView];
    }];
    [self.ReviewedTableView setPullUpBeginRefreshBlock:^(MJRefreshBaseView *refreshView) {
        [weakSelf pullUpReviewed: refreshView];
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"活动";
    ((UIViewController *)(self.navigationController.viewControllers)[[self.navigationController.viewControllers indexOfObject:self] - 1]).navigationItem.title = @"";
    [self.progressingTableView beginRefreshing];
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
    [self.progressingTableView freeHeaderFooter];
    [self.ReviewedTableView freeHeaderFooter];
}

#pragma mark -UITableView datasource and delegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"progressingCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 0) {
        return 4;
    }
    else if(tableView.tag == 1)
        return 5;
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
    ActivityDetailViewController *vc = [[ActivityDetailViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -Network stuff

-(void)pullDownProgressing:(MJRefreshBaseView*)refreshView
{
    NSLog(@"this is pull down progressing");
    [refreshView endRefreshing];
}

-(void)pullUpProgressing:(MJRefreshBaseView*)refreshView
{
    NSLog(@"this is pull up progressing");
    [refreshView endRefreshing];
}

-(void)pullDownReviewed:(MJRefreshBaseView*)refreshView
{
    NSLog(@"this is pull down reviewed");
    [refreshView endRefreshing];
}

-(void)pullUpReviewed:(MJRefreshBaseView*)refreshView
{
    NSLog(@"this is pull up reviewed");
    [refreshView endRefreshing];
}

#pragma mark -status switch

- (void)handleTap:(UITapGestureRecognizer *)recognizer
{
    upPoint = CGPointMake(self.view.frame.size.width / 2,HEIGHT_OF_HEADER_OR_FOOTER + HEIGHT_OF_HEADER_OR_FOOTER / 2);
    downPoint = CGPointMake(self.view.frame.size.width / 2,self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER / 2);

    if (shouldLoadReviewedTableView == YES) {
        shouldLoadReviewedTableView = NO;
        [self.view addSubview:self.ReviewedTableView];
        _ReviewedTableView.frame = CGRectMake(0, recognizer.view.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
        [_ReviewedTableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"progressingCell"];
    }
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (isProgressing == NO) {
            _ReviewedFooterView.center = downPoint;
            isProgressing = !isProgressing;
            _progressing.textColor = PRESENT_TITLE_COLOR;
            _reviewed.textColor = PAST_TITLE_COLOR;
            _progressingSegmentedControl.isProgressing = YES;
            _ReviewedSegmentedControl.isProgressing = NO;
        }
        else
        {
            _ReviewedFooterView.center = upPoint;
            isProgressing = !isProgressing;
            _progressing.textColor = PAST_TITLE_COLOR;
            _reviewed.textColor = PRESENT_TITLE_COLOR;
            _progressingSegmentedControl.isProgressing = NO;
            _ReviewedSegmentedControl.isProgressing = YES;
        }
        _ReviewedTableView.frame = CGRectMake(0, recognizer.view.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
    } completion:nil];
}

- (void)handleTap2:(UITapGestureRecognizer *)recognizer
{
    downPoint = CGPointMake(self.view.frame.size.width / 2,self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER / 2);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (isProgressing == NO) {
            _ReviewedFooterView.center = downPoint;
            isProgressing = !isProgressing;
            _progressing.textColor = PRESENT_TITLE_COLOR;
            _reviewed.textColor = PAST_TITLE_COLOR;
            _progressingSegmentedControl.isProgressing = YES;
            _ReviewedSegmentedControl.isProgressing = NO;
            _ReviewedTableView.frame = CGRectMake(0, _ReviewedFooterView.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
        }
    } completion:nil];
    
}

- (void)handlePan:(UIPanGestureRecognizer *)recognizer
{
    upPoint = CGPointMake(self.view.frame.size.width / 2,HEIGHT_OF_HEADER_OR_FOOTER + HEIGHT_OF_HEADER_OR_FOOTER / 2);
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

    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (recognizer.view.center.y < self.view.frame.size.height / 2 || flag1) {
                recognizer.view.center = upPoint;
                isProgressing = NO;
                _progressing.textColor = PAST_TITLE_COLOR;
                _reviewed.textColor = PRESENT_TITLE_COLOR;
                _progressingSegmentedControl.isProgressing = NO;
                _ReviewedSegmentedControl.isProgressing = YES;
            }
            if(recognizer.view.center.y > self.view.frame.size.height / 2 || flag2)
            {
                recognizer.view.center = downPoint;
                isProgressing = YES;
                _progressing.textColor = PRESENT_TITLE_COLOR;
                _reviewed.textColor = PAST_TITLE_COLOR;
                _progressingSegmentedControl.isProgressing = YES;
                _ReviewedSegmentedControl.isProgressing = NO;
            }
            _ReviewedTableView.frame = CGRectMake(0, recognizer.view.frame.origin.y + HEIGHT_OF_HEADER_OR_FOOTER, self.view.frame.size.width, self.view.frame.size.height - HEIGHT_OF_HEADER_OR_FOOTER * 2);
        } completion:nil];
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
        [_progressingSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-255-[_progressingSegmentedControl]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingSegmentedControl)]];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=7.5-[_progressingSegmentedControl]->=7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingSegmentedControl)]];
        [_progressingHeadView addConstraint:[NSLayoutConstraint constraintWithItem:_progressingSegmentedControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_progressingHeadView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_progressingHeadView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap2:)]];

    }
    return _progressingHeadView;
}

- (PullRefreshTableView *)progressingTableView
{
    if(!_progressingTableView)
    {
        _progressingTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
        [_ReviewedSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-255-[_ReviewedSegmentedControl]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedSegmentedControl)]];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=7.5-[_ReviewedSegmentedControl]->=7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedSegmentedControl)]];
        [_ReviewedFooterView addConstraint:[NSLayoutConstraint constraintWithItem:_ReviewedSegmentedControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_ReviewedFooterView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_ReviewedFooterView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]];
        [_ReviewedFooterView addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)]];
    }
    return _ReviewedFooterView;
}

- (PullRefreshTableView *)ReviewedTableView
{
    if(!_ReviewedTableView)
    {
        _ReviewedTableView = [[PullRefreshTableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _ReviewedTableView.delegate = self;
        _ReviewedTableView.dataSource = self;
        _ReviewedTableView.tag = 1;
    }
    return _ReviewedTableView;
}


@end
