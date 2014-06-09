//
//  NoReadCell.m
//  Peanut_Mark1
//
//  Created by Grayon on 14-5-29.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "NoReadCell.h"

@implementation NoReadCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        UILabel *noreadlabel = [[UILabel alloc] init];
        noreadlabel.frame = CGRectMake(0, 0, self.contentView.frame.size.width, 30);
        noreadlabel.text = @"今天没有必读信息";
        noreadlabel.textAlignment = NSTextAlignmentCenter;
        noreadlabel.textColor = [UIColor grayColor];
        noreadlabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:noreadlabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame
{
    frame.origin.x += 15;
    frame.size.width -= 2 * 15;
    [super setFrame:frame];
}

@end
