//
//  SelfUser_ViewController.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/26/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "SelfUser_ViewController.h"
#import "RequestPackage.h"
#import "UserInfEntity.h"
#import "Peanuts_Helper.h"
#import <RTAlertView.h>

@interface SelfUser_ViewController ()<UITextFieldDelegate,RTAlertViewDelegate>
{
    UIControl *control;
    BOOL Logined;
    UIImageView *logoView;
    UIButton *SignUp;
    UIButton *bigButton;
    BOOL needSignUp;
    NSInteger errorID;
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


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self.NavigationController navigationBar]setTranslucent:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    errorID=0;
    needSignUp=YES;
    self.navigationItem.title=@"编辑资料";
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"accept_button.png"] style:UIBarButtonItemStylePlain target:self action:@selector(loginProcedure)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    
    logoView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"logo_loginPage.png"]];
    [self.view addSubview:logoView];
    [logoView setContentMode:UIViewContentModeScaleAspectFit];
    logoView.center=CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height*0.25);
    
        Logined=NO;
        control=[[UIControl alloc]init];
        [self.view addSubview:control];
        control.frame=self.view.frame;
        [control addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
        
        
    UserName_Field=[[UITextField alloc]init];
    Password_Field=[[UITextField alloc]init];
    Confirm_Field=[[UITextField alloc]init];
    [self.view addSubview:UserName_Field];
    [self.view addSubview:Password_Field];
    
    
    UserName_Field.backgroundColor=[UIColor clearColor];
    Password_Field.backgroundColor=[UIColor clearColor];
    Confirm_Field.backgroundColor=[UIColor clearColor];

    
    UserName_Field.layer.cornerRadius=5.f;
    Password_Field.layer.cornerRadius=5.f;
    Confirm_Field.layer.cornerRadius=5.f;
    
    
    UserName_Field.layer.borderWidth=1.f;
    Password_Field.layer.borderWidth=1.f;
    Confirm_Field.layer.borderWidth=1.f;
    
    UserName_Field.layer.borderColor=[[UIColor whiteColor]CGColor];
    Password_Field.layer.borderColor=[[UIColor whiteColor]CGColor];
    Confirm_Field.layer.borderColor=[[UIColor whiteColor]CGColor];
    
    UserName_Field.adjustsFontSizeToFitWidth=YES;
    Password_Field.adjustsFontSizeToFitWidth=YES;
    Confirm_Field.adjustsFontSizeToFitWidth=YES;
    
    UIColor *color=[UIColor whiteColor];
    [UserName_Field setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"  用户名" attributes:@{NSForegroundColorAttributeName: color}]];
    [Password_Field setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"  密码" attributes:@{NSForegroundColorAttributeName:color}]];
    
    [Confirm_Field setAttributedPlaceholder:[[NSAttributedString alloc] initWithString:@"  确认密码" attributes:@{NSForegroundColorAttributeName:color}]];
     
        UserName_Field.frame=CGRectMake(self.view.frame.size.width*0.15, self.view.frame.size.height*0.45, self.view.frame.size.width*0.7, 44);
    
        Password_Field.frame=CGRectMake(self.view.frame.size.width*0.15, self.view.frame.size.height*0.55, self.view.frame.size.width*0.7, 44);
    
    Password_Field.secureTextEntry=YES;
    Confirm_Field.secureTextEntry=YES;
        
        
    UserName_Field.tintColor=[UIColor whiteColor];
    Password_Field.tintColor=[UIColor whiteColor];
    Confirm_Field.tintColor=[UIColor whiteColor];
    
    UserName_Field.textColor=[UIColor whiteColor];
    Password_Field.textColor=[UIColor whiteColor];
    Confirm_Field.textColor=[UIColor whiteColor];
    
    bigButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [bigButton setTitle:@"登录" forState:UIControlStateNormal];
    [bigButton setTitle:@"登录" forState:UIControlStateHighlighted];
    [self.view addSubview:bigButton];
    [bigButton setBackgroundColor:[UIColor whiteColor]];
    [bigButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bigButton setTitleColor:[UIColor blackColor] forState:UIControlStateHighlighted];
    
    
    [bigButton setFrame:CGRectMake(self.view.frame.size.width*0.15, self.view.frame.size.height*0.65, self.view.frame.size.width*0.7, 44)];
    [bigButton addTarget:self action:@selector(handleBigButton) forControlEvents:UIControlEventTouchUpInside];
    
        UserName_Field.delegate=self;
        Password_Field.delegate=self;
        Confirm_Field.delegate=self;
    
        
    UserName_Field.returnKeyType=UIReturnKeyNext;
    Password_Field.returnKeyType=UIReturnKeyDone;
    Confirm_Field.returnKeyType=UIReturnKeyDone;
    
    
    SignUp=[UIButton buttonWithType:UIButtonTypeSystem];
    [SignUp setTintColor:[UIColor whiteColor]];
    [SignUp setTitle:@"没有账号?" forState:UIControlStateNormal];
    [SignUp setTitle:@"没有账号?" forState:UIControlStateHighlighted];
    [SignUp addTarget:self action:@selector(signUp_action) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:SignUp];
    SignUp.frame=CGRectMake(self.view.frame.size.width/2-50, self.view.frame.size.height*0.75,100,30);
    
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
    if (textField==Password_Field) {
        [self loginProcedure];
        [self movebackView];
    }
    //  [self.NavigationController popViewControllerAnimated:YES];
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==UserName_Field) {
        [self moveViewto:Password_Field.frame];
    }else
    {
        [self moveViewto:SignUp.frame];
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{

    if (textField==UserName_Field) {
        [Password_Field becomeFirstResponder];
    }else
    {
        [Password_Field resignFirstResponder];
             [self movebackView];
      }
    
}

-(void)loginProcedure
{
    if ([UserName_Field.text length]>0 && [Password_Field.text length]>0) {
        [[RequestPackage shareObject]LoginWithUsername:UserName_Field.text andPassword:Password_Field.text];
    }
    else
    {
        RTAlertView *alert=[[RTAlertView alloc]initWithTitle:@"错误" message:@"用户名或密码不完整" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        errorID=1;
        [alert show];
    }
    
}

-(void)signupProcedure
{
    if ([UserName_Field.text length]>0 && [Password_Field.text length]>0 && [Confirm_Field.text length]>0) {
        
        if ([Confirm_Field.text isEqualToString:Password_Field.text]) {
            [[RequestPackage shareObject]SignUpWithUsername:UserName_Field.text andPassword:Password_Field.text];
        }else
        {
            RTAlertView *alert=[[RTAlertView alloc]initWithTitle:@"错误" message:@"确认密码与密码不一致" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
            errorID=2;
            [alert show];
        }
    }
    else
    {
        RTAlertView *alert=[[RTAlertView alloc]initWithTitle:@"错误" message:@"用户名或密码不完整" delegate:self cancelButtonTitle:@"好的" otherButtonTitles:nil];
        errorID=1;
        [alert show];
    }
    
}



-(void)alertView:(RTAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (errorID==1) {
        if ([UserName_Field.text length]<=0) {
            [UserName_Field becomeFirstResponder];
        }else
            if ([Password_Field.text length]<=0) {
                [Password_Field becomeFirstResponder];
            }else
            {
                [Confirm_Field becomeFirstResponder];
            }
    }else
    if (errorID==2)
    {
        Confirm_Field.text=@"";
        [Confirm_Field becomeFirstResponder];
    }
    
    errorID=0;
}

-(void)moveViewto:(CGRect)frame
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame=CGRectMake(0, -216-(-self.view.frame.size.height+frame.origin.y+frame.size.height+20), self.view.frame.size.width, self.view.frame.size.height);
    }];
}
-(void)movebackView
{
    [UIView animateWithDuration:0.3f animations:^{
        self.view.frame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)signUp_action
{
    
    if (needSignUp) {
        [self.view addSubview:Confirm_Field];
        Confirm_Field.frame=CGRectMake(self.view.frame.size.width*0.15, self.view.frame.size.height*0.65, self.view.frame.size.width*0.7, 44);
        Confirm_Field.alpha=0;
        [UIView animateWithDuration:0.3f animations:^{
            Confirm_Field.alpha=1;
            bigButton.frame=CGRectOffset(bigButton.frame, 0, 60);
            SignUp.frame=CGRectOffset(SignUp.frame, 0, 60);
        }];
        needSignUp=!needSignUp;
        Password_Field.returnKeyType=UIReturnKeyNext;
        [SignUp setTitle:@"已有账号?" forState:UIControlStateNormal];
        [SignUp setTitle:@"已有账号?" forState:UIControlStateHighlighted];
        [bigButton setTitle:@"注册" forState:UIControlStateNormal];
        [bigButton setTitle:@"注册" forState:UIControlStateHighlighted];

    }else
    {
        Confirm_Field.alpha=1;
        [UIView animateWithDuration:0.3f animations:^{
            Confirm_Field.alpha=0;
            bigButton.frame=CGRectOffset(bigButton.frame, 0, -60);
            SignUp.frame=CGRectOffset(SignUp.frame, 0, -60);
        }];
        needSignUp=!needSignUp;
        [Confirm_Field removeFromSuperview];
        Password_Field.returnKeyType=UIReturnKeyDone;
        [SignUp setTitle:@"没有账号?" forState:UIControlStateNormal];
        [SignUp setTitle:@"没有账号?" forState:UIControlStateHighlighted];
        [bigButton setTitle:@"登录" forState:UIControlStateNormal];
        [bigButton setTitle:@"登录" forState:UIControlStateHighlighted];
    }

}

-(void)handleBigButton
{
    if (needSignUp) {
        [self loginProcedure];
    }else
    {
        [self signupProcedure];
    }
    
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
