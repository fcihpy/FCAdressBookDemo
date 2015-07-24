
//
//  BaseCell.m
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/22.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "BaseCell.h"

@implementation BaseCell

- (void)awakeFromNib {
    // Initialization code
}

+ (instancetype)cellShow{

    NSString *nibname = [NSString stringWithFormat:@"%@",[self class]];
    return [[NSBundle mainBundle] loadNibNamed:nibname owner:nil options:nil][0];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
