//
//  UIImage+extra.h
//  test demo
//
//  Created by viking warlock on 5/8/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (extra)

/**
 *缩放到指定尺寸
 *
 */
-(UIImage*)scaleToSize:(CGSize)size;

/**
 *截取指定位置的图片
 *
 */
-(UIImage*)getSubImage:(CGRect)rect;



@end
