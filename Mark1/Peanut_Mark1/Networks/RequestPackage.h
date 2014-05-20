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

-(BOOL)LoginWithUsername:(NSString*)username andPassword:(NSString*)passwd;

-(BOOL)LoginFromCookie;

-(BOOL)Logout;

/**
 *后台某广场列表
 *
 **/
-(NSArray*)FetchSquare;

/**
 *前台获取广场列表
 *
 **/
-(void)FetchingSquareBlock:(void(^)(NSArray* response ,NSError *error))block;

/**
 *某活动的作品列表
 *
 **/
-(NSArray*)FetchPhotoSeriesList:(NSInteger)page AndCount:(NSInteger)count;

/**
 *某活动的作品列表
 *
 **/
-(void)FetchPhotoSeriesBlock:(void(^)(NSArray* response ,NSError* error))block;

/**
 *某活动的作品列表
 *
 **/
-(void)RequestOnePhotoSeries:(NSString*)feed_id AndSucceedBlock:(void(^)(id response ,NSError *error))block;


//should use network stack
/**
 *某活动的作品列表
 *
 **/
-(void)DigSomething:(NSString*)feed_id;

/**
 *某活动的作品列表
 *
 **/
-(void)RepostSomeThing:(NSString*)feed_id WithCommentContent:(NSString*)content AndSucceedBlock:(void(^)(NSString *feedid,NSInteger repostNum,NSError *error))blocks;

/**
 *某活动的作品列表
 *
 **/
-(BOOL)DeleteCommentWithComment_id:(NSString*)comment_id AndFeed_id:(NSString*)feed_id;
/**
 *某活动的作品列表
 *
 **/
-(void)FetchCommentList:(NSString*)feed_id Page:(NSInteger)page Count:(NSInteger)count SucceedResponse:(void(^)(NSArray* response ,NSError*error))block;
/**
 *某活动的作品列表
 *
 **/
-(void)FetchActivityUserList:(NSString*)feed_id AndPage:(NSInteger)page AndCount:(NSInteger)count AndSucceedResponse:(void(^)(NSArray* response ,NSError *error))block;

/**
 *某活动的作品列表
 *
**/
-(void)FetchActivityWorkList:(NSString*)feed_id AndPage:(NSInteger)page AndCount:(NSInteger)count AndSucceedResponse:(void(^)(NSArray* response ,NSError *error))block;


@end
