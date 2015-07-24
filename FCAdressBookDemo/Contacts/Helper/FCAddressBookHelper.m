//
//  FCAddressBookHelper.m
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/22.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "FCAddressBookHelper.h"

#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import "AddressModel.h"

#import "ChineseToPinyin.h"


@implementation FCAddressBookHelper


#pragma mark - 读取手机通讯录
static void readAddressBookContacts(ABAddressBookRef addressBook, void (^completion)(NSArray *contacts)) {
    
    NSArray *contacts = (__bridge NSArray *)(ABAddressBookCopyArrayOfAllPeople(addressBook));
    
    completion(contacts);
    
}


#pragma mark 获取手机通讯录权限
+ (BOOL)checkAddressBookAuthorizationStatus{
    
    //记录通讯录的访问权限
    BOOL __block authStaus;
    
    CFErrorRef error;
    
    //获取通讯录句柄
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    //创建一个事件信号
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    
    //申请获取通讯录访问权限
    ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
        
        authStaus = granted;
        
        //发送一次信号
        dispatch_semaphore_signal(sema);
 
    });
    
    //等待信息触发
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);

return authStaus ;

}

#pragma mark -获取所有联系人原始信息
+ (void)fetchAllOriginContactsWithComplation:(dataArryBock)complation{
    
    CFErrorRef error;
    
    //获取通讯录句柄
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
    
    if ([self checkAddressBookAuthorizationStatus]) {
        
        readAddressBookContacts(addressBook, complation);
    }
    
}

#pragma mark 将联系人原始信息转换为Model
+ (void)transportOriginToModelWithSuccess:(dataArryBock)success failure:(failureBlock)failure{
    
    //初始化一个数组，用于存放Model对象
    NSMutableArray *modelArry = [NSMutableArray array];
    
    
    [self fetchAllOriginContactsWithComplation:^(NSArray *contacts) {
        
        //取出每个人的通讯录信息
        [contacts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            
            AddressModel *model = [[AddressModel alloc]init];
            
            //获取的联系人单一属性:FirstName
            NSString *firstName = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonFirstNameProperty);
            
            //获取的联系人单一属性:LastName
            NSString *lastName = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonLastNameProperty);
            if (!firstName) {
                firstName = @"";
            }
            NSString *fullName = [NSString stringWithFormat:@"%@%@",lastName,firstName];
            model.name = fullName;
            
            //获取的联系人单一属性:NickName
            NSString *nickName = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonNicknameProperty);
            
            //获取的联系人单一属性:phoneNumber
            ABMultiValueRef tmpPhones= ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonPhoneProperty);
            NSString *mobile = (__bridge NSString *)ABMultiValueCopyValueAtIndex(tmpPhones, 0);
            
            model.mobile = mobile;
            
            //获取的联系人单一属性:CompanyName
            NSString *companyName = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonOrganizationProperty);
            
            //获取的联系人单一属性:Job Title
            NSString *jobTitle = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonJobTitleProperty);
            
            //获取的联系人单一属性:Department Name
            NSString *department = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonDepartmentProperty);
            
            //获取的联系人单一属性:Email
            ABMultiValueRef temEmails = ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonEmailProperty);
            NSString* tmpEmailIndex = (__bridge NSString*)ABMultiValueCopyValueAtIndex(temEmails, 0);
            
            //获取的联系人单一属性:Birthday
            NSString *birthday = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonBirthdayProperty);
            
            //获取的联系人单一属性:Note
            NSString *note = (__bridge NSString *)ABRecordCopyValue((__bridge ABRecordRef)(obj), kABPersonNoteProperty);
            
            //获取的联系人单一属性:头像
            NSData *image = (__bridge NSData *)ABPersonCopyImageData((__bridge ABRecordRef)(obj));
            
            
            [modelArry addObject:model];
 
        }];
 
    }];
 
    if (success) {
        success(modelArry);
    }
 
}


#pragma mark - 对联系人进行分组排序
+ (void)fetchContactsWithSuccess:(dataArryBock)success failure:(failureBlock)failure{
    
    
    //建立索引的核心，生成a-z，#等索引字段
    UILocalizedIndexedCollation *indexCollation = [UILocalizedIndexedCollation currentCollation];
    
    NSMutableArray *indexCollectionArry = [NSMutableArray arrayWithArray:[indexCollation sectionIndexTitles]];
    
    //返回section的个数,a-z#共27个
    NSUInteger  sectionCount = indexCollectionArry.count;
    
    //创建一个数量为sectionCount的SectionArry;
    NSMutableArray *sectionArry = [NSMutableArray arrayWithCapacity:sectionCount];
    
    //在每个section数组中，创建一个内容为1的数组
    for (int i = 0; i < sectionCount; i ++) {
        
        NSMutableArray *rowArry = [NSMutableArray arrayWithCapacity:1];
        
        [sectionArry addObject:rowArry];
        
    }
    
    [self transportOriginToModelWithSuccess:^(NSArray *contacts) {
        
        for (int i = 0; i < contacts.count ; i ++) {
            
            //从联系数组中取出每一个联系人
            AddressModel *person = contacts[i];
            
            NSString *fullName = person.name;
            
            
            NSString *firstLetter = [ChineseToPinyin pinyinFromChiniseString:fullName];
            
            NSInteger sectionID = 0;
            
            if (firstLetter) {
                
                //根据转换后的名字的首字母，得出在section（外层）数组中的索引位置
                sectionID = [indexCollation sectionForObject:[firstLetter substringToIndex:1] collationStringSelector:@selector(uppercaseString)];
                
            }else{
                sectionID  = 27;
            }
            
            
            //根据有索引的位置，取出外层对应索引位置的数据，并将内容存入数组
            NSMutableArray *temArry = sectionArry[sectionID];
            AddressModel *model = [[AddressModel alloc]init];
            model.name = fullName;
            model.mobile = person.mobile;
            
            [temArry addObject:model];
        }
        
        
        if (success) {
            success(sectionArry);
        }
        
        
    } failure:^(NSError *error) {
        
    }];
    
    
}



@end





