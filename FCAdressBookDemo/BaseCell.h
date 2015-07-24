//
//  BaseCell.h
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/22.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  颜色定义
 */
#define COLOR(R, G, B, A)  [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@interface BaseCell : UITableViewCell


+ (instancetype)cellShow;


@end
