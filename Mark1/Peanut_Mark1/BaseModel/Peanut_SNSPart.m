//
//  Peanut_SNSPart.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/14/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "Peanut_SNSPart.h"

#import "RequestPackage.h"

#define like_icon @"1.png"
#define comment_icon @"2.png"
#define forward_icon @"3.png"




@interface Peanut_SNSPart(){
    UIButton *btn1;
    UIButton *btn2;
    UIButton *btn3;
}
@end


@implementation Peanut_SNSPart

-(id)initWithType:(BottomSMSType)type andData:(id)data AndDelegate:(id<Delegate_SNS>)delegate AndTarget:(UIViewController *)target
{
    self=[super init];
    if (self) {
        [self init_Layout];
    }
    return self;
}

-(void)init_Layout
{
    btn1=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setImage:[UIImage imageNamed:like_icon] forState:UIControlStateNormal];
    [self addSubview:btn1];
    btn1.frame=CGRectMake(SelfScreenbounds.size.width*(0.f+1.f/15.f), self.frame.size.height*0.2, SelfScreenbounds.size.width*0.2, self.frame.size.height*0.6);

    btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setImage:[UIImage imageNamed:comment_icon] forState:UIControlStateNormal];
    [self addSubview:btn2];
    btn2.frame=CGRectMake(SelfScreenbounds.size.width*(1.f/3.f+1.f/15.f), self.frame.size.height*0.2, SelfScreenbounds.size.width*0.2, self.frame.size.height*0.6);
    
    btn3=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setImage:[UIImage imageNamed:forward_icon] forState:UIControlStateNormal];
    [self addSubview:btn3];
    btn3.frame=CGRectMake(SelfScreenbounds.size.width*(2.f/3.f+1.f/15.f), self.frame.size.height*0.2, SelfScreenbounds.size.width*0.2, self.frame.size.height*0.6);
    
    

    
}


@end
