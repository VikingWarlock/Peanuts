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
        NSError *error;
        NSDictionary *response=[NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:&error];
        
        if ([[response objectForKey:@"status"]integerValue]==1) {
            [[NSUserDefaults standardUserDefaults]encryptValue:[[response objectForKey:@"data"]objectForKey:USER_Token] withKey:USER_Token];
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

    
    
}

@end
