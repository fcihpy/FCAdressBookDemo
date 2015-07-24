//
//  AddressController.m
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/22.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "AddressController.h"
#import "FCAddressBookHelper.h"
#import "AddressModel.h"
#import "AddressCell.h"



@interface AddressController ()

@end

@implementation AddressController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"通讯录";
    
    [self refreshData];

}


#pragma  mark -  -------------------------------View生命周期--------------------------

#pragma  mark -  -------------------------------基本设置------------------------------


#pragma  mark -  -------------------------------网络层处理----------------------------


- (void)refreshData{


    [FCAddressBookHelper fetchContactsWithSuccess:^(NSArray *contacts) {
        
        self.cellModelArry = contacts;
        [self.tableView reloadData];
        

        
    } failure:^(NSError *error) {
        
    }];
    
 
}



#pragma  mark -  -------------------------------事件处理------------------------------



#pragma  mark -  -------------------------------各Delegate--------------------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reuse = @"ios cell";
    AddressCell *cell = (AddressCell *)[tableView dequeueReusableCellWithIdentifier:reuse];
    
    if (cell == nil) {
        cell = [AddressCell cellShow];
    }
    
    AddressModel *model = self.cellModelArry[indexPath.section][indexPath.row];
    
    cell.nameLabel.text = model.name;
    cell.mobileLabel.text = model.mobile;
    
    cell.indexPath = indexPath;
    return cell;
}


#pragma mark  setion title
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    //获取A-Z，#的索引数组
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSArray *indexCollectionArry = [indexCollation sectionIndexTitles];
    
    //初始化一个数组，用于存放section中内容不为空的title索引
    NSMutableArray * existTitles = [NSMutableArray array];
    
    //section数组为空的title过滤掉，不显示
    for (int i = 0; i < [indexCollectionArry count]; i++) {
        
        if ([self.cellModelArry [i] count] > 0) {
            [existTitles addObject:indexCollectionArry [i]];
            
        }
    }
    
    return existTitles;
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    MyLog(@"23232 %d",index);
    //因为索引的前面加了个搜索小图标，所以需要重写这个方法点击的时候要返回的数要-1
    return index;
    
}


#pragma  mark  viewForHeader
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    UIView *contentView = [[UIView alloc] init];
    [contentView setBackgroundColor:COLOR(241, 241, 241, 1)];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 100, 22)];
    label.backgroundColor = [UIColor clearColor];


    label.text = [self getSectionTitileArry][section];
    
    
    [contentView addSubview:label];
    return contentView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([self.cellModelArry[section] count] == 0    ) {
        return 0.1;
        
    }else{
        return 30;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 60;
}



#pragma  mark -  -------------------------------setter/getter------------------------






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
