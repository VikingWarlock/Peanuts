//
//  SelfUser_ViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "SelfUser_ViewController.h"
#import "RequestPackage.h"

@interface SelfUser_ViewController ()<UITextFieldDelegate>
{
    UIControl *control;
    BOOL Logined;
    
}
@end

@implementation SelfUser_ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    if ([USER_PHPSESSID length]<=0) {
        Logined=NO;
        control=[[UIControl alloc]init];
        [self.view addSubview:control];
        control.frame=self.view.frame;
        [control addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        
        UserName_Field=[[UITextField alloc]init];
        Password_Field=[[UITextField alloc]init];
        [self.view addSubview:UserName_Field];
        [self.view addSubview:Password_Field];
        
        UserName_Field.backgroundColor=[UIColor clearColor];
        Password_Field.backgroundColor=[UIColor clearColor];
        
        UserName_Field.adjustsFontSizeToFitWidth=YES;
        Password_Field.adjustsFontSizeToFitWidth=YES;
        
        
        
        UserName_Field.frame=CGRectMake(60, 80, 220, 40);
        Password_Field.frame=CGRectMake(60, 160, 220, 40);
        Password_Field.secureTextEntry=YES;
        
        
        UserName_Field.tintColor=[UIColor whiteColor];
        Password_Field.tintColor=[UIColor whiteColor];
        UserName_Field.textColor=[UIColor whiteColor];
        Password_Field.textColor=[UIColor whiteColor];
        
        UserName_Field.placeholder=@"UserName";
        Password_Field.placeholder=@"PassWord";
        
        
        
        UserName_Field.delegate=self;
        Password_Field.delegate=self;
        
        UserName_Field.returnKeyType=UIReturnKeyNext;
        Password_Field.returnKeyType=UIReturnKeyDone;
        
    }else
    {
        LoginDetail=[[UILabel alloc]init];
        [self.view addSubview:LoginDetail];
        LoginDetail.backgroundColor=[UIColor clearColor];
        LoginDetail.text=USER_PHPSESSID;
        LoginDetail.frame=CGRectMake(60, 80, 220, 40);
        
        
        LoginButton =[UIButton buttonWithType:UIButtonTypeCustom];
        [LoginButton setTitle:@"登出" forState:UIControlStateNormal];
        [self.view addSubview:LoginButton];
        LoginButton.frame=CGRectMake(60, 160, 220, 40);
        [LoginButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
        
        
        
    }
    
    
    // Do any additional setup after loading the view.
}


-(void)logout
{
    [[RequestPackage shareObject]Logout];
    [self.NavigationController popViewControllerAnimated:YES];
}

-(void)dismiss
{
    if ([Password_Field isFirstResponder]) {
        [Password_Field endEditing:YES];
//        [Password_Field resignFirstResponder];
//        [[RequestPackage shareObject]LoginWithUsername:UserName_Field.text andPassword:Password_Field.text];
//        [self.NavigationController popViewControllerAnimated:YES];
    }else
    {
//        [UserName_Field resignFirstResponder];
        [UserName_Field endEditing:YES];
    }
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{

    if (textField==UserName_Field) {
        [Password_Field becomeFirstResponder];
    }else
    {
        [Password_Field resignFirstResponder];
        [[RequestPackage shareObject]LoginWithUsername:UserName_Field.text andPassword:Password_Field.text];
        [self.NavigationController popViewControllerAnimated:YES];
    }
    
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
