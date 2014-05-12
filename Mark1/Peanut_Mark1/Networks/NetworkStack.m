//
//  NetworkStack.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//


#import "NetworkStack.h"
#import <AFNetworking.h>
#import <AFHTTPRequestOperation.h>
#import <Reachability.h>
#import <RTAlertView.h>
#import "NetworkRequest.h"

static NetworkStack *shared;
static NSMutableArray *NetworkArray;


@interface NetworkStack()
{
    BOOL nowRequesting;
    NSMutableArray *RequestList;
    Reachability *reachTest;
}

@property(nonatomic)NetworkStatus_Peanut networkStatus;

@end



@implementation NetworkStack


+(void)setup
{
    if (shared==nil)
        shared=[[NetworkStack alloc]init];

}

-(id)init
{
    self=[super init];
    nowRequesting=NO;
    RequestList=[[NSMutableArray alloc]init];
    self.networkStatus=NetworkStatus_Unknown;
    NetworkArray=[NSMutableArray arrayWithArray:[NetworkRequest MR_findAllSortedBy:@"requestPosition" ascending:YES]];
    
    if (NetworkArray==nil) {
        NetworkArray=[[NSMutableArray alloc]init];
    }
    
   
    
    reachTest=[Reachability reachabilityForInternetConnection];
  
    NetworkStatus cur=[reachTest currentReachabilityStatus];
    switch (cur) {
        case ReachableViaWiFi:
        {
            self.networkStatus=NetworkStatus_WiFi;
            break;
        }
        case ReachableViaWWAN:
        {
            self.networkStatus=NetworkStatus_Cellular;
            break;
        }
        case NotReachable:
        {
            self.networkStatus=NetworkStatus_None;
            [self alert];
            break;
        }
        default:
            break;
    }

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
    selector:@selector(reachabilityChanged:)
    name:kReachabilityChangedNotification
    object:nil];
    
    [reachTest startNotifier];
    
    return self;
    
}

-(NSInteger)maxNumOfRequest
{
    if ([RequestList count]>0) {
        NetworkRequest *item =[RequestList objectAtIndex:0];
        return [item.requestPosition integerValue]+1;
    }else
    return 0;
}

+(NetworkStack*)PublicObject
{
    if (shared==nil)
        shared=[[NetworkStack alloc]init];
    
    
    return shared;
    
}

+(NetworkStatus_Peanut)NowNetworkStatus
{

    NetworkStatus_Peanut status=[NetworkStack PublicObject].networkStatus;
    return status!=NetworkStatus_Unknown?status:NetworkStatus_None;
}


-(void)alert
{
    RTAlertView *alert=[[RTAlertView alloc]initWithTitle:[@"warning" PeanutString] message:[@"network unavailable" PeanutString] delegate:nil cancelButtonTitle:[@"ok" PeanutString] otherButtonTitles:nil];
    [alert show];
    
}

#pragma NetworkStatus


-(void)reachabilityChanged:(NSNotification*)notification
{

    __weak Reachability* weakReach=notification.object;
    switch ([weakReach currentReachabilityStatus]) {
        case ReachableViaWiFi:
        {
            self.networkStatus=NetworkStatus_WiFi;
            break;
        }
        case ReachableViaWWAN:
        {
            self.networkStatus=NetworkStatus_Cellular;
            break;
        }
        case NotReachable:
        {
            self.networkStatus=NetworkStatus_None;
            [self alert];
            break;
        }
        default:
            break;
    }

}



-(BOOL)isRequesting
{
    return nowRequesting;
}


