//
//  UITableView+extra.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "UITableView+extra.h"
#import <AMPAvatarView.h>
#import "AMPAvatarView+helper.h"


@implementation UITableView (extra)


-(void)updateWithAvatar:(UIImage *)avatarImage And_X_Offset:(CGFloat)asix AndSize:(CGSize)size
{
    CGFloat height=self.tableHeaderView.frame.size.height;
    AMPAvatarView *avatar=[[AMPAvatarView alloc]initWithFrame:CGRectMake(asix, height, size.width, size.height)];
    [self addSubview:avatar];
    
}

-(void)updateWithAvatar:(UIImage *)avatarImage And_X_Offset:(CGFloat)asix AndSize:(CGSize)size AndAddTarget:(id)target AndSelector:(SEL)selector AndParameter:(NSDictionary *)parameter
{
    CGFloat height=self.tableHeaderView.frame.size.height;
    AMPAvatarView *avatar=[[AMPAvatarView alloc]initWithFrame:CGRectMake(asix, height, size.width, size.height)];
    [self addSubview:avatar];
    [avatar addTarget:target select:selector andParameter:parameter];
    

}


@end
