//
//  FCAddressBookHelper.h
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/22.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^dataArryBock) (NSArray *contacts);
typedef void(^failureBlock)(NSError *error);

@interface FCAddressBookHelper : NSObject

/**
 *  读取手机通讯录，并进行索引、排序
 */
+ (void)fetchContactsWithSuccess:(dataArryBock)success failure:(failureBlock)failure;




@end
