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
#import "ImgBottomView.h"
#import "UIImageView+WebCache.h"




@interface imgCollectionViewController (){
    UIButton * praiseBtn;
    UIButton * commentBtn;
    UIButton * shareBtn;
    
    UILabel * nameLabel;
    UILabel * timeLabel;
    
    NSIndexPath * currentIndexPath;
    NSArray * imgData;
    int feed_id;
}

@property (nonatomic,strong)UITableView * tableView;
@property (nonatomic,strong)ImgBottomView * bottomView;

@end


@implementation imgCollectionViewController

static NSString * cellIdentifier = @"cellIdentifier";

- (id)initWithFeedId:(int)feedId bgImageUrl:(NSURL *)url{
    self = [super init];
    if (self) {
//        [self downLoadWithFeedId:feedId];
        UIImageView * iv = [[UIImageView alloc]initWithFrame:self.view.frame];
        [iv setImageWithURL:url];
        [self setBackgroundImage:iv.image andBlurEnable:YES];
        feed_id = feedId;
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
    

    [self.view addSubview:self.bottomView];
    
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
        
        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
        [_tableView.tableHeaderView setBackgroundColor:[UIColor clearColor]];
        
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

//        _tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 150)];
//        [_tableView.tableHeaderView setBackgroundColor:[UIColor clearColor]];
//   
//        UILabel * nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(115, _tableView.tableHeaderView.frame.size.height - 20, 60, 17)];
//        nameLabel.text = @"aaaaa";
//        nameLabel.textColor = [UIColor whiteColor];
//        
//        CGRect rect = nameLabel.frame;
//        rect.origin.x = nameLabel.frame.origin.x + nameLabel.frame.size.width + 20;
//        rect.size.width = 100;
//        UILabel * timeLabel = [[UILabel alloc] initWithFrame:rect];
//        timeLabel.text = @"2014-05-13";
//        timeLabel.textColor = [UIColor whiteColor];
//        
//        [_tableView updateWithAvatar:[UIImage imageNamed:@"iron.png"] And_X_Offset:30.0 AndSize:CGSizeMake(70, 70)];
//
//        
//        [_tableView.tableHeaderView addSubview:nameLabel];
//        [_tableView.tableHeaderView addSubview:timeLabel];
        
        
    }
    return _tableView;
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

-(void)bottomPraiseBtnClick:(UIButton *)sender{
    self.bottomView.praiseBtn.backgroundColor = [UIColor redColor];
}

-(void)bottomCommentBtnClick:(UIButton *)sender{
    CommentViewController * vc = [[CommentViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)bottomShareBtnClick:(UIButton *)sender{
    ShareViewController *vc = [[ShareViewController alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)praiseBtnClickAtCell:(UITableViewCell *)cell{
    imgCollectionTableViewCell * cell1 = (imgCollectionTableViewCell *)cell;
    NSInteger count = [cell1.praiseBtn.titleLabel.text integerValue];
    [cell1 setPraiseBtnTitle:++count];

}

-(void)commentBtnClickAtIndexPath:(NSIndexPath *)indexPath{
    CommentViewController * VC = [[CommentViewController alloc] init];
    VC.delegate = self;
    currentIndexPath = indexPath;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)shareBtnClickAtIndexPath:(NSIndexPath *)indexPath{
    ShareViewController * VC = [[ShareViewController alloc]init];
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
//    cell.imgView.contentMode = UIViewContentModeScaleAspectFit;
    cell.titleLabel.text = rowData[@"description"];
    cell.titleLabel.adjustsFontSizeToFitWidth = YES;
    [cell.praiseBtn setTitle:[NSString stringWithFormat:@"%d",indexPath.row] forState:UIControlStateNormal];
    [cell.commentBtn setTitle:[NSString stringWithFormat:@"%d",indexPath.row] forState:UIControlStateNormal];
    [cell.shareBtn setTitle:[NSString stringWithFormat:@"%d",indexPath.row] forState:UIControlStateNormal];

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [imgData count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 30;
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


-(void)downLoadWithFeedId:(int)feedId{
    
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Square&act=photo_group_info" parameters:@{@"feed_id":[NSString stringWithFormat:@"%d",feedId]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"]) {
            imgData = [[NSArray alloc]initWithArray:[[responseObject valueForKey:@"data"] valueForKey:@"photos"]];
            NSDictionary * userData = [[responseObject valueForKey:@"data"] valueForKey:@"user_info"];
            NSDictionary * seriesData = [[responseObject valueForKey:@"data"] valueForKey:@"photo_group"];
            
            nameLabel.text = userData[@"uname"];
            nameLabel.adjustsFontSizeToFitWidth = YES;
            NSDate * date = [NSDate dateWithTimeIntervalSince1970:[seriesData[@"publish_time"] intValue]];
            NSDateFormatter * formatter = [[NSDateFormatter alloc]init];
            [formatter setDateFormat:@"yyyy-MM-dd"];

            timeLabel.text = [formatter stringFromDate:date];
            [self.tableView reloadData];
            
//            UIImageView * bgTV = [[UIImageView alloc]initWithFrame:self.view.frame];
//            [bgTV setImageWithURL:[seriesData valueForKey:@"cover"]];
//            [self setBackgroundImage:bgTV.image andBlurEnable:YES];

            UIImageView * iconIV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
            [iconIV setImageWithURL:userData[@"avatar_tiny"]];
            [_tableView updateWithAvatar:iconIV.image And_X_Offset:30.0 AndSize:CGSizeMake(70, 70)];
            

        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//if (url) {
//    __weak UIImageView *wself = self;
//    id <SDWebImageOperation> operation = [SDWebImageManager.sharedManager downloadWithURL:url options:options progress:progressBlock completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished) {
//        if (!wself) return;
//        dispatch_main_sync_safe(^{
//            if (!wself) return;
//            if (image) {
//                wself.image = image;
//                [wself setNeedsLayout];
//            }
//            if (completedBlock && finished) {
//                completedBlock(image, error, cacheType);
//            }
//        });
//    }];
//    objc_setAssociatedObject(self, &operationKey, operation, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

//- (void)dealloc
//{
//    [self.tableView freeHeaderFooter];
//}

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
