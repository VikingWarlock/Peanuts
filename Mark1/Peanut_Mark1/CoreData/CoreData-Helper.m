//
//  CoreData-Helper.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "CoreData-Helper.h"


#import <AFNetworking.h>

@implementation CoreData_Helper

+(void)addPhotoEntity:(NSDictionary *)parameter
{
    PhotoInfoEntity *item=[CoreData_Helper GetPhotoEntity:[parameter objectForKey:@"feed_id"]];
    if (item==nil) {
        item=[PhotoInfoEntity MR_createEntity];
    }
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
    PhotoSeriesEntity *item=[CoreData_Helper GetPhotoSeriesEntity:[parameter objectForKey:@"feed_id"]];
    if (item==nil) {
        item=[PhotoSeriesEntity MR_createEntity];

    }
    item.addr=[parameter objectForKey:@"addr"];
    item.comment_count=[parameter objectForKey:@"comment_count"];
    item.cover_url=[parameter objectForKey: @"cover"];
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
    ActivityEntity *item=[CoreData_Helper GetActivityEntity:[parameter objectForKey:@"feed_id"]];
    if ( item==nil) {
        item=[ActivityEntity MR_createEntity];
    }
    
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
    item.topic=[parameter objectForKey:@"topic"];
    
    item.avatar_original_url=[parameter objectForKey:@"avatar_original"];
    item.avatar_big_url=[parameter objectForKey:@"avatar_big"];
    item.avatar_small_url=[parameter objectForKey:@"avatar_small"];
    

    item.avatar_tiny_url=[parameter objectForKey:@"avatar_tiny"];
    item.avatar_middle_url=[parameter objectForKey:@"avatar_middle"];
    item.personNum_limit=[parameter objectForKey:@"personNum_limit"];
    
    item.activityType=[parameter objectForKey:@"activityType"];
    item.isCurrent=[[parameter objectForKey:@"isCurrent"]stringValue];
    
    [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
    
}

+(void)addMustReadEntity:(NSDictionary *)parameter
{
    MustReadEntity *item=[CoreData_Helper GetMustReadEntity:[parameter objectForKey:@"feed_id"]];
    if (item==nil) {
        item=[MustReadEntity MR_createEntity];
    }
    
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
    UserInfEntity *item=[CoreData_Helper GetUserInfEntity:[parameter objectForKey:@"uid"]];
    if (item==nil) {
        item=[UserInfEntity MR_createEntity];
    }
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
    item.avatarPic=[parameter objectForKey:@"avatar_original"];
    item.avatar_middle=[parameter objectForKey:@"avatar_middle"];
    item.avatar_small=[parameter objectForKey:@"avatar_small"];
    item.avatar_tiny=[parameter objectForKey:@"avatar_tiny"];
    
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
