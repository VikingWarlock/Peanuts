//
//  ShareViewController.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation ShareViewController

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
    [self setBackgroundImage:[UIImage imageNamed:@"1.png"] andBlurEnable:YES];

    [self.view addSubview:self.tableView];
    _tableView.allowsSelection = NO;
    [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    _tableView.separatorColor = [UIColor clearColor];
    
    [self registerForKeyboardNotification];
    // Do any additional setup after loading the view.
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
    }
    return _tableView;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishCommentTableViewCell * cell = (PublishCommentTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PublishCommentTableViewCell * cell = [[PublishCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdentifier"];
    [cell.publishCommentBtn setTitle:@"转发" forState:UIControlStateNormal];
    [cell.publishCommentBtn setTitle:@"转发" forState:UIControlStateSelected];
    [cell.publishCommentBtn setTitle:@"转发" forState:UIControlStateHighlighted];
    return cell;
}

-(void)registerForKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyboardDidShow:(NSNotification *)aNotification{
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tableViewTapped:)];
    tapGR.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tapGR];
}

-(void)tableViewTapped:(UITapGestureRecognizer *)tapGR{
    [self.tableView endEditing:YES];
    [self.tableView removeGestureRecognizer:tapGR];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
