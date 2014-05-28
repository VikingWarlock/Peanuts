//
//  CommentViewController.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "CommentViewController.h"
#import "PublishCommentTableViewCell.h"
#import "ImgBottomView.h"

@interface CommentViewController (){
    NSIndexPath * selectedIndexPath;
    int count;
}

@property(nonatomic,retain)UITableView * tableView;
@property(nonatomic,strong)ImgBottomView * bottomView;

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
    [self registerForKeyboardNotification];
    
    [self.view addSubview:self.tableView];
//    [self.tableView registerClass:[CommentTableViewCell class] forCellReuseIdentifier:cellIdentifier];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];

    
    // Do any additional setup after loading the view.
}

-(ImgBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[ImgBottomView alloc]init];
        [_bottomView.praiseBtn addTarget:self action:@selector(bottomPraiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.commentBtn addTarget:self action:@selector(bottomCommentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomView.shareBtn addTarget:self action:@selector(bottomShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

-(UITableView *)tableView{
    if (!_tableView) {
//        CGRect rect = self.view.frame;
//        rect.size.height -= 64;
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
    return count;
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
        cell.timeLabel.text = @"2014-05-14";
        cell.commentLabel.text = @"aaa";
        cell.userName.text = @"王孟琦";
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
        count--;
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
