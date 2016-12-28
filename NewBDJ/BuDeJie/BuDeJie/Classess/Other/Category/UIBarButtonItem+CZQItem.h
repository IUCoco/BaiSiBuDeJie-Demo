//
//  UIBarButtonItem+CZQItem.h
//  BuDeJie
//
//  Created by 陈志强 on 16/11/23.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (CZQItem)

//高亮
+ (UIBarButtonItem *)itemWithNorImage:(UIImage *)norImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action;
//setting返回按钮设置
+ (UIBarButtonItem *)itemBackWithNorImage:(UIImage *)norImage highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title;
//选中
+ (UIBarButtonItem *)itemWithNorImage:(UIImage *)norImage selImage:(UIImage *)selImage target:(id)target action:(SEL)action;


@end
