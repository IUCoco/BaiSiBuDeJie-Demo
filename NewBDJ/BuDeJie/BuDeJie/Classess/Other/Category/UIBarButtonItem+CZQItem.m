//
//  UIBarButtonItem+CZQItem.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/23.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "UIBarButtonItem+CZQItem.h"

@implementation UIBarButtonItem (CZQItem)

//高亮
+ (UIBarButtonItem *)itemWithNorImage:(UIImage *)norImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:norImage forState:UIControlStateNormal];
    [btn setBackgroundImage:highImage forState:UIControlStateHighlighted];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //使用UIView包装Button，然后使用UIBarButtonItem包装UIView，防止UIBarButtonItem直接包装Button导致可触摸面积扩大
    UIView *packView = [[UIView alloc] initWithFrame:btn.bounds];
    [packView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:packView];
}

//选中
+ (UIBarButtonItem *)itemWithNorImage:(UIImage *)norImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:norImage forState:UIControlStateNormal];
    [btn setBackgroundImage:selImage forState:UIControlStateSelected];
    [btn sizeToFit];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //使用UIView包装Button，然后使用UIBarButtonItem包装UIView，防止UIBarButtonItem直接包装Button导致可触摸面积扩大
    UIView *packView = [[UIView alloc] initWithFrame:btn.bounds];
    [packView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:packView];


}

//setting返回按钮设置
+ (UIBarButtonItem *)itemBackWithNorImage:(UIImage *)norImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:norImage forState:UIControlStateNormal];
    [btn setImage:highImage forState:UIControlStateHighlighted];
    //设置正常状态下的颜色
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //设置高亮状态下的颜色
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [btn sizeToFit];
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, - 10, 0, 0);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    //使用UIView包装Button，然后使用UIBarButtonItem包装UIView，防止UIBarButtonItem直接包装Button导致可触摸面积扩大
    UIView *packView = [[UIView alloc] initWithFrame:btn.bounds];
    [packView addSubview:btn];
    return [[UIBarButtonItem alloc] initWithCustomView:packView];
}


@end
