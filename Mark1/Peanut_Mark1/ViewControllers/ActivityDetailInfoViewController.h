//
//  ActivityDetailInfoViewController.h
//  Peanut_Mark1
//
//  Created by 张众 on 5/16/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseUIViewController.h"
#import "Mask.h"

@interface ActivityDetailInfoViewController : BaseUIViewController
@property (nonatomic,strong) Mask *mask;
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) NSString *description;
@property (nonatomic,strong) UIImage *backImage;

@end
