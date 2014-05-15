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
@interface ActivityViewController ()
@property (nonatomic,strong) UITableView *progressingTableView;
@property (nonatomic,strong) UITableView *ReviewedTableView;
@property (nonatomic,strong) UIView *progressingHeadView;
@property (nonatomic,strong) UIView *ReviewedFooterView;
@property (nonatomic,strong) UISegmentedControl *progressingSegmentedControl;
@property (nonatomic,strong) UISegmentedControl *ReviewedSegmentedControl;
@end

@implementation ActivityViewController

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
    [self.view addSubview:self.progressingTableView];
    [self.view addSubview:self.progressingHeadView];
    [self.view addSubview:self.ReviewedFooterView];
    
    [_progressingHeadView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_progressingHeadView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingHeadView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_progressingHeadView(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingHeadView)]];
    
    [_progressingTableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_progressingTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingTableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_progressingTableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingTableView)]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:_progressingTableView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_progressingHeadView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
    
    [_ReviewedFooterView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_ReviewedFooterView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedFooterView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_ReviewedFooterView(30)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedFooterView)]];
    
    [self.progressingTableView registerClass:[ActivityTableViewCell class] forCellReuseIdentifier:@"progressingCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView datasource and delegate

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
    return 5;
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

#pragma mark lazy initialization

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

- (UIView *)progressingHeadView
{
    if (!_progressingHeadView) {
        _progressingHeadView = [[UIView alloc] init];
        
        
        UILabel *label = [[UILabel alloc] init];
        _progressingHeadView.backgroundColor = [UIColor whiteColor];
        label.text = @"正在进行";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:12];
        [_progressingHeadView addSubview:label];
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label(==_progressingHeadView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label,_progressingHeadView)]];
        
        
        [_progressingHeadView addSubview:self.progressingSegmentedControl];
        [_progressingSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_progressingSegmentedControl(50)]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingSegmentedControl)]];
        [_progressingHeadView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=7.5-[_progressingSegmentedControl]->=7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressingSegmentedControl)]];
        
    }
    return _progressingHeadView;
}

- (UIView *)ReviewedFooterView
{
    if (!_ReviewedFooterView) {
        _ReviewedFooterView = [[UIView alloc] init];
        
        
        UILabel *label = [[UILabel alloc] init];
        _ReviewedFooterView.backgroundColor = [UIColor whiteColor];
        label.text = @"往期活动";
        label.textAlignment = NSTextAlignmentLeft;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:12];
        [_ReviewedFooterView addSubview:label];
        [label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[label(100)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label)]];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[label(==_ReviewedFooterView)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(label,_ReviewedFooterView)]];
        
        
        [_ReviewedFooterView addSubview:self.ReviewedSegmentedControl];
        [_ReviewedSegmentedControl setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_ReviewedSegmentedControl(50)]-15-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedSegmentedControl)]];
        [_ReviewedFooterView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=7.5-[_ReviewedSegmentedControl]->=7.5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_ReviewedSegmentedControl)]];
        
    }
    return _ReviewedFooterView;
}

- (UITableView *)progressingTableView
{
    if(!_progressingTableView)
    {
        _progressingTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_progressingTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _progressingTableView.delegate = self;
        _progressingTableView.dataSource = self;
    }
    return _progressingTableView;
}



@end
