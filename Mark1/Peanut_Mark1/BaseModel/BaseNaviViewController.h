//
//  BaseNaviViewController.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Peanut_SNSPart.h"

typedef NS_ENUM(NSInteger, NaivPushDir) {
    NaivPushDirFromRight=0,
    NaivPushDirFromButtom
};



@interface BaseNaviViewController : UINavigationController
/**
 *暂时不要用
 *
 */
-(void)PushVC:(UIViewController*)vc;
/**
 *暂时不要用
 *
 */
 
-(void)PushVC:(UIViewController*)vc Direction:(NaivPushDir)dir;

/**
 *暂时不要用
 *
 */
-(void)PopVC;


-(void)SNS_appear;

@end
