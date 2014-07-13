//
//  UIImageView+ForBroswer.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/29/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//
#import <objc/runtime.h>
/*
static const void *downloaded_=&downloaded_;
static const void *target_=&target_;
*/

#import "UIImageView+ForBroswer.h"
#import "BaseUIViewController.h"
#import "Peanut_PhotoBroswer.h"

@implementation UIImageView (ForBroswer)



/*
@dynamic downloaded;
@dynamic delegate_broswer;
@dynamic target;

-(void)setDownloadedImage:(UIImage *)image AndTarget:(id)target ShouldUpdateImage:(BOOL)update
{
    if (update) {
        [self setImage:image];
    }
    if ([self downloaded]==YES) {
        return;
    }
    [self setDownloaded:YES];
    [[Peanut_PhotoBroswer SharedObject]addPhoto:image];
    [self setUserInteractionEnabled:YES];
    UIControl *control=[[UIControl alloc]initWithFrame:self.frame];
    [self addSubview:control];
    [self setTarget:target];
    [control addTarget:self action:@selector(TapAction) forControlEvents:UIControlEventTouchUpInside];
}

-(void)TapAction
{
    BaseUIViewController *vc=(BaseUIViewController*)self.target;
    [[Peanut_PhotoBroswer SharedObject]display:vc];
}

-(BOOL)downloaded
{
    return [objc_getAssociatedObject(self, downloaded_) boolValue];
}

-(void)setDownloaded:(BOOL)downloaded
{
    NSNumber *num=[NSNumber numberWithBool:downloaded];
    objc_setAssociatedObject(self, downloaded_, num, OBJC_ASSOCIATION_COPY);
}

-(id)target
{
    return objc_getAssociatedObject(self, target_);
}

-(void)setTarget:(id)target
{
    BaseUIViewController *base=target;
    objc_setAssociatedObject(self, target_, base, OBJC_ASSOCIATION_ASSIGN);
}

-(void)dealloc
{
    [self setDownloaded:NO];
}
*/


@end
