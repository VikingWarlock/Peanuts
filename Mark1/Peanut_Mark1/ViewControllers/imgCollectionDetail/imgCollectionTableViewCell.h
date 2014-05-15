//
//  imgCollectionTableViewCell.h
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface imgCollectionTableViewCell : UITableViewCell{
    NSInteger praiseCount;
    NSInteger commentCount;
    NSInteger shareCount;
}

@property (nonatomic,strong) UIImageView * imgView;
@property (nonatomic,strong) UILabel * titleLabel;
@property (nonatomic,strong) UIButton * detailBtn;
@property (nonatomic,strong) UIButton * praiseBtn;
@property (nonatomic,strong) UIButton * commentBtn;
@property (nonatomic,strong) UIButton * shareBtn;

@end
