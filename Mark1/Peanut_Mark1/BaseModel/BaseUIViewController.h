//
//  BaseUIViewController.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseUIViewController : UIViewController


@property(nonatomic,readonly)BaseNaviViewController *NavigationController;

@property(nonatomic,weak) UIImage*bkImage;


-(UIImageView*)Peanut_backgroundView;
-(void)setBackgroundImage:(UIImage*)bkimage andBlurEnable:(BOOL)enable;

@end
