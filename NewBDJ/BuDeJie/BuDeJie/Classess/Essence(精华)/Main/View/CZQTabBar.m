//
//  CZQTabBar.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/22.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQTabBar.h"

@interface CZQTabBar ()

//发布按钮
@property (nonatomic, weak)UIButton *publishBtn;

//记录之前点击的tabBarButton
@property(nonatomic, weak)UIControl *previousTabBarButton;

@end

@implementation CZQTabBar


// 发布按钮懒加载
- (UIButton *)publishBtn{
    if (_publishBtn == nil) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                //设置按钮普通和高亮状态下的图片
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
                //按钮自适应
        [btn sizeToFit];
        //添加到自定义TabBar上面
        [self addSubview:btn];
         _publishBtn = btn;
    }
    return _publishBtn;
}



- (void)layoutSubviews{
    [super layoutSubviews];
    //跳转tabBar的位置
    NSInteger count = self.items.count + 1;
    CGFloat btnW = self.czq_with / count;
    CGFloat btnH = self.czq_hight;
    CGFloat btnX = 0;
    //布局tabBar
    NSInteger i = 0;
    //tabBarButton继承UIControl CZQLog(@"%@", tabBarButton.superclass);  2016-12-11 11:04:47.607 BuDeJie[3781:689525] UIControl
    for (UIControl *tabBarButton in self.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            //为防止首次进来的时候previousTabBarButton的值为nil，因为还没有调用tabBarButtonClick:方法。将第一个精华赋值
            if (i == 0 && self.previousTabBarButton == nil) {
                self.previousTabBarButton = tabBarButton;
            }
            //i==2的时候为自定义按钮
            if (i == 2) {
                i += 1;
            }
            btnX = btnW * i;
            tabBarButton.frame = CGRectMake(btnX, 0, btnW, btnH);
            i ++;
            
//            CZQLog(@"%@", tabBarButton.superclass);
            //**************添加tabBarButton的点击监听事件
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    //设置发布按钮的位置
    self.publishBtn.center = CGPointMake(self.czq_with * 0.5, self.czq_hight * 0.5);
    
}

//**************tabBarButton的点击监听事件
- (void)tabBarButtonClick:(UIControl *)tabBarButton{
    //如果两次点击的都是同一个按钮则执行刷新操作
    if (self.previousTabBarButton == tabBarButton) {
//        UIKeyboardWillHideNotification 仿照系统来为通知命名
        [[NSNotificationCenter defaultCenter] postNotificationName:CZQTabBarButtonDidRepeatClickNotification object:nil];
       CZQLog(@"双点击了%@", tabBarButton);
    }
    //如果两次点击的不是同一个按钮则对previousTabBarButton 进行重新赋值
    self.previousTabBarButton = tabBarButton;
    
}


@end
