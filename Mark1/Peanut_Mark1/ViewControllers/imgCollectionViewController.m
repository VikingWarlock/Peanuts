//
//  imgCollectionViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "imgCollectionViewController.h"
#import <UIImage+BlurAndDarken.h>
#import "imgCollectionTableViewCell.h"
#import "UIImageView+WebCache.h"




@interface imgCollectionViewController (){
    UIButton * praiseBtn;
    UIButton * commentBtn;
    UIButton * shareBtn;
    
    UILabel * nameLabel;
    UILabel * timeLabel;
    
    NSIndexPath * currentIndexPath;
    NSArray * imgData;
    NSInteger feed_id;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)ImgBottomView * bottomView;

@end


@implementation imgCollectionViewController

static NSString * cellIdentifier = @"cellIdentifier";

- (id)initWithFeedId:(NSInteger)feedId{// bgImageUrl:(NSURL *)url{
    self = [super init];
    if (self) {
        PhotoSeriesEntity * entity = [CoreData_Helper GetPhotoSeriesEntity:[NSString stringWithFormat:@"%ld",feedId]];
        UIImageView * iv = [[UIImageView alloc]initWithFrame:self.view.frame];
        [iv setImageWithURL:[NSURL URLWithString:entity.cover_url] placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [self setBackgroundImage:image andBlurEnable:YES];
        }];
        feed_id = feedId;
        [self.view addSubview:self.bottomView];

    }
    return self;
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    [self downLoadWithFeedId:feed_id];
}


- (void)viewDidLoad
{

    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
//    [self setBackgroundImage:[UIImage imageNamed:@"1.png"] andBlurEnable:YES];
    
    [self.view addSubview:self.tableView];

    
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_tableView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_tableView)]];
    // Do any additional setup after loading the view.
}


-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [_tableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorColor = [UIColor whiteColor];
        [_tableView setBackgroundColor:[UIColor clearColor]];
        _tableView.allowsSelection = NO;
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        [_tableView.tableHeaderView setBackgroundColor:[UIColor clearColor]];
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        [_tableView.tableFooterView setBackgroundColor:[UIColor whiteColor]];
        
        
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, _tableView.tableHeaderView.frame.size.height - 20, 60, 17)];
        nameLabel.textColor = [UIColor whiteColor];
        
        CGRect rect = nameLabel.frame;
        rect.origin.x = nameLabel.frame.origin.x + nameLabel.frame.size.width + 20;
        rect.size.width = 100;
        timeLabel = [[UILabel alloc] initWithFrame:rect];
        timeLabel.text = @"2014-05-13";
        timeLabel.textColor = [UIColor whiteColor];
        [_tableView updateWithAvatar:[UIImage imageNamed:@"placeholder.png"] And_X_Offset:30.0 AndSize:CGSizeMake(70, 70)];
        
        
        [_tableView.tableHeaderView addSubview:nameLabel];
        [_tableView.tableHeaderView addSubview:timeLabel];

    
    }
    return _tableView;
}

-(ImgBottomView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[ImgBottomView alloc]initWithGroupFeedId:feed_id];
        _bottomView.delegate = self;
//        [_bottomView.praiseBtn addTarget:self action:@selector(bottomPraiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView.commentBtn addTarget:self action:@selector(bottomCommentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
//        [_bottomView.shareBtn addTarget:self action:@selector(bottomShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomView;
}

-(void)bottomPraiseBtnClick{
    self.bottomView.praiseBtn.backgroundColor = [UIColor redColor];
}

-(void)bottomCommentBtnClick{
    self.bottomView.commentVC.delegate = self;
    [self.navigationController pushViewController:self.bottomView.commentVC animated:YES];
}

-(void)bottomShareBtnClick{
    self.bottomView.shareVC.delegate = self;
    [self.navigationController pushViewController:self.bottomView.shareVC animated:YES];
}



-(void)praiseBtnClickAtCell:(UITableViewCell *)cell{
    NSMutableArray * mutableData = [[NSMutableArray alloc]initWithArray:imgData];
    imgCollectionTableViewCell * cell1 = (imgCollectionTableViewCell *)cell;
    NSInteger count = [cell1.praiseBtn.titleLabel.text integerValue];
    [cell1 setPraiseBtnTitle:++count];
    NSIndexPath * indexPath = [self.tableView indexPathForCell:cell1];
    NSMutableDictionary * rowData = [mutableData[indexPath.row] mutableCopy];
//???
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Feed&act=digg" parameters:@{@"PHPSESSID":[NSString stringWithFormat:@"%@",USER_PHPSESSID],@"feed_id":[rowData objectForKey:@"feed_id"]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int digCount = [rowData[@"digg_count"] intValue];
        [rowData removeObjectForKey:@"digg_count"];
        [rowData setValue:[NSString stringWithFormat:@"%d",++digCount] forKey:@"digg_count"];
        [mutableData replaceObjectAtIndex:indexPath.row withObject:rowData];
        imgData = mutableData;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];


}

