//
//  imgCollectionViewController.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "BaseUIViewController.h"
#import "imgCollectionTableViewCell.h"
#import "CommentViewController.h"
#import "ShareViewController.h"

@interface imgCollectionViewController : BaseUIViewController<UITableViewDataSource,UITableViewDelegate,Delegate_imgCell,Delegate_commentVC,Delegate_shareVC>

@end
