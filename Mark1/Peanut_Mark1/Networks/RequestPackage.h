//
//  RequestPackage.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/19/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestPackage : NSObject

+(RequestPackage*)shareObject;

-(void)LoginWithUsername:(NSString*)username andPassword:(NSString*)passwd;

//-(void)LoginFromCookie;

-(void)Logout;

/**
 *后台某广场列表 bla bla bla
 *
 **/
-(void)FetchSquare;
-(void)FetchActivities;
-(void)FetchMustRead;
-(void)FetchHomePage;


/**
 *后台获取组图列表
 *
 **/
-(void)FetchPhotoSeriesList:(NSInteger)page AndCount:(NSInteger)count;


//should use network stack
/**
 *后台点赞
 *
 **/
-(void)DigSomething:(NSString*)feed_id;

-(void)CancelDigSomething:(NSString*)feed_id;



/**
 *后台删除评论
 *
 **/
-(void)DeleteCommentWithComment_id:(NSString*)comment_id AndFeed_id:(NSString*)feed_id;

@end
