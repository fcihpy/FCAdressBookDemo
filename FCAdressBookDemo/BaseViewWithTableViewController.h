//
//  BaseViewWithTableViewController.h
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/22.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  获取屏幕宽高
 */
#define mScreenH [UIScreen mainScreen].bounds.size.height
#define mScreenW [UIScreen mainScreen].bounds.size.width


@interface BaseViewWithTableViewController : UIViewController


@property (nonatomic,copy) UITableView *tableView;

@property (nonatomic,strong) NSArray *cellModelArry;

/**
 *  根据每个section内容返回A-Z字母的索引数组
 *

 */

- (NSArray *)getSectionTitileArry;


@end
