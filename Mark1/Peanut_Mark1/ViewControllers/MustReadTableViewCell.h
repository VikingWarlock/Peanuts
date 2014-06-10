//
//  MustReadTableViewCell.h
//  Peanut_Mark1
//
//  Created by Grayon on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImageView+WebCache.h"

@interface MustReadTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *picture;
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *user;
@property (nonatomic,strong) UIButton *like;
@property (nonatomic,strong) UIButton *comment;
@end
