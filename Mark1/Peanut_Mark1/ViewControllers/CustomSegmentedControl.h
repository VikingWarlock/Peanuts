//
//  CustomSegmentedControl.h
//  Peanut_Mark1
//
//  Created by 张众 on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol customSegCtrolDelegate <NSObject>

- (void)ClickedButtonIsOnline:(NSInteger)isOnline IsPresenting:(NSInteger)ispresenting IsProgressing:(NSInteger)isprogressing;

@end

@interface CustomSegmentedControl : UIView 
@property (strong,nonatomic) UIButton *leftButton;
@property (strong,nonatomic) UIButton *rightButton;
@property (nonatomic) BOOL isOnline;
@property (nonatomic) BOOL isProgressing;
@property (nonatomic,strong) id delegate;
@property (nonatomic,setter = setIsPresenting:) BOOL isPresenting;
- (id)initWithisProgressing:(BOOL)isProgressing;
@end

