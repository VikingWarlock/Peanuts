//
//  ShareViewController.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "ShareViewController.h"
#import "CommentViewController.h"
#import "UIImageView+WebCache.h"

@interface ShareViewController (){
    NSInteger feed_id;
}

@property (nonatomic,strong) UITableView * tableView;
@property(nonatomic,strong)ImgBottomView * bottomView;


@end

@implementation ShareViewController

- (id)initWithFeedId:(NSInteger)feedId
{
    self = [super init];
    if (self) {
        feed_id = feedId;
        [self.view addSubview:self.bottomView];
        
        PhotoSeriesEntity * entity = [CoreData_Helper GetPhotoSeriesEntity:[NSString stringWithFormat:@"%ld",feed_id]];
        UIImageView * iv = [[UIImageView alloc]init];
        if (entity!=nil) {
            [iv setImageWithURL:[NSURL URLWithString:entity.cover_url] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                [self setBackgroundImage:image andBlurEnable:YES];
            }];}
        else{
            PhotoInfoEntity * entity2 = [CoreData_Helper GetPhotoEntity:[NSString stringWithFormat:@"%ld",feed_id]];
            [iv setImageWithURL:[NSURL URLWithString:entity2.imageURL] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                [self setBackgroundImage:image andBlurEnable:YES];
            }];
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

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

-(ImgBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[ImgBottomView alloc]initWithGroupFeedId:feed_id];
        _bottomView.delegate = self;
    }
    return _bottomView;
}

-(void)bottomCommentBtnClick{
    BOOL alreadyHasCommentVC = 0;
    for (UIViewController * vc in self.navigationController.viewControllers) {
        if ([vc isKindOfClass:[CommentViewController class]]) {
            alreadyHasCommentVC = 1;
        }
    }
    if (alreadyHasCommentVC) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        CommentViewController * vc = [[CommentViewController alloc]initWithFeedId: feed_id];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(void)bottomShareBtnClick{

    
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] init];
        
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        [_tableView.tableFooterView setBackgroundColor:[UIColor clearColor]];
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
    cell.delegate = self;
    return cell;
}

-(void)publishCommentBtnClick{
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Feed&act=repost" parameters:@{@"PHPSESSID": [NSString stringWithFormat:@"%@",USER_PHPSESSID],@"content":@"aaa",@"feed_id":[NSString stringWithFormat:@"%ld",feed_id]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"info"] isEqualToString:@"success"]) {
            UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"转发成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alertView show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    [self.delegate didShare];
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
