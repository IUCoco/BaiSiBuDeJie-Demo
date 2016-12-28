//
//  CZQFastLoginButton.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/28.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQFastLoginButton.h"

@implementation CZQFastLoginButton

- (void)layoutSubviews{
    [super layoutSubviews];
    //设置图片位置
    self.imageView.czq_y = 0;
    self.imageView.czq_centerX = self.czq_with * 0.5;
    //设置文字位置
    self.titleLabel.czq_y = self.czq_hight - self.titleLabel.czq_hight;
    [self.titleLabel sizeToFit];
    self.titleLabel.czq_centerX = self.czq_with * 0.5;
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
