//
//  Peanut_SNSPart.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/14/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Delegate_SNS <NSObject>

@optional

@end

typedef NS_ENUM(NSInteger, BottomSMSType) {
    BottomSMSType_Activity=0,
    BottomSMSType_Photoseries,
    BottomSMSType_SinglePhoto
};

@interface Peanut_SNSPart : UIView

-(id)initWithType:(BottomSMSType)type andData:(id)data AndDelegate:(id<Delegate_SNS>)delegate AndTarget:(UIViewController*)target;

@property(nonatomic,weak)id<Delegate_SNS> delegate_sns;

@end
