//
//  CoreData-Helper.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#import "CoreData-Helper.h"
#import "NSDictionary+extra.h"

#import <AFNetworking.h>

@implementation CoreData_Helper

+(void)addPhotoEntity:(NSDictionary *)parameter
{
    PhotoInfoEntity *item=[CoreData_Helper GetPhotoEntity:[parameter StringForKey:@"feed_id"]];
    if (item==nil) {
        item=[PhotoInfoEntity MR_createEntity];
    }
    item.feed_id=[parameter StringForKey:@"feed_id"];
    item.comment_count=[parameter StringForKey:@"comment_count"];
    item.descriptions=[parameter StringForKey:@"discription"];
    item.dig_count=[parameter StringForKey:@"digg_count"];
    item.imageURL=[parameter StringForKey:@"imageUrl"];
    item.is_report=[parameter StringForKey:@"is_repost"];
    item.publish_time=[parameter StringForKey:@"publish_time"];
    item.recommend_count=[parameter StringForKey:@"recommend"];
    item.recomment_content= [parameter StringForKey:@"recommend_content"];
//    item.recomment_content= NULL_TO_NIL([parameter StringForKey:@"recommend_content"]);
    item.repost_count=[parameter StringForKey:@"repost_count"];
    item.uid=[parameter StringForKey:@"uid"];
    item.group_feed_id=[parameter StringForKey:@"group_feed_id"];

    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
}

+(void)addPhotoSeriesEntity:(NSDictionary *)parameter
{
    PhotoSeriesEntity *item=[CoreData_Helper GetPhotoSeriesEntity:[parameter StringForKey:@"feed_id"]];
    if (item==nil) {
        item=[PhotoSeriesEntity MR_createEntity];

    }
    item.addr=[parameter StringForKey:@"addr"];
    item.comment_count=[parameter StringForKey:@"comment_count"];
    item.cover_url=[parameter StringForKey: @"cover"];
    item.descriptions=[parameter StringForKey:@"description"];
    item.dig_count=[parameter StringForKey:@"digg_count"];
    item.feed_id=[parameter StringForKey:@"feed_id"];
    
    item.is_repost=[parameter StringForKey:@"is_post"];
    item.publish_time=[parameter StringForKey:@"publish_time"];
    item.recommend_content=[parameter StringForKey:@"recommend_content"];
 //   item.recommend_content=NULL_TO_NIL([parameter StringForKey:@"recommend_content"]);
    
    item.recommend_count=[parameter StringForKey:@"recommend"];
    item.repost_count=[parameter StringForKey:@"repost_count"];
    item.topic=[parameter StringForKey:@"topic"];
    item.uid=[parameter StringForKey:@"uid"];
    
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
    /*
    item.is_report=parameter[@"is_post"];
    item.publish_time=parameter[@"publish_time"];
    item.recommend_content=parameter[@"recommend_content"];
    */
    
}

+(void)addActivityEntity:(NSDictionary *)parameter
{
    ActivityEntity *item=[CoreData_Helper GetActivityEntity:[parameter StringForKey:@"feed_id"]];
    if ( item==nil) {
        item=[ActivityEntity MR_createEntity];
    }
    
    item.feed_id=[parameter StringForKey:@"feed_id"];
    item.cover_url=[parameter StringForKey:@"cover"];
    item.uid=[parameter StringForKey:@"uid"];
    item.publish_time=[parameter StringForKey:@"publish_time"];
    item.comment_count=[parameter StringForKey:@"comment_count"];
    item.dig_count=[parameter StringForKey:@"digg_count"];
    item.repost_count=[parameter StringForKey:@"repost_count"];
    item.is_repost=[parameter StringForKey:@"is_repost"];
    item.begin_time=[parameter StringForKey:@"begin_time"];
    item.end_time=[parameter StringForKey:@"end_time"];
    item.fee_limit=[parameter StringForKey:@"fee_limit"];
    item.member_audit=[parameter StringForKey:@"member_audit"];
    item.credit_limit=[parameter StringForKey:@"credit_limit"];
    item.address=[parameter StringForKey:@"address"];
    item.descriptions=[parameter StringForKey:@"description"];
    item.topic=[parameter StringForKey:@"topic"];
    
    item.avatar_original_url=[parameter StringForKey:@"avatar_original"];
    item.avatar_big_url=[parameter StringForKey:@"avatar_big"];
    item.avatar_small_url=[parameter StringForKey:@"avatar_small"];
    

    item.avatar_tiny_url=[parameter StringForKey:@"avatar_tiny"];
    item.avatar_middle_url=[parameter StringForKey:@"avatar_middle"];
    item.personNum_limit=[parameter StringForKey:@"personNum_limit"];
    
    item.activityType=[parameter StringForKey:@"activityType"];
    item.isCurrent=[[parameter objectForKey:@"isCurrent"]stringValue];
    
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
}

