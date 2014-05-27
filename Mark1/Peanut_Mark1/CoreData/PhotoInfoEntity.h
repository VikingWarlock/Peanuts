//
//  PhotoInfoEntity.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/27/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PhotoDetailEntity;

@interface PhotoInfoEntity : NSManagedObject

@property (nonatomic, retain) NSString * comment_count;
@property (nonatomic, retain) NSString * descriptions;
@property (nonatomic, retain) NSString * dig_count;
@property (nonatomic, retain) NSString * feed_id;
@property (nonatomic, retain) NSString * group_feed_id;
@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * is_report;
@property (nonatomic, retain) NSString * local_path;
@property (nonatomic, retain) NSString * publish_time;
@property (nonatomic, retain) NSString * recommend_count;
@property (nonatomic, retain) NSString * recomment_content;
@property (nonatomic, retain) NSString * repost_count;
@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) PhotoDetailEntity *details;

@end
