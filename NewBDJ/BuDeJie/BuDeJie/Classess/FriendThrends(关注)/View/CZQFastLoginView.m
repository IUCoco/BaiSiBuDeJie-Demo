//
//  CZQFastLoginView.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/28.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQFastLoginView.h"

@implementation CZQFastLoginView

//快速创建FastLoginView
+ (instancetype)fastLoginView{
    return  [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:nil options:nil] firstObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
