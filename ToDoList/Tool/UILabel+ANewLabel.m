//
//  UILabel+ANewLabel.m
//  ToDoList
//
//  Created by Jack on 16/2/11.
//  Copyright © 2016年 Jack. All rights reserved.
//

#import "UILabel+ANewLabel.h"

@implementation UILabel (ANewLabel)

+ (UILabel *)commonLabel:(CGFloat)fontSize{
    UILabel *label = [UILabel new];
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    return label;
}

@end
