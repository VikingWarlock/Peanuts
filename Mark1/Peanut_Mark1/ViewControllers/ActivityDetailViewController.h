//
//  ActivityDetailViewController.h
//  Peanut_Mark1
//
//  Created by 张众 on 5/16/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "Mask.h"

@interface ActivityDetailViewController : BaseUIViewController <UITableViewDataSource,UITableViewDelegate,UITabBarControllerDelegate>
@property (nonatomic,strong) NSString *feedid;
@property (strong,nonatomic) Mask *mask;
- (id)initWithFeedId:(int)feedId bgImageUrl:(NSURL *)url;
- (id)initWithFeedId:(id)feedId;
@end
