//
//  MustReaddetialViewController.h
//  Peanut_Mark1
//
//  Created by Grayon on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "BaseUIViewController.h"

@interface MustReaddetialViewController : BaseUIViewController <UIWebViewDelegate>
@property (nonatomic,retain) UIImageView *picture;
@property (nonatomic,retain) UIView *mask;
@property (nonatomic,retain) UIImageView *avatar;
@property (nonatomic,retain) UILabel *atitle;
@property (nonatomic,retain) UILabel *user;
@property (nonatomic,retain) UIButton *like;
@property (nonatomic,retain) UIButton *comment;
@property (nonatomic,retain) UIWebView *content;
@end
