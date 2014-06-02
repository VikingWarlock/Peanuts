//
//  RequestPackage.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/19/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "RequestPackage.h"
#import <AFNetworking.h>
#import <AFHTTPRequestOperation.h>
#import <RTAlertView.h>
#import "API_address.h"
#import "PublicLib.h"
#import "StaticDataManager.h"


static RequestPackage * PublicObject;

@implementation RequestPackage



+(RequestPackage*)shareObject
{
    if (PublicObject==nil) {
        PublicObject=[[RequestPackage alloc]init];
    }
    return PublicObject;
}


-(id)init
{
    self=[super init];
    if (self) {
        //init code here
    }
    return self;
}


-(void)LoginWithUsername:(NSString *)username andPassword:(NSString *)passwd
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameter=@{@"username": username,@"password":passwd};
    [manager POST:Peanut_Login_Address parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //NSDictionary *response=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        
        NSDictionary *response=responseObject;
        
        if ([[response objectForKey:@"status"]integerValue]==1) {
            [[NSUserDefaults standardUserDefaults]encryptValue:[[response objectForKey:@"data"]objectForKey:USER_Token] withKey:USER_Token];
            [[NSUserDefaults standardUserDefaults]encryptValue:[[[response objectForKey:@"data"] objectForKey:@"user_info"] objectForKey:@"uid"] withKey:USER_UID_Fetch];
            [CoreData_Helper addUserInfoEntity:[[response objectForKey:@"data"] objectForKey:@"user_info"]];
            
            RTAlertView *alert=[[RTAlertView alloc]initWithTitle:@"Note" message:@"Login Succeed" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
        
    
}


-(void)Logout
{
    NSString *passphare=[[NSUserDefaults standardUserDefaults]decryptedValueForKey:USER_Token];
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameter=@{USER_Token: passphare};
    
    [manager POST:Peanut_Logout_Address parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    
    [[NSUserDefaults standardUserDefaults]removeObjectForAESKey:USER_Token];
    
}


-(void)DigSomething:(NSString *)feed_id
{
    
    if (![self HaveBeenLogin]) {
        // 提示没有登录;
    }else
    {
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameter=@{USER_Token: [[NSUserDefaults standardUserDefaults]decryptedValueForKey:USER_Token],@"feed_id":feed_id};
    [manager POST:Peanut_Dig_Something parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
    }
}

-(void)CancelDigSomething:(NSString *)feed_id
{
    if (![self HaveBeenLogin]) {
        // 提示没有登录;
    }else
    {
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSDictionary *parameter=@{USER_Token: [[NSUserDefaults standardUserDefaults]decryptedValueForKey:USER_Token],@"feed_id":feed_id};
        [manager POST:Peanut_Cancel_Dig_Something parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
        
    }


}

-(void)DeleteCommentWithComment_id:(NSString *)comment_id AndFeed_id:(NSString *)feed_id
{
    if ([self HaveBeenLogin]) {
        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSDictionary *parameter=@{USER_Token: [[NSUserDefaults standardUserDefaults]decryptedValueForKey:USER_Token],@"comment_id":comment_id,@"feed_id":feed_id};
        [manager POST:Peanut_Delete_comment_Address parameters:parameter success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
    }else
    {
    
    //提示没有登录
    }

    
    
}

-(BOOL)HaveBeenLogin
{
    if ([[[NSUserDefaults standardUserDefaults]decryptedValueForKey:USER_Token]length]<=0) {
        return NO;
    }else
        return YES;
}



-(NSDictionary*)GetTheInfoFrom:(id)response
{
    NSError* error=nil;
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:response options:kNilOptions error:&error];
    if (error) {
        NSLog(@"%@",error);
        return nil;
    }else
        return dic;
        
}




-(void)FetchActivities
{

}

-(void)FetchMustRead
{

}

-(void)FetchSquare
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:Peanut_Fetch_Square_Address parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *decoded=[self GetTheInfoFrom:responseObject];
        if ([[decoded objectForKey:@"status"]integerValue]!=1) {
            // 错误信息
            NSLog(@"%@",[decoded objectForKey:@"info"]);
        }else
        {
            
            
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
    }];
    

    
    
    
}



-(void)FetchHomePage
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager POST:Peanut_Fetch_Home_Address parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *response=responseObject;
        if ([[response objectForKey:@"status"]integerValue]==1) {
            
            NSDictionary *data=[response objectForKey:@"data"];
            
            [[StaticDataManager sharedObject]updateHomePageData:data];
            
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



-(void)FetchPhotoSeriesList:(NSInteger)page AndCount:(NSInteger)count
{


}






@end
