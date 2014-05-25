//
//  ShareViewController.h
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublishCommentTableViewCell.h"
#import "BaseUIViewController.h"

@protocol Delegate_shareVC <NSObject>

-(void)didShare;

@end


@interface ShareViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,Delegate_publishCommentCell>
@property (nonatomic,assign) id<Delegate_shareVC>delegate;

@end