+(void)addMustReadEntity:(NSDictionary *)parameter
{
    MustReadEntity *item=[CoreData_Helper GetMustReadEntity:[parameter StringForKey:@"feed_id"]];
    if (item==nil) {
        item=[MustReadEntity MR_createEntity];
    }
    
    item.abstraction=[parameter StringForKey:@"abstraction"];
    item.comment_count=[parameter StringForKey:@"comment_count"];
    item.content=[parameter StringForKey:@"content"];
    item.cover_url=[parameter StringForKey:@"cover_url"];
    item.dig_count=[parameter StringForKey:@"digg_count"];
    item.feed_id=[parameter StringForKey:@"feed_id"];
    item.is_report=[parameter StringForKey:@"is_report"];
    item.page_views=[parameter StringForKey:@"page_views"];
    item.publish_time=[parameter StringForKey:@"publish_time"];
    item.repost_count=[parameter StringForKey:@"repost_count"];
    item.title=[parameter StringForKey:@"title"];
    item.uid=[parameter StringForKey:@"uid"];
    
    
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
}

+(void)addUserInfoEntity:(NSDictionary *)parameter
{
    UserInfEntity *item=[CoreData_Helper GetUserInfEntity:[parameter StringForKey:@"uid"]];
    if (item==nil) {
        item=[UserInfEntity MR_createEntity];
    }
    item.equipment=[parameter StringForKey:@"equipment"];
    item.followercount=[parameter StringForKey:@"followercount"];
    item.followingcount=[parameter StringForKey:@"followingcount"];
    item.intro=[parameter StringForKey:@"intro"];
    item.photocount=[parameter StringForKey:@"photocount"];
    item.sex=[parameter StringForKey:@"sex"];
    item.uid=[parameter StringForKey:@"uid"];
    item.uname=[parameter StringForKey:@"uname"];
    item.province=[parameter StringForKey:@"province"];
    item.city=[parameter StringForKey:@"city"];
    item.area=[parameter StringForKey:@"area"];
    item.login=[parameter StringForKey:@"login"];
    item.avatarPic=[parameter StringForKey:@"avatar_original"];
    item.avatar_middle=[parameter StringForKey:@"avatar_middle"];
    item.avatar_small=[parameter StringForKey:@"avatar_small"];
    item.avatar_tiny=[parameter StringForKey:@"avatar_tiny"];
    
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
        if ([[dic StringForKey:@"status"]integerValue]==1) {
            [CoreData_Helper addUserInfoEntity: [dic objectForKey:@"data"]];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
    }];
    

}


+(UserInfEntity*)GetUserInfEntity:(NSString *)uid
{
    NSArray *list=[UserInfEntity MR_findByAttribute:@"uid" withValue:uid];
    if ([list count]>0) {
        return [list objectAtIndex:0];
    }else
        return nil;
}

+(UserInfEntity*)GetSelfUserInfEntity
{
    NSArray *list=[UserInfEntity MR_findByAttribute:@"uid" withValue:USER_UID];
    if ([list count]>0) {
        return [list objectAtIndex:0];
    }else
        return nil;
}

+(PhotoSeriesEntity*)GetPhotoSeriesEntity:(NSString *)feed_id
{
    NSArray *list=[PhotoSeriesEntity MR_findByAttribute:@"feed_id" withValue:feed_id];
    if ([list count]>0) {
        return [list objectAtIndex:0];
    }else
        return nil;
}

+(PhotoInfoEntity*)GetPhotoEntity:(NSString *)feed_id
{
    NSArray *list=[PhotoInfoEntity MR_findByAttribute:@"feed_id" withValue:feed_id];
    if ([list count]>0) {
        return [list objectAtIndex:0];
    }else
        return nil;
}

+(ActivityEntity*)GetActivityEntity:(NSString *)feed_id
{
    NSArray *list=[ActivityEntity MR_findByAttribute:@"feed_id" withValue:feed_id];
    if ([list count]>0) {
        return [list objectAtIndex:0];
    }else
        return nil;
}

+(MustReadEntity*)GetMustReadEntity:(NSString *)feed_id
{
    NSArray *list=[MustReadEntity MR_findByAttribute:@"feed_id" withValue:feed_id];
    if ([list count]>0) {
        return [list objectAtIndex:0];
    }else
        return nil;
}

+(void)updateStaticData
{


}

+(NSString *)DateFromTimestamp:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp
{
    NSDate *begin = [NSDate dateWithTimeIntervalSince1970:[beginTimestamp intValue]];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:[endTimestamp intValue]];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd"];
    NSString *date = [NSString stringWithFormat:@"%@ - %@",[formatter stringFromDate:begin],[formatter stringFromDate:end]];
    return date;
}

+(NSString*)TimeFromTimestamp:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp
{
    NSDate *begin = [NSDate dateWithTimeIntervalSince1970:[beginTimestamp intValue]];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:[endTimestamp intValue]];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"hh:mm:ss"];
    NSString *date = [NSString stringWithFormat:@"%@ - %@",[formatter stringFromDate:begin],[formatter stringFromDate:end]];
    return date;

}

+(NSString*)DateAndTimeFromTimestamp:(NSString *)beginTimestamp endTimestamp:(NSString *)endTimestamp
{
    NSDate *begin = [NSDate dateWithTimeIntervalSince1970:[beginTimestamp intValue]];
    NSDate *end = [NSDate dateWithTimeIntervalSince1970:[endTimestamp intValue]];
    
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy/MM/dd hh:mm:ss"];
    NSString *date = [NSString stringWithFormat:@"%@ - %@",[formatter stringFromDate:begin],[formatter stringFromDate:end]];
    return date;

}



@end
