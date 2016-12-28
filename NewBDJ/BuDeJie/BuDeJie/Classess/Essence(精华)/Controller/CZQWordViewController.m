//
//  CZQWordViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/12/2.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQWordViewController.h"

@interface CZQWordViewController ()

@end

@implementation CZQWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置tableView的contentInset，使tableView全屏穿透效果并且能够展示首位所有内容并且不会弹回
    //顶部为基础20+44+TitleView的35 == 99  底部为tabBar的高度49
    self.tableView.contentInset = UIEdgeInsetsMake(CZQTitleViewH, 0, CZQTabBarH + CZQContentInsetH, 0);
    //*********设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //********添加监听CZQTabBarButtonDidRepeatClickNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:CZQTabBarButtonDidRepeatClickNotification object:nil];
    //**********添加监听CZQTitleButtonDidRepeatClickNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:CZQTitleButtonDidRepeatClickNotification object:nil];
}

//**********监听事件CZQTabBarButtonDidRepeatClickNotification
- (void)tabBarButtonDidRepeatClick{
    //如果重复点击的按钮不是精华按钮则返回，不刷新 ,*****************因为点击其他按钮的时候当前控制器会被暂时移除keyWindow
    if (self.view.window == nil) return;
    //如果精华页面显示的不是当前控制器的View返回，不刷新, **********因为如果精华当前显示的控制器view为当前控制器的view，只有当前控制器的view的scrollsToTop为YES
    if (self.tableView.scrollsToTop == NO) return;
    //排除上面两种可能后才能判断当前点击了精华按钮，并且显示的是当前控制器的View
    NSLog(@"CZQWordViewController监听了CZQTabBarButtonDidRepeatClickNotification点击------执行刷新");
}

//***********监听事件CZQTitleButtonDidRepeatClickNotification
- (void)titleButtonDidRepeatClick{
    //如果重复点击的按钮不是精华按钮则返回，不刷新 ,*****************因为点击其他按钮的时候当前控制器会被暂时移除keyWindow
    if (self.view.window == nil) return;
    //如果精华页面显示的不是当前控制器的View返回，不刷新, **********因为如果精华当前显示的控制器view为当前控制器的view，只有当前控制器的view的scrollsToTop为YES
    if (self.tableView.scrollsToTop == NO) return;
    //排除上面两种可能后才能判断当前点击了精华按钮，并且显示的是当前控制器的View
    NSLog(@"CZQWordViewController监听了CZQTitleButtonDidRepeatClickNotification点击------执行刷新");
}

//移除监听
- (void)dealloc{
    //移除CZQAllViewController的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 数据源
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@-%zd", self.class, indexPath.row];
    return cell;
}


@end
