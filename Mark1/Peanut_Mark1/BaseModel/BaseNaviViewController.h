//
//  BaseNaviViewController.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NaivPushDir) {
    NaivPushDirFromRight=0,
    NaivPushDirFromButtom
};



@interface BaseNaviViewController : UINavigationController

-(void)PushVC:(UIViewController*)vc;

-(void)PushVC:(UIViewController*)vc Direction:(NaivPushDir)dir;


-(void)PopVC;


@end
