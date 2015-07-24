//
//  AddressModel.h
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/22.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "BaseModel.h"

@interface AddressModel : BaseModel


@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *mobile;
@property (nonatomic,copy) NSString *nickName;
@property (nonatomic,copy) NSString *companyName;
@property (nonatomic,copy) NSString *jobTitle;
@property (nonatomic,copy) NSString *department;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *note;


@property (nonatomic) BOOL isFriend;


@end
