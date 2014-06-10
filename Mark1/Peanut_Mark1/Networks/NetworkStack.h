//
//  NetworkStack.h
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,NetworkStatus_Peanut) {
    NetworkStatus_None=0,
    NetworkStatus_WiFi,
    NetworkStatus_Cellular,
    NetworkStatus_Unknown
};

typedef NS_ENUM(NSInteger,RequestMethod) {
    Request_Post=0,
    Request_Get
};

@interface NetworkStack : NSObject




+(void)setup;

/**
 *
 *公用对象
 */
+(NetworkStack*)PublicObject;

/**
 *
 *设备的网络情况
 *@see NetworkStatus
 */
+(NetworkStatus_Peanut)NowNetworkStatus;

/**
 *
 *后台是否正在进行请求
 */
-(BOOL)isRequesting;

/**
 *
 *添加请求到队列中
 */
-(void)AddRequestToStack:(NSString*)url WithRequestMethod:(RequestMethod)method  AndRequestParameter:(NSDictionary*)parameter_request AndSucceedParameter:(NSDictionary*)parameter_succeed;
/**
 *
 * 重载所有队列中的请求
 */
-(void)reloadRequest;


@end