-(void)commentBtnClickAtIndexPath:(NSIndexPath *)indexPath{
    int feedId = [[imgData[indexPath.row] objectForKey:@"feed_id"] intValue];
    CommentViewController * VC = [[CommentViewController alloc] initWithFeedId:feedId];
    VC.delegate = self;
    currentIndexPath = indexPath;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)shareBtnClickAtIndexPath:(NSIndexPath *)indexPath{
    int feedId = [[imgData[indexPath.row] objectForKey:@"feed_id"] intValue];
    ShareViewController * VC = [[ShareViewController alloc]initWithFeedId:feedId];
    VC.delegate = self;
    currentIndexPath = indexPath;
    [self.navigationController pushViewController:VC animated:YES];
}




#pragma mark - commentVC delegate
-(void)DidPublishOneComment{
    if (currentIndexPath == nil) {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"评论成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }else{
        imgCollectionTableViewCell * cell = (imgCollectionTableViewCell *)[self.tableView cellForRowAtIndexPath:currentIndexPath];
        int count = [cell.commentBtn.titleLabel.text intValue];
        [cell.commentBtn setTitle:[NSString stringWithFormat:@"%d",++count] forState:UIControlStateNormal];
        [cell.commentBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateSelected];
        [cell.commentBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateHighlighted];
        currentIndexPath = nil;
        
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"评论成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

//-(void)ShouldChangeToShareVC{
//    ShareViewController * vc = [[ShareViewController alloc]  init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - shareVC delegate
-(void)didShare{
    imgCollectionTableViewCell * cell = (imgCollectionTableViewCell *)[self.tableView cellForRowAtIndexPath:currentIndexPath];
    int count = [cell.shareBtn.titleLabel.text intValue];
    [cell.shareBtn setTitle:[NSString stringWithFormat:@"%d",++count] forState:UIControlStateNormal];
    [cell.shareBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateSelected];
    [cell.shareBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateHighlighted];
    
    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:nil message:@"转发成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}


#pragma mark - tableView dataSource

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    imgCollectionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[imgCollectionTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.currentIndexPath = indexPath;
    
    cell.delegate = self;

    NSDictionary * rowData = imgData[indexPath.row];
    [cell.imgView setImageWithURL:rowData[@"imageUrl"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    cell.imgView.clipsToBounds = YES;
    cell.imgView.contentMode = UIViewContentModeScaleAspectFill;
    cell.titleLabel.text = rowData[@"description"];
    cell.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.praiseBtn setTitle:[NSString stringWithFormat:@"%d",[rowData[@"digg_count"] intValue]] forState:UIControlStateNormal];
    [cell.commentBtn setTitle:[NSString stringWithFormat:@"%d",[rowData[@"comment_count"] intValue]] forState:UIControlStateNormal];
    [cell.shareBtn setTitle:[NSString stringWithFormat:@"%d",[rowData[@"repost_count"] intValue]] forState:UIControlStateNormal];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [imgData count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 530;
    imgCollectionTableViewCell * cell = (imgCollectionTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)downLoadWithFeedId:(NSInteger)feedId{
    
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Square&act=photo_group_info" parameters:@{@"feed_id":[NSString stringWithFormat:@"%ld",feedId]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"]) {
            imgData = [[NSArray alloc]initWithArray:[[responseObject valueForKey:@"data"] valueForKey:@"photos"]];
            NSDictionary * userData = [[responseObject valueForKey:@"data"] valueForKey:@"user_info"];
            NSDictionary * seriesData = [[responseObject valueForKey:@"data"] valueForKey:@"photo_group"];
            for (NSDictionary * dic in imgData) {
                [CoreData_Helper addPhotoEntity:dic];
            }
            nameLabel.text = userData[@"uname"];
            nameLabel.adjustsFontSizeToFitWidth = YES;
            NSDate * date = [NSDate dateWithTimeIntervalSince1970:[seriesData[@"publish_time"] intValue]];
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];

            timeLabel.text = [formatter stringFromDate:date];
            [self.tableView reloadData];
            
            UIImageView * iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            [iconIV setImageWithURL:userData[@"avatar_tiny"] placeholderImage:[UIImage imageNamed:@"placeholder.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                [_tableView updateWithAvatar:image And_X_Offset:30.0 AndSize:CGSizeMake(70, 70)];
            }];
            

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



//- (void)dealloc
//{
//    [self.tableView freeHeaderFooter];
//}



@end
