//
//  UITableView+extra.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UITableView (extra)

/**
 * 给UITableView直接添加Avatar
 *
 *
 */
-(void)updateWithAvatar:(UIImage *)avatarImage And_X_Offset:(CGFloat)asix AndSize:(CGSize)size ;


/**
 *给UITableView直接添加Avatar,并且添加点击Avatar之后的效果
 *
 *
 */
-(void)updateWithAvatar:(UIImage *)avatarImage And_X_Offset:(CGFloat)asix AndSize:(CGSize)size AndAddTarget:(id)target AndSelector:(SEL)selector AndParameter:(NSDictionary*)parameter;


@end
