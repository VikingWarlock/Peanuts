//
//  UIView+extra.h
//  test demo
//
//  Created by viking warlock on 5/8/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (extra)
/**
 *捕捉指定View的图像，返回UIImage
 *
 */
-(UIImage*)captureView;


-(UIView*)getClipView:(CGRect)frame;


@end
