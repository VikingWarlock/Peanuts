//
//  MustReaddetialViewController.m
//  Peanut_Mark1
//
//  Created by Grayon on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "MustReaddetialViewController.h"
@interface MustReaddetialViewController ()
{
    NSString *feed_id;
    NSDictionary *data;
    NSDictionary *userinfo;
    BOOL loading;
}
@end

@implementation MustReaddetialViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithFeedId:(NSString *)feedId
{
    self = [super init];
    if (self) {
        feed_id = feedId;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    loading = YES;
    self.title = @"Loading";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.content];
    [_content setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_content]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_content)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_content]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_content)]];
    if (self.picture.image == nil) {
        [self downLoadWithFeedId:feed_id];
    }
    //    [self.view addSubview:self.picture];
    //    [self.view addSubview:self.content];
    //
    //    [_picture setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_picture]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture(255)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture)]];
    //
    //    [_content setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_content]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_content)]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_picture][_content]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_picture,_content)]];
    //    UIScrollView *sv = [[UIScrollView alloc] init];
    //    sv.backgroundColor = [UIColor clearColor];
    //
    //    [sv addSubview:self.picture];
    //    [sv addSubview:self.content];
    //
    //    [self.view addSubview:sv];
    
    //    _content.frame = CGRectMake(0, 255, self.view.bounds.size.width, _content.contentSize.height);
    
    //    [sv setTranslatesAutoresizingMaskIntoConstraints:NO];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[sv]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sv)]];
    //    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[sv]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(sv)]];
    //    _content.frame = CGRectMake(0, 255, self.view.bounds.size.width, _content.contentSize.height);
    //    [sv setContentSize:CGSizeMake(self.view.bounds.size.width, 1500)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downLoadWithFeedId:(NSString *)feedId
{
    [NetworkManager POST:@"http://112.124.10.151:82/index.php?app=mobile&mod=Daily&act=daily" parameters:@{@"feed_id":[NSString stringWithFormat:@"%@",feedId]} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject valueForKey:@"info"] isEqualToString:@"success"])
        {
            NSLog(@"%@",feed_id);
//            NSLog(@"%@",responseObject);
            data = [responseObject valueForKey:@"data"];
            userinfo = [[responseObject valueForKey:@"data"] valueForKey:@"user_info"];
            [self.picture setImageWithURL:data[@"cover"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            [self setTitle:data[@"title"]];
            [self.atitle setText:data[@"title"]];
            [self.avatar setImageWithURL:userinfo[@"avatar_tiny"] placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            [self.user setText:userinfo[@"uname"]];
            [self.like setTitle:data[@"digg_count"] forState:UIControlStateNormal];
            [self.comment setTitle:data[@"comment_count"] forState:UIControlStateNormal];
            NSString *html = data[@"content"];
            NSString *imghtml = [html stringByReplacingOccurrencesOfString:@"class=\"post-img\">" withString:@"style=\"width:300px;\" class=\"post-img\">"];
            [self.content loadHTMLString:imghtml baseURL:nil];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (UIImageView *)picture
{
    if (!_picture) {
        _picture = [[UIImageView alloc] init];
        _picture.frame = CGRectMake(0, -255, self.view.bounds.size.width, 255);
        _picture.image = nil;
        _picture.clipsToBounds = YES;
        _picture.contentMode = UIViewContentModeScaleAspectFill;
        _picture.backgroundColor = [UIColor grayColor];
        [_picture addSubview:self.mask];
        
        [_mask setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_picture addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mask]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
        [_picture addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_mask(57)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    }
    return _picture;
}

- (UIView *)mask
{
    if(!_mask){
        _mask = [[UIView alloc] init];
        [_mask setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.6]];
//        [_mask setAlpha:0.8];
        
        [_mask addSubview:self.atitle];
        [_mask addSubview:self.avatar];
        [_mask addSubview:self.user];
        [_mask addSubview:self.like];
        [_mask addSubview:self.comment];
        
        [_atitle setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[_atitle]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_atitle)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_atitle(25)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_atitle)]];
        
        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_avatar(15)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(15)]-8-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        
        [_user setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_user attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeRight multiplier:1.0 constant:6 ]];
        
        [_comment setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_comment(30)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_comment)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_comment(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_comment)]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_comment attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        
        [_like setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_like(30)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_like)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_like(10)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_like)]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_like attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_avatar attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0 ]];
        [_mask addConstraint:[NSLayoutConstraint constraintWithItem:_like attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_comment attribute:NSLayoutAttributeLeft multiplier:1.0 constant:-6]];
        
    }
    return _mask;
}