-(void)AddRequestToStack:(NSString *)url WithRequestMethod:(RequestMethod)method AndRequestParameter:(NSDictionary *)parameter_request AndSucceedParameter:(NSDictionary *)parameter_succeed
{
    NetworkRequest *item =[NetworkRequest MR_createEntity];
    item.requestUrl=url;
    item.requestPosition=@([self maxNumOfRequest]);
    item.requestParameter=parameter_request;
    item.requestSucceed=parameter_succeed;
    
    switch (method) {
        case Request_Post:
        {
        item.requestMethod=@(Method_Post);
        
        [self post:item AndFailBlock:^(NetworkRequest *item, NSError *error) {
        [RequestList addObject:item];
        [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
        [self reloadRequest];
            
        }];
            break;
        }
        case Request_Get:
        {
        item.requestMethod=@(Method_Get);
        
        [self get:item AndFailBlock:^(NetworkRequest *item, NSError *error) {
        [RequestList addObject:item];
        [[NSManagedObjectContext MR_context]MR_saveToPersistentStoreAndWait];
        [self reloadRequest];
        
        }];
            break;
        }
        default:
            break;
    }
    
    [self reloadRequest];
    

}

-(void)reloadRequest
{
    if (nowRequesting) {
        return;
    }
    
    if ([NetworkStack NowNetworkStatus]==NetworkStatus_None) {
        return;
    }
    
    if ([RequestList count]>0)
    {
        nowRequesting=YES;
        for(NetworkRequest *item in RequestList)
        {
            switch ([item.requestMethod integerValue]) {
                case Request_Post:
                {
                    item.requestMethod=@(Method_Post);
                    
                    [self post:item AndFailBlock:^(NetworkRequest *item, NSError *error) {
                        
                        //请求错误要做什么？？
                        
                    }];
                    break;
                }
                case Request_Get:
                {
                    item.requestMethod=@(Method_Get);
                    
                    [self get:item AndFailBlock:^(NetworkRequest *item, NSError *error) {
                        //请求错误要做什么？？

                        
                    }];
                    break;
                }
                default:
                    break;
            }
        
        }
    }
    else
    {
        nowRequesting=NO;
        return;
    }
}



#pragma private method

-(void)post:(NetworkRequest*)item AndFailBlock:(void(^) (NetworkRequest* item ,NSError  *error))FailBlock
{
    if ([NetworkStack NowNetworkStatus]==NetworkStatus_None) {
        NSError*error=[NSError errorWithDomain:@"No Network available" code:-100 userInfo:nil];
        FailBlock(item,error);
    }
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager POST:item.requestUrl parameters:item.requestParameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        [self checkRequest:item AndReceiveData:responseObject AndFailBlock:FailBlock];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FailBlock(item,error);
        //错误block
    
    }];
}

-(void)get:(NetworkRequest*)item AndFailBlock:(void(^) (NetworkRequest* item ,NSError  *error))FailBlock
{
    if ([NetworkStack NowNetworkStatus]==NetworkStatus_None) {
        NSError*error=[NSError errorWithDomain:@"No Network available" code:-100 userInfo:nil];
        FailBlock(item,error);
    }

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:item.requestUrl parameters:item.requestParameter success:^(AFHTTPRequestOperation *operation, id responseObject) {

        [self checkRequest:item AndReceiveData:responseObject AndFailBlock:FailBlock];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        FailBlock(item,error);
        //错误block
    }];
    
}

-(void)checkRequest:(NetworkRequest*)item AndReceiveData:(id)data AndFailBlock:(void(^) (NetworkRequest* item ,NSError  *error))FailBlock
{

    NSError* error=nil;
    NSDictionary*respond=[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if (error!=nil) {
        NSLog(@"Return Object Is Not Json\n");
        FailBlock(item,error);
    }
    else
    {
        if (respond==item.requestSucceed) {
            [[NSNotificationCenter defaultCenter]postNotificationName:@"request done" object:@{@"URL": item.requestUrl,@"BackParameter":respond}];
            }
            else
            {
                [[NSNotificationCenter defaultCenter]postNotificationName:@"request done" object:@{@"URL": item.requestUrl,@"Error":respond}];
            }
        
            if ([item MR_deleteEntity]) {
                NSLog(@"Request Done");
                if ([NetworkArray containsObject:item]) {
                    [NetworkArray delete:item];
            }
    }
    
    
}

}
@end
