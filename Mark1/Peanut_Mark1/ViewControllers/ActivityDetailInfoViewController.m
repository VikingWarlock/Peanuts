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
    [self setBackgroundImage:[UIImage imageNamed:@"pic.jpg"] andBlurEnable:YES];
    [self.view addSubview:self.mask];
    [self.view addSubview:self.textView];

    [_mask setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_mask]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_mask(57)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask)]];
    
    [_textView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_textView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_textView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_mask][_textView]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_mask,_textView)]];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.maximumLineHeight = 25;
    paragraphStyle.minimumLineHeight = 25;
    NSString *string = _textView.text;
    NSDictionary *ats = @{
                          NSFontAttributeName : [UIFont boldSystemFontOfSize:12],
                          NSForegroundColorAttributeName : [UIColor whiteColor],
                          NSParagraphStyleAttributeName : paragraphStyle,
                          };
    _textView.attributedText = [[NSAttributedString alloc] initWithString:string attributes:ats];
    ((UIViewController *)(self.navigationController.viewControllers)[[self.navigationController.viewControllers indexOfObject:self] - 1]).navigationItem.title = @"";

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
        _textView.text = @"        由教育部思想政治工作司指导，全国高校辅导员工作研究会和中国教育报主办，新华网和中国大学生在线提供网络支持的“第六届全国高校辅导员年度人物”评选活动，日前揭晓了10名年度人物和40名提名奖。代表电子科技大学参加本次评比的计算机科学与工程学院党委王纲副书记获得第六届全国高校辅导员年度人物提名奖，这也是本次评比中四川省高校唯一一位获奖的辅导员老师！在领导和同事眼中，他恪尽职守、不辞辛劳，只要是关于学生培养和成才的问题，他都会全身心的投入。新生迎新、年级大会、新生素质教育课堂、党课、班级成长报告会与指导、学生活动、寝室、课堂到处都可以看到他活跃的身影；对待同学，他无私奉献，幽默热情，用实际的行动感染着身边的每一个人，同事和同学们都亲切地称呼他为“纲哥”，是大家心中的偶像，同学们还把自己称作为“纲丝”；在学生培养上，他大胆细心，勇于创新，结合当代大学生特点，他不断创新学生培养方式与方法，创新学生管理，为同学们搭建成长的舞台，并取得了卓越的成效。桃李不言，下自成蹊。王纲老师用他的实干精神和实际行动关怀着身边每一位学生，同时也为学院培养了一支优秀实干的辅导员队伍。他用青春、热血、和智慧奉献于他所挚爱的事业，他不仅是同事们喜爱的好领导，更是最受学生喜爱的辅导员。在未来的日子里，他将继续用他的努力与热情，为同学们创造一片美好的蓝天。\nWorking Americans expect to retire at age 66, up from 63 in 2002, according to a recent Gallup poll. But most retirees don't stay on the job nearly that long.\nThe average retirement age among retirees is 62, Gallup found. And even retirement at age 62 is a recent development. The average retirement age has hovered around 60 for most of the past decade.Americans have two reasons in which they may project a later retirement year. One is financial, and they simply think they will need to work longer because there are fewer pensions, and now people may have a more psychologically positive view of work, says Frank Newport, editor-in-chief of Gallup poll. But a plan to work longer isn't the same as keeping a job into your mid- or late 60s.Other surveys have similarly found a significant gap between the age workers anticipate retiring and when they actually leave their jobs. A 2014 Employee Benefit Research Institute survey found that 33 percent of workers expect to retire after age 65, but only 16 percent of retirees report staying on the job that long. Just 9 percent of workers say they are planning to retire before age 60, but 35 percent of retirees say they retired that early. The median retirement age in the survey was 62.Many of these early retirements are unexpected and due to unforeseen circumstances. About half (49 percent) of retirees say they left the workforce earlier than planned, often to cope with a health problem or disability (61 percent) or to care for a spouse or other family member (18 percent), EBRI found. Other retirees are forced out of their jobs due to changes at their company, such as a downsizing or closure (18 percent), changes in the skills required for their job (7 percent) or other work-related reasons (22 percent).The difference is between what you know you want to do and what factors outside your control ultimately require you to do, says Dallas Salisbury, president of EBRI. I will tell you I want to continue working on the assumption that I can keep my job or get a new job, and then my job goes away because the plant closes down or something like that. Or I am very healthy when you ask me that question, and then I suddenly get pushed down a flight of stairs and end up disabled and out of work and on permanent disability for the balance of my life. You end up leaving long before you anticipated.Of course, there are also some fortunate retirees who are able to retire early because they can afford it (26 percent) or want to do something else (19 percent), perhaps due to an inheritance, unexpected windfall or diligent saving.An unplanned retirement generally means you need to regroup and make the best of the resources you have. When you're forced into it, the key thing is to be mentally flexible,says Michael Chadwick, a certified financial planner and CEO of Chadwick Financial Advisors in Unionville, Connecticut. The trajectory you were on when all was well isn't likely to be the same trajectory you're going to achieve with these new circumstances. You'll need to look at your severance package and ability to collect unemployment if you are laid off. And if you're under 65 and can't sign up for Medicare, you'll need to make important decisions about your health insurance.An emergency fund is likely to be extremely helpful to people who find themselves retiring ahead of schedule. You can have your ducks in a row by living below your means and saving well, so if something happens, you've got a cushion and are not desperate, Chadwick says. Try not to live paycheck to paycheck, and only carry good debt, such as mortgage, tuition and low-rate car loans.While you may want to keep working during the traditional retirement years to finance a better lifestyle, there's a reasonable possibility that you might not get to choose when you retire, and this should be factored into your retirement preparations. People would be much better off planning as if they will be unable to work in retirement,says Greg Burrows, senior vice president for retirement and investor services at Principal Financial Group, an underwriter of the EBRI survey. f they get to retirement and can work, then they have that option, and that's a bonus opportunity";
        _textView.editable = NO;
        _textView.backgroundColor = [UIColor clearColor];
        

    }
    return _textView;
}

@end
