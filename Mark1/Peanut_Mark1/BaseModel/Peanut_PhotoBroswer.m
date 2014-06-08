//
//  Peanut_PhotoBroswer.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/29/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "Peanut_PhotoBroswer.h"
#import "BaseUIViewController.h"
#import "BaseNaviViewController.h"

static Peanut_PhotoBroswer *shareObject;

@interface Peanut_PhotoBroswer()<MWPhotoBrowserDelegate>
{

}
@end

@implementation Peanut_PhotoBroswer

+(void)setup
{
    if (shareObject==nil) {
        shareObject=[[Peanut_PhotoBroswer alloc]init];
    }
}

-(id)init
{
    self=[super init];
    if (self) {
        photo_Array=[[NSMutableArray alloc]init];
        self.isBroswering=NO;
    }
    return self;
}


#pragma MWPhotoDelegate

-(NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser
{
    return [photo_Array count];
}

-(id<MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index
{
    return [photo_Array objectAtIndex:index];
}

#pragma Public Method

+(Peanut_PhotoBroswer*)SharedObject
{
    return shareObject;
}

-(void)addPhoto:(UIImage *)img
{
    [photo_Array addObject:[MWPhoto photoWithImage:img]];
    if (self.isBroswering==YES) {
        [broswer reloadData];
    }
}

-(void)setImgArray:(NSArray *)array
{
    [photo_Array removeAllObjects];
    for(UIImage *img in array)
    {
        [photo_Array addObject:[MWPhoto photoWithImage:img]];
    }
}


-(void)display:(BaseUIViewController *)targer
{
    broswer=[[MWPhotoBrowser alloc]initWithDelegate:self];
    broswer.enableGrid=NO;
    broswer.displayActionButton=YES;
    broswer.displayNavArrows=YES;
    broswer.zoomPhotosToFill=NO;
    broswer.startOnGrid=NO;
    
    
    [targer.NavigationController pushViewController:broswer animated:YES];
    self.isBroswering=YES;
}

-(void)clearImgArray
{
    [photo_Array removeAllObjects];
}

@end
