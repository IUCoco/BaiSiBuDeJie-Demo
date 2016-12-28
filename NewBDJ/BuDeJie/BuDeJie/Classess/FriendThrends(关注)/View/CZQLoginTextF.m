//
//  CZQLoginTextF.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/28.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQLoginTextF.h"

@implementation CZQLoginTextF


- (void)awakeFromNib{
    [super awakeFromNib];
    //设置光标的颜色为白色
    self.tintColor = [UIColor whiteColor];
    //文本框编辑的时候，占位文字变成白色， 设置target
    [self addTarget:self action:@selector(textBeginEdit) forControlEvents:UIControlEventEditingDidBegin];
    [self addTarget:self action:@selector(textEndEdit) forControlEvents:UIControlEventEditingDidEnd];
    //初始化placeholder的文字染色
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];

    
}

//开始编辑
- (void)textBeginEdit{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
}

//结束或离开编辑
- (void)textEndEdit{
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
