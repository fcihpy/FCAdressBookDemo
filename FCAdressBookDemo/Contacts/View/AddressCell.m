//
//  AddressCell.m
//  BaseProjectDemo
//
//  Created by zhisheshe on 15/7/23.
//  Copyright (c) 2015年 fcihpy. All rights reserved.
//

#import "AddressCell.h"

@implementation AddressCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

//- (void)setIndexPath:(NSIndexPath *)indexPath{
//    
//     NSLog(@"inde2222222xpath---%d--%d",self.indexPath.section,self.indexPath.row);
//}

- (void)awakeFromNib
{
    
    [self.statusButton setTitle:@"添加" forState:UIControlStateNormal];
    self.statusButton.titleLabel.font = kFont13;
    [self.statusButton setBackgroundColor:kButtonPreColor];
    [self.statusButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.statusButton.layer.cornerRadius = 3;
    self.statusButton.layer.masksToBounds = YES;
}


- (IBAction)statusButton:(UIButton *)sender {
    
    NSLog(@"indexpath---%d--%d",self.indexPath.section,self.indexPath.row);
}
@end
