//
//  MustReaddetialViewController.m
//  Peanut_Mark1
//
//  Created by Grayon on 14-5-16.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "MustReaddetialViewController.h"
@interface MustReaddetialViewController ()
@property (nonatomic,retain) UIImageView *picture;
@property (nonatomic,retain) UIView *mask;
@property (nonatomic,retain) UIImageView *avatar;
@property (nonatomic,retain) UILabel *atitle;
@property (nonatomic,retain) UILabel *user;
@property (nonatomic,retain) UIButton *like;
@property (nonatomic,retain) UIButton *comment;
@property (nonatomic,retain) UITextView *content;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"title";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.content];
    [_content setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[_content]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_content)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[_content]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_content)]];
    
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

- (UIImageView *)picture
{
    if (!_picture) {
        _picture = [[UIImageView alloc] init];
        _picture.frame = CGRectMake(0, 0, self.view.bounds.size.width, 255);
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
        [_mask setBackgroundColor:[UIColor blackColor]];
        [_mask setAlpha:0.8];
        
        [_mask addSubview:self.atitle];
        [_mask addSubview:self.avatar];
        [_mask addSubview:self.user];
        [_mask addSubview:self.like];
        [_mask addSubview:self.comment];
        
        [_atitle setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_atitle]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_atitle)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-6-[_atitle(25)]|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_atitle)]];
        
        [_avatar setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[_avatar(12)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        [_mask addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_avatar(12)]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_avatar)]];
        
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
        _atitle.text = @"MustRead";
        _atitle.textColor = [UIColor whiteColor];
        _atitle.font = [UIFont systemFontOfSize:15];
    }
    return _atitle;
}

- (UIImageView *)avatar
{
    if (!_avatar) {
        _avatar = [[UIImageView alloc] init];
        _avatar.image = nil;
        _avatar.layer.masksToBounds = YES;
        _avatar.layer.cornerRadius = 6.0;
        _avatar.backgroundColor = [UIColor blueColor];
    }
    return _avatar;
}


- (UILabel *)user
{
    if (!_user) {
        _user = [[UILabel alloc] init];
        _user.text = @"ZAKER";
        _user.textColor = [UIColor whiteColor];
        _user.font = [UIFont systemFontOfSize:12];
    }
    return _user;
}

- (UIButton *)like
{
    if (!_like) {
        _like = [[UIButton alloc] init];
        [_like setTitle:@"100" forState:UIControlStateNormal];
        [_like setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_like.titleLabel setFont:[UIFont systemFontOfSize:10]];
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
        [_comment setTitle:@"33" forState:UIControlStateNormal];
        [_comment setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_comment.titleLabel setFont:[UIFont systemFontOfSize:10]];
        [_comment setImage:[UIImage imageNamed:@"comment.png"] forState:UIControlStateNormal];
        [_comment setImageEdgeInsets:UIEdgeInsetsMake(0, -6, 0, 0)];
        _comment.backgroundColor = [UIColor clearColor];
    }
    return _comment;
}

