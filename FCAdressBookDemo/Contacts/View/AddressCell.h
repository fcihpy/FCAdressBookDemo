//
//  AddressCell.h
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/23.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "BaseCell.h"

#define kFont11 [UIFont systemFontOfSize:11]
#define kFont12 [UIFont systemFontOfSize:12]
#define kFont13 [UIFont systemFontOfSize:13]
#define kFont14 [UIFont systemFontOfSize:14]
#define kFont15 [UIFont systemFontOfSize:15]
#define kFont17 [UIFont systemFontOfSize:17]

#define kButtonPreColor COLOR(7, 184, 136, 1)



@interface AddressCell : BaseCell



@property (nonatomic,assign) NSIndexPath *indexPath;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;



@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;


@property (weak, nonatomic) IBOutlet UIButton *statusButton;

- (IBAction)statusButton:(UIButton *)sender;

@end
