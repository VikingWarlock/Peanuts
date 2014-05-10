//
//  BlurAndSlide_TableViewCell.m
//  Peanut_Mark1
//
//  Created by viking warlock on 5/10/14.
//  Copyright (c) 2014 viking warlock. All rights reserved.
//

#import "BlurAndSlide_TableViewCell.h"
#import <UIImage+BlurAndDarken.h>
#import "UIImage+extra.h"

@implementation BlurAndSlide_TableViewCell
/*
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}
*/


-(id)initWithBackImage:(UIImage *)bkImage AtIndexpath:(NSIndexPath *)indexpath AndInitPosition:(Cell_Init_Direction)position AndDelegate:(id<Delegate_BlurCellSlide>)delegate
{
    self=[super init];
    
    self.indexpath=indexpath;
    self.image=[bkImage copy];
    self.Delegate_Blur=delegate;
    
    
    

    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
