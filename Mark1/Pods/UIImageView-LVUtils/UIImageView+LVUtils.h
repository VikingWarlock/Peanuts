//
//  UIImageView+UserInfo.h
//  ImageBrowser
//
//  Created by LawLincoln on 14-4-25.
//  Copyright (c) 2014年 SelfStudio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (LVUtils)
- (void)setUserInfo:(NSDictionary*)dict;
- (NSDictionary*)userInfo;

- (void)enableTapForDelegate:(id)delegete withSelector:(SEL)sel;

- (void)round;
@end
