//
//  Peanut_PhotoBroswer.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/29/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MWPhotoBrowser.h>
#import <MWPhoto.h>
#import "BaseUIViewController.h"

@interface Peanut_PhotoBroswer : NSObject
{
    NSMutableArray *photo_Array;
    MWPhotoBrowser *broswer;
}

@property(nonatomic)BOOL isBroswering;
+(void)setup;
+(Peanut_PhotoBroswer*)SharedObject;

-(void)addPhoto:(UIImage*)img;

-(void)setImgArray:(NSArray*)array;

-(void)display:(BaseUIViewController*)targer;

-(void)clearImgArray;

@end
