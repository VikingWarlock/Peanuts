//
//  ActivityTableViewCell.h
//  Peanut_Mark1
//
//  Created by 张众 on 5/15/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityTableViewCell : UITableViewCell
@property (nonatomic,strong) UIImageView *picture;
@property (nonatomic,strong) UIImageView *avatar;
@property (nonatomic,strong) UIImageView *calendar;
@property (nonatomic,strong) UIImageView *flag;
@property (nonatomic,strong) UILabel *title;
@property (nonatomic,strong) UILabel *user;
@property (nonatomic,strong) UILabel *Date;
@property (nonatomic,strong) UILabel *type;

@end
