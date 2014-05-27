//
//  ActivityEntity.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/27/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ActivityEntity : NSManagedObject

@property (nonatomic, retain) NSString * activityType;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * avatar_big_url;
@property (nonatomic, retain) NSString * avatar_middle_url;
@property (nonatomic, retain) NSString * avatar_original_url;
@property (nonatomic, retain) NSString * avatar_small_url;
@property (nonatomic, retain) NSString * avatar_tiny_url;
@property (nonatomic, retain) NSString * begin_time;
@property (nonatomic, retain) NSString * comment_count;
@property (nonatomic, retain) NSString * cover_url;
@property (nonatomic, retain) NSString * credit_limit;
@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSString * dig_count;
@property (nonatomic, retain) NSString * end_time;
@property (nonatomic, retain) NSString * fee_limit;
@property (nonatomic, retain) NSString * feed_id;
@property (nonatomic, retain) id image_path_array;
@property (nonatomic, retain) NSNumber * is_repost;
@property (nonatomic, retain) NSNumber * isCurrent;
@property (nonatomic, retain) NSNumber * member_audit;
@property (nonatomic, retain) NSString * personNum_limit;
@property (nonatomic, retain) NSString * publish_time;
@property (nonatomic, retain) NSString * repost_count;
@property (nonatomic, retain) NSString * uid;

@end
