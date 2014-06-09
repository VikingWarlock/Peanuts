//
//  AMPAvatarView+helper.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "AMPAvatarView+helper.h"

@implementation AMPAvatarView (helper)

-(void)addTarget:(id)target select:(SEL)selector andParameter:(NSDictionary *)parameter
{
    UIControl *control=[[UIControl alloc]init];
    [self addSubview:control];
    [control setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    [control addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
}

@end
