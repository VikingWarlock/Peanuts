//
//  UIImageView+UserInfo.m
//  ImageBrowser
//
//  Created by LawLincoln on 14-4-25.
//  Copyright (c) 2014年 SelfStudio. All rights reserved.
//

#import "UIImageView+LVUtils.h"
#import <objc/runtime.h>

static void *userInfo;

@implementation UIImageView (LVUtils)
- (void)setUserInfo:(NSDictionary *)dict{
    objc_setAssociatedObject(self, &userInfo, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSDictionary *)userInfo {
    NSDictionary *result = objc_getAssociatedObject(self, &userInfo);
    if (result == nil) {
        // do a lot of stuff
        result = @{};
        objc_setAssociatedObject(self, &userInfo, result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

- (void)enableTapForDelegate:(id)delegete withSelector:(SEL)sel{
    [self setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:delegete action:sel];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tap];
    
}

- (void)round{
    
}
@end
