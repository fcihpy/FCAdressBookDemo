//
//  BaseViewWithTableViewController.m
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/22.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "BaseViewWithTableViewController.h"
#import "AddressModel.h"

@interface BaseViewWithTableViewController ()<UITableViewDataSource,UITableViewDelegate>

{
    
    
}

@end

@implementation BaseViewWithTableViewController

- (void)loadView{
    
    [super loadView];
    
    [self initArgs];
    
    [self.view addSubview:self.tableView];
}


#pragma  mark -  -------------------------------View生命周期--------------------------

#pragma  mark -  -------------------------------基本设置------------------------------

- (void)initArgs{
    
    self.cellModelArry = [NSArray array];
}

#pragma  mark -  -------------------------------网络层处理----------------------------

#pragma  mark -  -------------------------------事件处理------------------------------


#pragma mark 根据每个section内容返回A-Z字母的索引数组
- (NSArray *)getSectionTitileArry{
    
    //获取A-Z，#的索引数组
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSArray *indexCollectionArry = [indexCollation sectionIndexTitles];
    
    //初始化一个数组，用于存放section中内容不为空的title索引
    NSMutableArray * existTitles = [NSMutableArray array];
    
    //section数组为空的title过滤掉，不显示
    for (int i = 0; i < [indexCollectionArry count]; i++) {
        
        if ([self.cellModelArry [i] count] > 0) {
            [existTitles addObject:indexCollectionArry [i]];
            
        }else{
            
            [existTitles addObject:@""];
        }
    }
    return existTitles;
}

#pragma  mark -  -------------------------------各Delegate--------------------------

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return  self.cellModelArry.count;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  [self.cellModelArry[section] count];
    
}


#pragma mark - -----------------Table view data source------------------



#pragma  mark  didSelectRow
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma  mark -  -------------------------------setter/getter------------------------

- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, 0, mScreenW, mScreenH);
//        _tableView.separatorStyle = UITableViewCellSeparatorSrtyleNone;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    
    return _tableView;
}


- (NSArray *)cellModelArry{
    
    if (!_cellModelArry) {
        _cellModelArry = [NSArray array];
    }
    return _cellModelArry;
}


@end
