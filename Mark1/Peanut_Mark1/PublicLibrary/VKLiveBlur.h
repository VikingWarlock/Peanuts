//
//  VKLiveBlur.h
//  test demo
//
//  Created by viking warlock on 5/8/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKLiveBlur : UIView

-(id)initWithBackView:(UIImage*)backgroundImage AndsuperView:(UIView*)v;

-(void)setvisiableFrame:(CGRect)frame;

-(void)moveVisiableFrame:(CGRect)frame;


@end
