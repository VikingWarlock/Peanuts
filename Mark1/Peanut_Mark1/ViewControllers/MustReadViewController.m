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
@interface MustReadViewController ()
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"必读";
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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark UITableView datasource and delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MustReaddetialViewController *detialView = [[MustReaddetialViewController alloc] init];
    [self.readTableView deselectRowAtIndexPath: indexPath animated:YES];
    [self.NavigationController pushViewController:detialView animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"mustreadCell";
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
        datelabel.text = @"2014年5月5号";
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
