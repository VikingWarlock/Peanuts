//
//  imgCollectionTableViewCell.m
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "imgCollectionTableViewCell.h"
#import "CommentViewController.h"

@implementation imgCollectionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 300, 400)];
        _imgView.clipsToBounds = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;

        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.frame.origin.x, _imgView.frame.origin.y + _imgView.frame.size.height + 5, 50, 20)];

        NSLog(@"aa");
        
        CGRect rect = self.frame;
        rect.size.height = 530;
        self.frame = rect;
        [self.contentView addSubview:_imgView];
        [self.contentView addSubview:_titleLabel];
        [self.contentView addSubview:self.praiseBtn];

//        [self.contentView addSubview:self.detailBtn];
        [self.contentView addSubview:self.commentBtn];
        [self.contentView addSubview:self.shareBtn];
        
        NSDictionary * dic = NSDictionaryOfVariableBindings(_imgView,_titleLabel,_praiseBtn,_commentBtn,_shareBtn);
        for (UIView * view in [dic allValues]) {
            [view setTranslatesAutoresizingMaskIntoConstraints:NO];
        }

        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_imgView]-10-|" options:0 metrics:nil views:dic]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_titleLabel]-30-[_praiseBtn(==50)]-10-[_commentBtn(==50)]-10-[_shareBtn(==50)]-10-|" options:0 metrics:nil views:dic]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-40-[_imgView]-10-[_titleLabel(==20)]|"] options:0 metrics:nil views:dic]];
//        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-40-[_imgView]-10-[_detailBtn(==20)]|"] options:0 metrics:nil views:dic]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-40-[_imgView]-10-[_praiseBtn(==20)]|"] options:0 metrics:nil views:dic]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-40-[_imgView]-10-[_commentBtn(==20)]|"] options:0 metrics:nil views:dic]];
        [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-40-[_imgView]-10-[_shareBtn(==20)]|"] options:0 metrics:nil views:dic]];
        
        praiseCount = 0;
        commentCount = 0;
        shareCount = 0;
        
        
    }
    return self;
}
/*
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
*/
//-(void)detailBtnClick:(UIButton *)sender{
//    
//}

-(UIButton *)praiseBtn{
    if (!_praiseBtn) {
        _praiseBtn = [[UIButton alloc] initWithFrame:CGRectMake(160, _titleLabel.frame.origin.y, 50, 20)];
        
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [_praiseBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        [_praiseBtn setBackgroundColor:[UIColor yellowColor]];
        [_praiseBtn setTitle:[NSString stringWithFormat:@"%d",praiseCount] forState:UIControlStateNormal];
        [_praiseBtn addTarget:self action:@selector(praiseBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _praiseBtn;
}

-(void)praiseBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(praiseBtnClickAtCell:)]) {
        [self.delegate praiseBtnClickAtCell:self];
    }
}

-(UIButton *)commentBtn{
    if (!_commentBtn) {
        CGRect rect = _praiseBtn.frame;
        rect.origin.x += _praiseBtn.frame.size.width;
        _commentBtn = [[UIButton alloc] initWithFrame:rect];

        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateNormal];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateSelected];
        [_commentBtn setBackgroundImage:[UIImage imageNamed:@"1.png"] forState:UIControlStateHighlighted];
        [_commentBtn setTitle:[NSString stringWithFormat:@"%d",commentCount] forState:UIControlStateNormal];
        
        [_commentBtn addTarget:self action:@selector(commentBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _commentBtn;
}

-(void)setCommentBtnTitle:(NSInteger)count{
    commentCount = count;
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",(long)count] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateSelected];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateHighlighted];
}
-(void)setPraiseBtnTitle:(NSInteger)count{
    praiseCount = count;
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateSelected];
    [self.praiseBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateHighlighted];
}
-(void)setShareBtnTitle:(NSInteger)count{
    shareCount = count;
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateNormal];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateSelected];
    [self.shareBtn setTitle:[NSString stringWithFormat:@"%d",count] forState:UIControlStateHighlighted];
}


-(void)commentBtnClick:(UIButton *)sender{
/*    commentCount++;
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",commentCount] forState:UIControlStateNormal];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",commentCount] forState:UIControlStateSelected];
    [self.commentBtn setTitle:[NSString stringWithFormat:@"%ld",commentCount] forState:UIControlStateHighlighted];
*/ 
    [self.delegate commentBtnClickAtIndexPath:_currentIndexPath];
    
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
        
        [_shareBtn setTitle:[NSString stringWithFormat:@"%d",shareCount] forState:UIControlStateNormal];
    }
    return _shareBtn;
}

-(void)shareBtnClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(shareBtnClickAtIndexPath:)]) {
        [self.delegate shareBtnClickAtIndexPath:_currentIndexPath];
    }
}
/*
-(void)setConstraintsWithBool:(BOOL)isFirstRow{
    int height;
    CGRect rect = self.frame;
    NSDictionary * dic = NSDictionaryOfVariableBindings(_imgView,_titleLabel,_detailBtn,_praiseBtn,_commentBtn,_shareBtn);
    if (isFirstRow) {
        rect.size.height = 530;
        self.frame = rect;
        height = 40;
    }else{
        rect.size.height = 500;
        self.frame = rect;
        height = 10;
    }

    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_titleLabel(==20)]|",height] options:0 metrics:nil views:dic]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_detailBtn(==20)]|",height] options:0 metrics:nil views:dic]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_praiseBtn(==20)]|",height] options:0 metrics:nil views:dic]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_commentBtn(==20)]|",height] options:0 metrics:nil views:dic]];
    [self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_shareBtn(==20)]|",height] options:0 metrics:nil views:dic]];
}

-(void)removeConstraintWithBool:(BOOL)isFirstRow{
    NSDictionary * dic = NSDictionaryOfVariableBindings(_imgView,_titleLabel,_detailBtn,_praiseBtn,_commentBtn,_shareBtn);
    int height;
    if (isFirstRow) {
        height = 10;
    }else
        height = 60;
    
    [self.contentView removeConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_titleLabel(==20)]-10-|",height] options:0 metrics:nil views:dic]];
    [self.contentView removeConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_detailBtn(==20)]-10-|",height] options:0 metrics:nil views:dic]];
    [self.contentView removeConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_praiseBtn(==20)]-10-|",height] options:0 metrics:nil views:dic]];
    [self.contentView removeConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_commentBtn(==20)]-10-|",height] options:0 metrics:nil views:dic]];
    [self.contentView removeConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%d-[_imgView]-10-[_shareBtn(==20)]-10-|",height] options:0 metrics:nil views:dic]];
}
*/


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
