//
//  CommentViewController.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController (){
    NSIndexPath * selectedIndexPath;
    int count;
}

@property(nonatomic,strong)UITableView * tableView;

@end

@implementation CommentViewController

static NSString * cellIdentifier = @"cellIdentifier";

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
    count = 15;
    
    [self setBackgroundImage:[UIImage imageNamed:@"1.png"] andBlurEnable:YES];
    
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor clearColor];
        
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapped:)];
        tapGR.cancelsTouchesInView = NO;
        [_tableView addGestureRecognizer:tapGR];
        _tableView.allowsSelection = NO;
    }
    return _tableView;
}

-(void)tableViewTapped:(UITapGestureRecognizer *)tapGR{
    if (selectedIndexPath != nil) {
        CommentTableViewCell * cell = (CommentTableViewCell *)[self tableView:self.tableView cellForRowAtIndexPath:selectedIndexPath];
        if ([cell.deleteBtn.titleLabel.text isEqualToString:@"取消"]) {
            [self.tableView reloadData];
        }

    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell * cell = (CommentTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[CommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier atIndexPath:indexPath];
    }else{
        [cell reChangeCell];
        cell.indexPath = indexPath;
    }
    cell.delegate = self;
    if ([indexPath compare:selectedIndexPath] == NSOrderedSame && indexPath.row == selectedIndexPath.row) {
        [cell changeCell];
    }
    cell.timeLabel.text = @"2014-05-14";
    cell.commentLabel.text = @"aaa";
    cell.userName.text = @"王孟琦";
    return cell;
}

-(void)replayBtnClickAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndexPath = indexPath;
    NSLog(@"replay at row:%ld",indexPath.row);
    [self.tableView reloadData];
}

-(void)deleteBtnClickAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell * cell = (CommentTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell.deleteBtn.titleLabel.text isEqualToString:@"删除"]) {
        [self.tableView beginUpdates];
        NSLog(@"delete cell at row:%ld",indexPath.row);
        count--;
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
        [self.tableView endUpdates];
        [self.tableView reloadData];
    }else{
        selectedIndexPath = nil;
        [cell reChangeCell];
    }
    [self.tableView reloadData];
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