- (UITextView *)content
{
    if (!_content) {
        _content = [[UITextView alloc] init];
        [_content addSubview:self.picture];
        //        _content.frame = CGRectMake(0, 255, self.view.bounds.size.width, 0);
        _content.textColor = [UIColor blackColor];
        _content.font = [UIFont systemFontOfSize:12];
        //        _content.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
        _content.backgroundColor = [UIColor clearColor];
        _content.textContainerInset = UIEdgeInsetsMake(265, 10, 10, 10);
        //        _content.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [_content setEditable:NO];
        _content.text = @"      985本科大二，计算机专业，为什么很多普通一本甚至二本三本的都比自己懂得多？升入大学后，大家似乎站在同一起跑线上了，有的专科的学生对计算机感兴趣或者其他原因，当他们聊着MFC，API，OS（大三才开，至今不知OS是个什么概念），UI的时候，有的我从来没听过，因为课上不教，突然有一种很强的危机感，这样下去，难道辛辛苦苦上的985就业时还比不上人家专科吗？小伙子，你搞反了。那些二本三本的学计算机的学生，他们可能并不是因为智商才只能上二本三本。他们可能是因为在高中的时候，把很多时间用来玩游戏、拆电脑、玩编程、看杂书……所以才没有考上985本科的。高中的数理化学得再好，到了计算机专业里，有个毛关系呢？忠言逆耳，至少在我眼里，我压根不知道985都有哪些学校，我只知道如果有靠谱的项目或者实习经验，哪怕是新东方厨师学校的本科，我也认。我是读三本的，我原来是学跟计算机八竿子打不着的，我现在写代码。大学的时候，买的最厚的一本书是UNIX in a nutshell。空闲的时候读了五六遍。啃手册之类的，算是个笨方法。懂得多分两面：广度和深度。计算机的书籍里面，很多书都值得当小说看，看书少，别人才能骗你。公关：在2011年之前，腾讯在公关方面确实非常的弱。可能这本身跟CEO的个人风格有关…马云，周鸿祎，刘强东，这些人如果说看气场估计看起来要领先马先生几条街。腾讯从一开始就背上了抄袭的名字，直到现在还没逃脱，因此公关做得真的差。但进来腾讯似乎意识到了这一点，从2011年微信开始发展，腾讯就加大了公关力度。把张小龙和微信都包装成一个传奇。而反观公关非常强的阿里和360，阿里屡陷公关危机，马云的主教权威开始受到质疑，越来越多人不吃马云那一套。360更是成为众矢之的，我身边很多人都莫名地讨厌360。反而是马化腾相对低调地性格使腾讯在舆论方面一直比较稳定。而且可以看出近来舆论对腾讯的评价也越来越正面。随着乔布斯去世，人们最终要面对一个此前模糊不清的问题：究竟是什么终止了乔布斯的生命？从医理上讲，2003 年乔布斯所检查出的，只是一个相当温和的胰岛细胞肿瘤。可之后的八年中，他先后切除了胰脏和部分十二指肠、移植了肝脏、减去了几十斤的体重，最终却仍未能逃离死神的黑翼。在医疗发达的今天，美国人平均年龄为 76 岁，仅 56 岁就辞世的乔布斯可谓早逝。越来越多的癌症医生在各种场合指出：如果乔布斯正常就诊，结局不会如此。而在沃尔特·艾萨克森那本基于五十次对乔布斯的独家专访而写成的传记中，这种猜测得到了验证。艾萨克森在书中写到，确诊后，乔布斯不听任何家人好友的劝诫，一意孤行地为自己制定了食疗计划，甚至尝试吃马粪、请灵媒等离奇的手段，直到九个月后，他的肿瘤恶化，变得不可治愈。历史不容假设。“保护公平工资”动议又称“限定最低工资”动议,发起方要求瑞士联邦与各州推行工资保护政策,将每小时22瑞士法郎(1美元约合0.89瑞士法郎)的最低工资标准纳入法律。瑞士全职劳动者每周平均工作时间为42小时,若该动议得以通过,瑞士劳动者每月最低工资将达到约4000瑞士法郎。该动议发起方称,这项动议关乎社会公平。反对该动议的瑞士人担心,若实行这一最低工资标准,生产成本将上升,一些企业可能因丧失竞争力而裁员或迁往经营成本更低的国家。985本科大二，计算机专业，为什么很多普通一本甚至二本三本的都比自己懂得多？升入大学后，大家似乎站在同一起跑线上了，有的专科的学生对计算机感兴趣或者其他原因，当他们聊着MFC，API，OS（大三才开，至今不知OS是个什么概念），UI的时候，有的我从来没听过，因为课上不教，突然有一种很强的危机感，这样下去，难道辛辛苦苦上的985就业时还比不上人家专科吗？小伙子，你搞反了。那些二本三本的学计算机的学生，他们可能并不是因为智商才只能上二本三本。他们可能是因为在高中的时候，把很多时间用来玩游戏、拆电脑、玩编程、看杂书……所以才没有考上985本科的。高中的数理化学得再好，到了计算机专业里，有个毛关系呢？忠言逆耳，至少在我眼里，我压根不知道985都有哪些学校，我只知道如果有靠谱的项目或者实习经验，哪怕是新东方厨师学校的本科，我也认。我是读三本的，我原来是学跟计算机八竿子打不着的，我现在写代码。大学的时候，买的最厚的一本书是UNIX in a nutshell。空闲的时候读了五六遍。啃手册之类的，算是个笨方法。懂得多分两面：广度和深度。计算机的书籍里面，很多书都值得当小说看，看书少，别人才能骗你。公关：在2011年之前，腾讯在公关方面确实非常的弱。可能这本身跟CEO的个人风格有关…马云，周鸿祎，刘强东，这些人如果说看气场估计看起来要领先马先生几条街。腾讯从一开始就背上了抄袭的名字，直到现在还没逃脱，因此公关做得真的差。但进来腾讯似乎意识到了这一点，从2011年微信开始发展，腾讯就加大了公关力度。把张小龙和微信都包装成一个传奇。而反观公关非常强的阿里和360，阿里屡陷公关危机，马云的主教权威开始受到质疑，越来越多人不吃马云那一套。360更是成为众矢之的，我身边很多人都莫名地讨厌360。反而是马化腾相对低调地性格使腾讯在舆论方面一直比较稳定。而且可以看出近来舆论对腾讯的评价也越来越正面。随着乔布斯去世，人们最终要面对一个此前模糊不清的问题：究竟是什么终止了乔布斯的生命？从医理上讲，2003 年乔布斯所检查出的，只是一个相当温和的胰岛细胞肿瘤。可之后的八年中，他先后切除了胰脏和部分十二指肠、移植了肝脏、减去了几十斤的体重，最终却仍未能逃离死神的黑翼。在医疗发达的今天，美国人平均年龄为 76 岁，仅 56 岁就辞世的乔布斯可谓早逝。越来越多的癌症医生在各种场合指出：如果乔布斯正常就诊，结局不会如此。而在沃尔特·艾萨克森那本基于五十次对乔布斯的独家专访而写成的传记中，这种猜测得到了验证。艾萨克森在书中写到，确诊后，乔布斯不听任何家人好友的劝诫，一意孤行地为自己制定了食疗计划，甚至尝试吃马粪、请灵媒等离奇的手段，直到九个月后，他的肿瘤恶化，变得不可治愈。历史不容假设。“保护公平工资”动议又称“限定最低工资”动议,发起方要求瑞士联邦与各州推行工资保护政策,将每小时22瑞士法郎(1美元约合0.89瑞士法郎)的最低工资标准纳入法律。瑞士全职劳动者每周平均工作时间为42小时,若该动议得以通过,瑞士劳动者每月最低工资将达到约4000瑞士法郎。该动议发起方称,这项动议关乎社会公平。反对该动议的瑞士人担心,若实行这一最低工资标准,生产成本将上升,一些企业可能因丧失竞争力而裁员或迁往经营成本更低的国家。";
    }
    return _content;
}

@end
