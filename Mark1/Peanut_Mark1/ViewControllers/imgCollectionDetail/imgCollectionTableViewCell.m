//
//  imgCollectionTableViewCell.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "imgCollectionTableViewCell.h"

@implementation imgCollectionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 400)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.frame.origin.x, _imgView.frame.origin.y + _imgView.frame.size.height + 5, 50, 20)];
        
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:self.detailBtn];
        [self.contentView addSubview:self.praiseBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.shareBtn];
        
        praiseCount = 0;
        commentCount = 0;
        shareCount = 0;
        
    }
    return self;
}

-(UIButton *)detailBtn{
    if (!_detailBtn) {
        _detailBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.titleLabel.frame.origin.x + self.titleLabel.frame.size.width ,self.titleLabel.frame.origin.y - 15 , 50, 50)];
        _detailBtn.contentEdgeInsets = UIEdgeInsetsMake(15, 10, 15, 20);
        [_detailBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_detailBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [_detailBtn setImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        
        [_detailBtn addTarget:self action:@selector(detailBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _detailBtn;
}

-(void)detailBtnClick:(UIButton *)sender{
    
}

-(UIButton *)praiseBtn{
    if (!_praiseBtn) {
        _praiseBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, _titleLabel.frame.origin.y, 50, 20)];
        [_praiseBtn addTarget:self action:@selector(praiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        
        [_praiseBtn setTitle:[NSString stringWithFormat:@"%ld",praiseCount] forState:UIControlStateNormal];
    }
    return _praiseBtn;
}

-(void)praiseBtnClick:(UIButton *)sender{
    praiseCount++;
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%ld",praiseCount] forState:UIControlStateNormal];
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%ld",praiseCount] forState:UIControlStateSelected];
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%ld",praiseCount] forState:UIControlStateHighlighted];
}

-(UIButton *)commentBtn{
    if (!_commentBtn) {
        CGRect rect = _praiseBtn.frame;
        rect.origin.x += _praiseBtn.frame.size.width;
        _commentBtn = [[UIButton alloc] initWithFrame:rect];
        [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        
        [_commentBtn setTitle:[NSString stringWithFormat:@"%ld",commentCount] forState:UIControlStateNormal];
    }
    return _commentBtn;
}

-(void)commentBtnClick:(UIButton *)sender{
    commentCount++;
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",commentCount] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",commentCount] forState:UIControlStateSelected];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",commentCount] forState:UIControlStateHighlighted];
}

-(UIButton *)shareBtn{
    if (!_shareBtn) {
        CGRect rect = _praiseBtn.frame;
        rect.origin.x += 2 * rect.size.width;
        _shareBtn = [[UIButton alloc] initWithFrame:rect];
        [_shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [_shareBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        
        [_shareBtn setTitle:[NSString stringWithFormat:@"%ld",shareCount] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

-(void)shareBtnClick:(UIButton *)sender{
    shareCount++;
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",shareCount] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",shareCount] forState:UIControlStateSelected];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%ld",shareCount] forState:UIControlStateHighlighted];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
