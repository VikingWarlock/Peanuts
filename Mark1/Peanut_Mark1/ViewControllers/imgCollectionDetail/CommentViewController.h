//
//  CommentViewController.h
//  Peanut_Mark1
//
//  Created by 马君 on 14-5-13.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "CommentTableViewCell.h"


@interface CommentViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,DeleteCommentDelegate>

@end
