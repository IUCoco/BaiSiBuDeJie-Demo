//
//  CZQNavigationViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/23.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQNavigationViewController.h"

@interface CZQNavigationViewController ()<UIGestureRecognizerDelegate>

@end

@implementation CZQNavigationViewController

+ (void)load{
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[CZQNavigationViewController class]]];
    //设置字体大小
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    navBar.titleTextAttributes = attr;
    //设置背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"navigationbarBackgroundWhite"] forBarMetrics:UIBarMetricsDefault];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 恢复滑动返回功能 -> 分析:把系统的返回按钮覆盖 -> 1.手势失效(1.手势被清空 2.可能手势代理做了一些事情,导致手势失效) 事实证明代理做了一些事使其失效，解决办法从新设置代理shouldReceiveTouch使其滑动恢复，
    //设置手势代理 左滑动
    self.interactivePopGestureRecognizer.delegate = self;
    //UIScreenEdgePanGestureRecognizer:导航滑动手势

}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (self.childViewControllers.count > 0) {//非根控制器才添加返回按钮
        //隐藏底部导航栏
        viewController.hidesBottomBarWhenPushed = YES;
        //设置左边返回按钮
        UIImage *norImage = [UIImage imageNamed:@"navigationButtonReturn"];
        UIImage *hightImage = [UIImage imageNamed:@"navigationButtonReturnClick"];
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem itemBackWithNorImage:norImage highImage:hightImage target:self action:@selector(setBtnClick) title:@"返回"];
    }
    
    //父类方法
    [super pushViewController:viewController animated:animated];
}

- (void)setBtnClick{
    [self popViewControllerAnimated:YES];
}

#pragma mark - UIGestureRecognizerDelegate
//设置代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    return self.childViewControllers.count > 1;//非根控制器才实现左侧滑动
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
