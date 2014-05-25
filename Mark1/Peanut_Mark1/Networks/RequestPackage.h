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
 *后台某广场列表
 *
 **/
-(NSArray*)FetchSquare;

/**
 *前台获取广场列表
 *
 **/
//-(void)FetchingSquareBlock:(void(^)(NSArray* response ,NSError *error))block;

/**
 *后台获取组图列表
 *
 **/
-(NSArray*)FetchPhotoSeriesList:(NSInteger)page AndCount:(NSInteger)count;

/**
 *前台获取组图列表
 *
 **/
//-(void)FetchPhotoSeriesBlock:(void(^)(NSArray* response ,NSError* error))block;

/**
 *前台获取某一个组图
 *
 **/
//-(void)RequestOnePhotoSeries:(NSString*)feed_id AndSucceedBlock:(void(^)(id response ,NSError *error))block;


//should use network stack
/**
 *后台点赞
 *
 **/
-(void)DigSomething:(NSString*)feed_id;

/**
 *前台转发
 *
 **/
//-(void)RepostSomeThing:(NSString*)feed_id WithCommentContent:(NSString*)content AndSucceedBlock:(void(^)(NSString *feedid,NSInteger repostNum,NSError *error))blocks;

/**
 *后台删除评论
 *
 **/
-(void)DeleteCommentWithComment_id:(NSString*)comment_id AndFeed_id:(NSString*)feed_id;
/**
 *前台获取评论列表
 *
 **/
//-(void)FetchCommentList:(NSString*)feed_id Page:(NSInteger)page Count:(NSInteger)count SucceedResponse:(void(^)(NSArray* response ,NSError*error))block;
/**
 *前台获取活动成员
 *
 **/
//-(void)FetchActivityUserList:(NSString*)feed_id AndPage:(NSInteger)page AndCount:(NSInteger)count AndSucceedResponse:(void(^)(NSArray* response ,NSError *error))block;

/**
 *前台获取活动作品
 *
**/
//-(void)FetchActivityWorkList:(NSString*)feed_id AndPage:(NSInteger)page AndCount:(NSInteger)count AndSucceedResponse:(void(^)(NSArray* response ,NSError *error))block;


@end
