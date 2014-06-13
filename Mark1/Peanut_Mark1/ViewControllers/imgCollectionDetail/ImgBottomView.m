//
//  ImgBottomView.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-25.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "ImgBottomView.h"
#import "CommentViewController.h"
#import "ShareViewController.h"

@implementation ImgBottomView{
    NSInteger feed_id;
    BOOL isPraised;
}

- (id)initWithGroupFeedId:(NSInteger)feedId
{
    self = [super init];
    if (self) {
        isPraised = NO;
        feed_id = feedId ;
        self.frame = CGRectMake(0, [UIScreen mainScreen].applicationFrame.size.height - 80, [UIScreen mainScreen].applicationFrame.size.width, 80);
        [self setBackgroundColor:[UIColor whiteColor]];
        self.alpha = 0.7;
        
        _praiseBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, (self.frame.size.width - 20)/3, self.frame.size.height)];
        _praiseBtn.contentEdgeInsets = UIEdgeInsetsMake(10, 35, 50, 35);
        [_praiseBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_praiseBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        [_praiseBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        
        CGRect rect = _praiseBtn.frame;
        rect.origin.x += rect.size.width;
        _commentBtn = [[UIButton alloc] initWithFrame:rect];
        _commentBtn.contentEdgeInsets = _praiseBtn.contentEdgeInsets;
        [_commentBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_commentBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        [_commentBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        
        rect.origin.x += rect.size.width;
        _shareBtn = [[UIButton alloc] initWithFrame:rect];
        _shareBtn.contentEdgeInsets = _praiseBtn.contentEdgeInsets;
        [_shareBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_shareBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        [_shareBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        
        [self.praiseBtn addTarget:self action:@selector(bottomPraiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.commentBtn addTarget:self action:@selector(bottomCommentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.shareBtn addTarget:self action:@selector(bottomShareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_praiseBtn];
        [self addSubview:_commentBtn];
        [self addSubview:_shareBtn];
        
    }
    return self;
}

-(NSString *)getUid{
    UserInfEntity * entity = [CoreData_Helper GetSelfUserInfEntity];
    return entity.uid;
}

-(void)bottomCommentBtnClick:(UIButton *)sender{
    self.commentVC = [[CommentViewController alloc]initWithFeedId:feed_id];
    [self.delegate bottomCommentBtnClick];
}

-(void)bottomPraiseBtnClick:(UIButton *)sender{
    AFHTTPRequestOperationManager * NetworkManager = [[AFHTTPRequestOperationManager alloc]init];
    if (isPraised) {
        [NetworkManager POST:Peanut_Cancel_Dig_Something parameters:@{@"PHPSESSID":USER_PHPSESSID,@"feed_id":[NSString stringWithFormat:@"%ld",feed_id]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject objectForKey:@"status"] intValue] == 1) {
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"取消成功!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                isPraised = 0;
            }else{
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"取消失败!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
    }else{
        [NetworkManager POST:Peanut_Dig_Something parameters:@{@"PHPSESSID":USER_PHPSESSID,@"feed_id":[NSString stringWithFormat:@"%ld",feed_id]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject objectForKey:@"status"] intValue] == 1) {
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"点赞成功!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
                isPraised = 1;
                NSLog(@"%@",[[responseObject objectForKey:@"data"] objectForKey:@"diggNum"]);
            }else{
                UIAlertView * alertView = [[UIAlertView alloc]initWithTitle:nil message:@"点赞失败!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alertView show];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        }];
        
    }
}

-(void)bottomShareBtnClick:(UIButton *)sender{
    self.shareVC = [[ShareViewController alloc] initWithFeedId:feed_id];
    [self.delegate bottomShareBtnClick];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