- (UILabel *)atitle
{
    if (!_atitle) {
        _atitle = [[UILabel alloc] init];
        _atitle.text = @"Loading";
        _atitle.textColor = [UIColor whiteColor];
        _atitle.font = [UIFont boldSystemFontOfSize:15];
    }
    return _atitle;
}

- (UIImageView *)avatar
{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.image = nil;
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 7.5;
        _avatar.backgroundColor = [UIColor blueColor];
    }
    return _avatar;
}


- (UILabel *)user
{
    if (!_user) {
        _user = [[UILabel alloc] init];
        _user.text = @"Loading";
        _user.textColor = [UIColor whiteColor];
        _user.font = [UIFont boldSystemFontOfSize:12];
    }
    return _user;
}

- (UIButton *)like
{
    if (!_like) {
        _like = [[UIButton alloc] init];
        [_like setTitle:@"0" forState:UIControlStateNormal];
        [_like setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_like.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
        [_like setImage:[UIImage imageNamed:@"like.png"] forState:UIControlStateNormal];
        [_like setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
        _like.backgroundColor = [UIColor clearColor];
    }
    return _like;
}

- (UIButton *)comment
{
    if (!_comment) {
        _comment = [[UIButton alloc] init];
        [_comment setTitle:@"0" forState:UIControlStateNormal];
        [_comment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_comment.titleLabel setFont:[UIFont boldSystemFontOfSize:10]];
        [_comment setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        [_comment setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
        _comment.backgroundColor = [UIColor clearColor];
    }
    return _comment;
}

- (UIWebView *)content
{
    if (!_content) {
        _content = [[UIWebView alloc] init];
        _content.delegate = self;
        [_content.scrollView addSubview:self.picture];
        //        _content.frame = CGRectMake(0, 255, self.view.bounds.size.width, 0);
        //_content.textColor = [UIColor blackColor];
        //_content.font = [UIFont systemFontOfSize:12];
        //        _content.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _content.backgroundColor = [UIColor clearColor];
        //_content.textContainerInset = UIEdgeInsetsMake(265, 10, 10, 10);
        //        _content.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        //[_content setEditable:NO];
        //[_content setSelectable:NO];
        _content.scrollView.contentInset = UIEdgeInsetsMake(255, 0, 0, 0);
        //_content.scalesPageToFit = NO;
    }
    return _content;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    loading = NO;
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType {
    return loading;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //拦截网页图片  并修改图片大小
    [webView stringByEvaluatingJavaScriptFromString:
     @"var script = document.createElement('script');"
     "script.type = 'text/javascript';"
     "script.text = \"function ResizeImages() { "
     "var myimg,oldwidth,oldheight;"
     "var maxwidth=300;" //缩放系数
     "for(i=0;i <document.images.length;i++){"
     "myimg = document.images[i];"
//     "if(myimg.width > maxwidth){"
     "oldwidth = myimg.width;"
     "oldheight = myimg.height;"
     "myimg.style.width = maxwidth;"
     "myimg.style.height = oldheight * (maxwidth/oldwidth);"
     "myimg.width = maxwidth;"
     "myimg.height = oldheight * (maxwidth/oldwidth);"
//     "}"
     "}"
     "}\";"
     "document.getElementsByTagName('head')[0].appendChild(script);"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
    
    [_content.scrollView setContentSize:CGSizeMake(0, _content.scrollView.contentSize.height)];
}

@end
