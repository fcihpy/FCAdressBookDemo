//
//  convertGB_BIG.h
//  myTest
//
//  Created by sffofn on 11-8-17.
//  Copyright 2011 keke.com. All rights reserved.
//

#import <Foundation/Foundation.h>


/*
 另一种待实现方式 by william
 基本原理
 由上述编码知识可知，字体的切换其实就是编码的切换
 GB2312<->Unicode<->BIG5
 这样一个流程，Unicode充当切换的桥梁。
 */



@interface convertGB_BIG : NSObject
{
	NSString*	_string_GB;
	NSString*	_string_BIG5;
}

-(NSString*)gbToBig5:(NSString*)srcString;
-(NSString*)big5ToGb:(NSString*)srcString;

@end
