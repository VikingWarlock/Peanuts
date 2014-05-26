//
//  CoreData-Helper.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "CoreData-Helper.h"

#import "PhotoDetailEntity.h"
#import "PhotoSeriesEntity.h"
#import "UserInfEntity.h"
#import "ActivityEntity.h"
#import "MustReadEntity.h"
#import "PhotoInfoEntity.h"

#import <AFNetworking.h>

@implementation CoreData_Helper

+(void)addPhotoEntity:(NSDictionary *)parameter
{
    PhotoInfoEntity *item=[PhotoInfoEntity MR_createEntity];
    item.feed_id=[parameter objectForKey:@"feed_id"];
    item.comment_count=[parameter objectForKey:@"comment_count"];
    item.descriptions=[parameter objectForKey:@"discription"];
    item.dig_count=[parameter objectForKey:@"digg_count"];
    item.imageURL=[parameter objectForKey:@"imageUrl"];
    item.is_report=[parameter objectForKey:@"is_repost"];
    item.publish_time=[parameter objectForKey:@"publish_time"];
    item.recommend_count=[parameter objectForKey:@"recommend"];
    item.recomment_content=[parameter objectForKey:@"recommend_content"];
    item.repost_count=[parameter objectForKey:@"repost_count"];
    item.uid=[parameter objectForKey:@"uid"];
    item.group_feed_id=[parameter objectForKey:@"group_feed_id"];

    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
}

+(void)addPhotoSeriesEntity:(NSDictionary *)parameter
{
    PhotoSeriesEntity *item=[PhotoSeriesEntity MR_createEntity];
    item.addr=[parameter objectForKey:@"addr"];
    item.comment_count=[parameter objectForKey:@"comment_count"];
    item.cover_url=[parameter objectForKey: @"cover_url"];
    item.descriptions=[parameter objectForKey:@"description"];
    item.dig_count=[parameter objectForKey:@"digg_count"];
    item.feed_id=[parameter objectForKey:@"feed_id"];
   
    item.is_repost=[parameter objectForKey:@"is_post"];
    item.publish_time=[parameter objectForKey:@"publish_time"];
    item.recommend_content=[parameter objectForKey:@"recommend_content"];
    item.recommend_count=[parameter objectForKey:@"recommend"];
    item.repost_count=[parameter objectForKey:@"repost_count"];
    item.topic=[parameter objectForKey:@"topic"];
    item.uid=[parameter objectForKey:@"uid"];
    
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
    /*
    item.is_report=parameter[@"is_post"];
    item.publish_time=parameter[@"publish_time"];
    item.recommend_content=parameter[@"recommend_content"];
    */
    
}

+(void)addActivityEntity:(NSDictionary *)parameter
{
    ActivityEntity *item=[ActivityEntity MR_createEntity];
    item.feed_id=[parameter objectForKey:@"feed_id"];
    item.cover_url=[parameter objectForKey:@"cover"];
    item.uid=[parameter objectForKey:@"uid"];
    item.publish_time=[parameter objectForKey:@"publish_time"];
    item.comment_count=[parameter objectForKey:@"comment_count"];
    item.dig_count=[parameter objectForKey:@"digg_count"];
    item.repost_count=[parameter objectForKey:@"repost_count"];
    item.is_repost=[parameter objectForKey:@"is_repost"];
    item.begin_time=[parameter objectForKey:@"begin_time"];
    item.end_time=[parameter objectForKey:@"end_time"];
    item.fee_limit=[parameter objectForKey:@"fee_limit"];
    item.member_audit=[parameter objectForKey:@"member_audit"];
    item.credit_limit=[parameter objectForKey:@"credit_limit"];
    item.address=[parameter objectForKey:@"address"];
    item.descriptions=[parameter objectForKey:@"description"];
    
    item.avatar_original_url=[parameter objectForKey:@"avatar_original"];
    item.avatar_big_url=[parameter objectForKey:@"avatar_big"];
    item.avatar_small_url=[parameter objectForKey:@"avatar_small"];
    
    
    
    item.avatar_tiny_url=[parameter objectForKey:@"avatar_tiny"];
    item.avatar_middle_url=[parameter objectForKey:@"avatar_middle"];
    item.personNum_limit=[parameter objectForKey:@"personNum_limit"];
    
    item.activityType=[parameter objectForKey:@"activityType"];
    item.isCurrent=[parameter objectForKey:@"isCurrent"];
    
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
}

+(void)addMustReadEntity:(NSDictionary *)parameter
{
    MustReadEntity *item=[MustReadEntity MR_createEntity];
    item.abstraction=[parameter objectForKey:@"abstraction"];
    item.comment_count=[parameter objectForKey:@"comment_count"];
    item.content=[parameter objectForKey:@"content"];
    item.cover_url=[parameter objectForKey:@"cover_url"];
    item.dig_count=[parameter objectForKey:@"digg_count"];
    item.feed_id=[parameter objectForKey:@"feed_id"];
    item.is_report=[parameter objectForKey:@"is_report"];
    item.page_views=[parameter objectForKey:@"page_views"];
    item.publish_time=[parameter objectForKey:@"publish_time"];
    item.repost_count=[parameter objectForKey:@"repost_count"];
    item.title=[parameter objectForKey:@"title"];
    item.uid=[parameter objectForKey:@"uid"];
    
    
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
}

+(void)addUserInfoEntity:(NSDictionary *)parameter
{
    UserInfEntity *item=[UserInfEntity MR_createEntity];
    item.equipment=[parameter objectForKey:@"equipment"];
    item.followercount=[parameter objectForKey:@"followercount"];
    item.followingcount=[parameter objectForKey:@"followingcount"];
    item.intro=[parameter objectForKey:@"intro"];
    item.photocount=[parameter objectForKey:@"photocount"];
    item.sex=[parameter objectForKey:@"sex"];
    item.uid=[parameter objectForKey:@"uid"];
    item.uname=[parameter objectForKey:@"uname"];
    item.province=[parameter objectForKey:@"province"];
    item.city=[parameter objectForKey:@"city"];
    item.area=[parameter objectForKey:@"area"];
    item.login=[parameter objectForKey:@"login"];
    
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
}

+(void)updateUserEntity:(NSString *)user_id
{
}


+(void)updateSelfUserEntity
{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameter=@{USER_Token: USER_PHPSESSID};
    [manager POST:Peanut_User_info_Address parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dic=responseObject;
        if ([[dic objectForKey:@"status"]integerValue]==1) {
            [CoreData_Helper addUserInfoEntity: [dic objectForKey:@"data"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    

}


+(UserInfEntity*)GetUserInfEntity:(NSString *)uid
{

    return nil;
}

+(UserInfEntity*)GetSelfUserInfEntity
{
    NSArray *list=[UserInfEntity MR_findByAttribute:@"uid" withValue:USER_UID];
    return [list objectAtIndex:0];
}


+(void)updateStaticData
{


}

@end
