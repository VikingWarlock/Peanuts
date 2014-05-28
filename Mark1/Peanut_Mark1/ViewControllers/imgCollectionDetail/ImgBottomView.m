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

@implementation ImgBottomView

- (id)init
{
    self = [super init];
    if (self) {
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

-(void)bottomCommentBtnClick:(UIButton *)sender{
    self.commentVC = [[CommentViewController alloc]init];
    [self.delegate bottomCommentBtnClick];
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
