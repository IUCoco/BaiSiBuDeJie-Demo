//
//  CZQNewViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/21.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQNewViewController.h"
#import "CZQFllowViewController.h"

@interface CZQNewViewController ()

@end

@implementation CZQNewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    //设置导航条
    [self setUpNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 设置导航条
- (void)setUpNavBar{
    //左边按钮
    UIImage *leftNorImage = [UIImage imageNamed:@"MainTagSubIcon"];
    UIImage *leftHighImage = [UIImage imageNamed:@"MainTagSubIconClick"];
    //调用UIBarButtonItem分类直接生成需要的buttonItem
    UIBarButtonItem *leftBtnItem = [UIBarButtonItem itemWithNorImage:leftNorImage highImage:leftHighImage target:self action:@selector(newLeftBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    //中间图片
    UIImage *centerImage = [UIImage imageNamed:@"MainTitle"];
    UIImageView *centerImageView = [[UIImageView alloc] initWithImage:centerImage];
    self.navigationItem.titleView = centerImageView;
    
    
}

- (void)newLeftBtnClick{
    NSLog(@"newLeftBtnClick");
    //跳转至关注Follow控制器页面
    CZQFllowViewController *followVC = [[CZQFllowViewController alloc] init];
    NSLog(@"%@",self.navigationController);
    [self.navigationController pushViewController:followVC animated:YES];
    
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
