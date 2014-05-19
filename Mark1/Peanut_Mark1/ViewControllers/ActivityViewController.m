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

#define HEIGHT_OF_HEADER_OR_FOOTER 30.0
@interface ActivityViewController ()
{
    NSArray *bindingFooterToBottom;
    NSArray *bindingFooterToTop;
    BOOL isProgressing;
}
@property (nonatomic,strong) UITableView *progressingTableView;
@property (nonatomic,strong) UITableView *ReviewedTableView;
@property (nonatomic,strong) UIView *progressingHeadView;
@property (nonatomic,strong) UIView *ReviewedFooterView;
@property (nonatomic,strong) UISegmentedControl *progressingSegmentedControl;
@property (nonatomic,strong) UISegmentedControl *ReviewedSegmentedControl;
@property (nonatomic,strong) UILabel *progressing;
@property (nonatomic,strong) UILabel *reviewed;

@end

@implementation ActivityViewController

#pragma mark -vc life cycle

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
    UIBarButtonItem *Button=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:nil];
    [self.navigationItem setRightBarButtonItem:Button];
    [self.view addSubview:self.progressingTableView];
    [self.view addSubview:self.progressingHeadView];
    [self.view addSubview:self.ReviewedFooterView];
    [self.progressingTableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"progressingCell"];

    [_progressingHeadView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_progressingHeadView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingHeadView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|[_progressingHeadView(%f)]",HEIGHT_OF_HEADER_OR_FOOTER ] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingHeadView)]];

    [_progressingTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_progressingTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingTableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_progressingTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingTableView)]];
    
    [_ReviewedFooterView setTranslatesAutoresizingMaskIntoConstraints:NO];
    bindingFooterToBottom = [[NSArray alloc] initWithArray: [NSLayoutConstraint constraintsWithVisualFormat:@"V:[_ReviewedFooterView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedFooterView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ReviewedFooterView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedFooterView)]];
    [self.view addConstraints:bindingFooterToBottom];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat: @"V:[_ReviewedFooterView(%f)]",HEIGHT_OF_HEADER_OR_FOOTER] options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedFooterView)]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = @"活动";
    //self.navigationController.navigationItem.title = @"";
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

#pragma mark -some method

- (void)switchToReviewed
{
    if (!isProgressing) {
        [self.view addSubview:self.ReviewedTableView];
        [_ReviewedTableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"progressingCell"];
        [_ReviewedTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ReviewedTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedTableView)]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_ReviewedFooterView][_ReviewedTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedFooterView,_ReviewedTableView)]];
        [self.view layoutIfNeeded];
        
        bindingFooterToTop = [[NSArray alloc] initWithArray :[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_progressingHeadView][_ReviewedFooterView]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingHeadView,_ReviewedFooterView)]];
        [self.view removeConstraints:bindingFooterToBottom];
        [self.view addConstraints:bindingFooterToTop];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutSubviews];
        }];
        isProgressing = !isProgressing;
        [self updateTextColor];
    }
}

- (void)switchToProgressing
{
    if (isProgressing) {
        [self.view removeConstraints:bindingFooterToTop];
        [self.view addConstraints:bindingFooterToBottom];
        [UIView animateWithDuration:0.25 animations:^{
            [self.view layoutSubviews];
        }];
        isProgressing = !isProgressing;
        [self updateTextColor];
    }
}

- (void)updateTextColor
{
    UIColor *temp = _progressing.textColor;
    _progressing.textColor = _reviewed.textColor;
    _reviewed.textColor = temp;
}

#pragma mark -lazy initialization

- (UILabel *)progressing
{
    if (!_progressing) {
        _progressing = [[UILabel alloc] init];
        _progressing.text = @"正在进行";
        _progressing.textAlignment = NSTextAlignmentLeft;
        _progressing.textColor = [UIColor redColor];
        _progressing.font = [UIFont systemFontOfSize:12];
    }
    return _progressing;
}

- (UIView *)progressingHeadView
{
    if (!_progressingHeadView) {
        _progressingHeadView = [[UIView alloc] init];
        _progressingHeadView.backgroundColor = [UIColor whiteColor];
        
        [_progressingHeadView addSubview:self.progressing];
        [_progressing setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_progressing]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressing)]];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_progressing(==_progressingHeadView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressing,_progressingHeadView)]];
        
        
        [_progressingHeadView addSubview:self.progressingSegmentedControl];
        [_progressingSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-255-[_progressingSegmentedControl]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingSegmentedControl)]];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=7.5-[_progressingSegmentedControl]->=7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingSegmentedControl)]];
        [_progressingHeadView addConstraint:[NSLayoutConstraint constraintWithItem:_progressingSegmentedControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_progressingHeadView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_progressingHeadView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchToProgressing)]];

    }
    return _progressingHeadView;
}

- (UISegmentedControl *)progressingSegmentedControl
{
    if (!_progressingSegmentedControl) {
        _progressingSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"线上",@"线下", nil]];
        _progressingSegmentedControl.selectedSegmentIndex = 0;
        
        UIFont *font = [UIFont systemFontOfSize:9.0f];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                               forKey:NSFontAttributeName];
        [_progressingSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    return _progressingSegmentedControl;
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
        _reviewed.textColor = [UIColor grayColor];
        _reviewed.font = [UIFont systemFontOfSize:12];
    }
    return _reviewed;
}

- (UIView *)ReviewedFooterView
{
    if (!_ReviewedFooterView) {
        _ReviewedFooterView = [[UIView alloc] init];
        _ReviewedFooterView.backgroundColor = [UIColor whiteColor];

        [_ReviewedFooterView addSubview:self.reviewed];
        [_reviewed setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_reviewed]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_reviewed)]];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_reviewed(==_ReviewedFooterView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_reviewed,_ReviewedFooterView)]];
        
        
        [_ReviewedFooterView addSubview:self.ReviewedSegmentedControl];
        [_ReviewedSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-255-[_ReviewedSegmentedControl]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedSegmentedControl)]];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=7.5-[_ReviewedSegmentedControl]->=7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedSegmentedControl)]];
        [_ReviewedFooterView addConstraint:[NSLayoutConstraint constraintWithItem:_ReviewedSegmentedControl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_ReviewedFooterView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_ReviewedFooterView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(switchToReviewed)]];
    }
    return _ReviewedFooterView;
}


- (UISegmentedControl *)ReviewedSegmentedControl
{
    if (!_ReviewedSegmentedControl) {
        _ReviewedSegmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"线上",@"线下", nil]];
        _ReviewedSegmentedControl.selectedSegmentIndex = 0;
        
        UIFont *font = [UIFont systemFontOfSize:9.0f];
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font
                                                               forKey:NSFontAttributeName];
        [_ReviewedSegmentedControl setTitleTextAttributes:attributes forState:UIControlStateNormal];
    }
    return _ReviewedSegmentedControl;
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
