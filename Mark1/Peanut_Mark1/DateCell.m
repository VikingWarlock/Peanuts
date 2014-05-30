//
//  DateCell.m
//  Peanut_Mark1
//
//  Created by Grayon on 14-5-29.
//  Copyright (c) 2014年 viking warlock. All rights reserved.
//

#import "DateCell.h"

@implementation DateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.datelabel];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)datelabel
{
    if (!_datelabel) {
        _datelabel = [[UILabel alloc] init];
        _datelabel.frame = CGRectMake(15, 0, 100, 30);
        _datelabel.text = @"Loading";
        _datelabel.textAlignment = NSTextAlignmentLeft;
        _datelabel.textColor = [UIColor redColor];
        _datelabel.font = [UIFont systemFontOfSize:12];
    }
    return  _datelabel;
}

@end
