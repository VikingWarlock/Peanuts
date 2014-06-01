//
//  CommentViewController.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "CommentViewController.h"
#import "PublishCommentTableViewCell.h"
#import "UIImageView+WebCache.h"


@interface CommentViewController (){
    NSIndexPath * selectedIndexPath;
    NSInteger feed_id;
    NSMutableArray * data;
}

@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,strong)ImgBottomView * bottomView;

@end

@implementation CommentViewController

static NSString * cellIdentifier = @"cellIdentifier";

- (id)initWithFeedId:(NSInteger)feedId{
    self = [super init];
    if (self) {
        feed_id = feedId;
        [self.view addSubview:self.bottomView];
    }
    return self;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self downloadWithFeedId:feed_id];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self setBackgroundImage:[UIImage imageNamed:@"1.png"] andBlurEnable:YES];
    [self registerForKeyboardNotification];
    
    [self.view addSubview:self.tableView];
//    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];

    
    // Do any additional setup after loading the view.
}

-(ImgBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[ImgBottomView alloc]initWithGroupFeedId:feed_id];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

-(void)bottomCommentBtnClick{
    
}

-(void)bottomShareBtnClick{
    for (UIViewController * vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[ShareViewController class]]) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else{
            ShareViewController * sVC = [[ShareViewController alloc] init];
            [self.navigationController pushViewController:sVC animated:YES];
        }
    }

}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor clearColor];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.allowsSelection = NO;
         
    }
    return _tableView;
}

-(void)tableViewTapped:(UITapGestureRecognizer *)tapGR{
    [self.tableView endEditing:YES];
    [self.tableView removeGestureRecognizer:tapGR];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [data count] + 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row) {
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
        NSDictionary * rowData = data[indexPath.row-1];
        cell.timeLabel.text = [rowData objectForKey:@"time"];
        cell.commentLabel.text = [rowData objectForKey:@"content"];
        cell.userName.text = [rowData objectForKey:@"uname"];
        UIImageView * iv = [[UIImageView alloc]init];
        [iv setImageWithURL:[rowData objectForKey:@"avatar_tiny"]];
        [cell.iconView setImage:iv.image];
        return cell;

    }
    else{
        PublishCommentTableViewCell * cell = [[PublishCommentTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"publishCommentCell"];
        cell.delegate = self;
        return cell;
    }
}

-(void)replayBtnClickAtIndexPath:(NSIndexPath *)indexPath{
    selectedIndexPath = indexPath;
    [self.tableView reloadData];
}

-(void)deleteBtnClickAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell * cell = (CommentTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if ([cell.deleteBtn.titleLabel.text isEqualToString:@"删除"]) {
//        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
//        [self.tableView endUpdates];
        [self.tableView reloadData];
    }else{
        selectedIndexPath = nil;
        [cell reChangeCell];
    }
    [self.tableView reloadData];
}


-(void)publishCommentBtnClick{
    [self.delegate DidPublishOneComment];
}

-(void)registerForKeyboardNotification{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
}

-(void)keyboardDidShow:(NSNotification *)aNotification{
    UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapped:)];
    tapGR.cancelsTouchesInView = NO;
    [_tableView addGestureRecognizer:tapGR];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)downloadWithFeedId:(NSInteger)feedId{
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Comment&act=comment_list" parameters:@{@"feed_id":[NSString stringWithFormat:@"%ld",feedId],@"page":@"1",@"count":@"10"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        if ([[responseObject objectForKey:@"status"] isEqualToString:@"1"]) {
            data = [[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"data"]];
        [self.tableView reloadData];
//        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
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
