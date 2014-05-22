//
//  MustReadEntity.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/22/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface MustReadEntity : NSManagedObject

@property (nonatomic, retain) NSString * abstraction;
@property (nonatomic, retain) NSNumber * comment_count;
@property (nonatomic, retain) NSString * content;
@property (nonatomic, retain) NSString * cover_url;
@property (nonatomic, retain) NSNumber * dig_count;
@property (nonatomic, retain) NSString * feed_id;
@property (nonatomic, retain) NSNumber * is_report;
@property (nonatomic, retain) NSNumber * page_views;
@property (nonatomic, retain) NSNumber * publish_time;
@property (nonatomic, retain) NSNumber * repost_count;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * uid;

@end
