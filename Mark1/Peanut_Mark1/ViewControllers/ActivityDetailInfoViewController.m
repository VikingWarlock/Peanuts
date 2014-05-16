//
//  ActivityDetailInfoViewController.m
//  Peanut_Mark1
//
//  Created by 张众 on 5/16/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "ActivityDetailInfoViewController.h"
#import "Mask.h"

@interface ActivityDetailInfoViewController ()
@property (nonatomic,strong) Mask *mask;
@property (nonatomic,strong) UITextView *textView;
@end

@implementation ActivityDetailInfoViewController

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
    [self.view addSubview:self.mask];
    [self.view addSubview:self.textView];
    
    [_mask setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mask]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mask(57)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    
    [_textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_mask][_textView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask,_textView)]];
    
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

#pragma mark lazy initialization

- (Mask *)mask
{
    if (!_mask) {
        _mask = [[Mask alloc] init];
    }
    return _mask;
}

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.textColor = [UIColor whiteColor];
        _textView.font = [UIFont boldSystemFontOfSize:12];
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _textView.text = @"Will attempt to recover by breaking constraint<NSLayoutConstraint:0x14376a00 V:[UIImageView:0x14375c30]-(42.5)-|   (Names: '|':UITableViewCellContentView:0x143759d0 )>Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.2014-05-16 21:09:14.560 Peanut_Mark1[3701:60b] Unable to simultaneously satisfy constraints.Probably at least one of the constraints in the following list is one you don't want. Try this: (1) look at each constraint and try to figure out which you don't expect; (2) find the code that added the unwanted constraint or constraints and fix it. (Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints) Will attempt to recover by breaking constraint<NSLayoutConstraint:0x14376a00 V:[UIImageView:0x14375c30]-(42.5)-|   (Names: '|':UITableViewCellContentView:0x143759d0 )>Break on objc_exception_throw to catch this in the debugger.The methods in the UIConstraintBasedLayoutDebugging category on UIView listed in <UIKit/UIView.h> may also be helpful.2014-05-16 21:09:14.560 Peanut_Mark1[3701:60b] Unable to simultaneously satisfy constraints.Probably at least one of the constraints in the following list is one you don't want. Try this: (1) look at each constraint and try to figure out which you don't expect; (2) find the code that added the unwanted constraint or constraints and fix it. (Note: If you're seeing NSAutoresizingMaskLayoutConstraints that you don't understand, refer to the documentation for the UIView property translatesAutoresizingMaskIntoConstraints)";
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor blueColor];
    }
    return _textView;
}

@end
