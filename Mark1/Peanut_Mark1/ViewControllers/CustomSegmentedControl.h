//
//  CustomSegmentedControl.h
//  Peanut_Mark1
//
//  Created by 张众 on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomSegmentedControl : UIView
@property (strong,nonatomic) UIButton *leftButton;
@property (strong,nonatomic) UIButton *rightButton;
@property (nonatomic) BOOL isOnline;
@property (nonatomic,setter = setIsProgressing:) BOOL isProgressing;
- (id)initWithisProgressing:(BOOL)isProgressing;
@end

