//
//  CZQFriendThrendsViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/21.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQFriendThrendsViewController.h"
#import "CZQRegisterAndLoginViewController.h"

@interface CZQFriendThrendsViewController ()

@end

@implementation CZQFriendThrendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    //设置导航条
    [self setUpNavBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//监听登录按钮点击 modal效果
- (IBAction)reginAndLoginBtnClick {
    CZQRegisterAndLoginViewController *reginAndLoginVC = [[CZQRegisterAndLoginViewController alloc] init];
    //跳转至注册登录界面 modal效果
    [self presentViewController:reginAndLoginVC animated:YES completion:nil];
}


#pragma mark - 设置导航条
- (void)setUpNavBar{
    //左边按钮
    UIImage *leftNorImage = [UIImage imageNamed:@"friendsRecommentIcon"];
    UIImage *leftHighImage = [UIImage imageNamed:@"friendsRecommentIcon-click"];
    //调用UIBarButtonItem分类直接生成需要的buttonItem
    UIBarButtonItem *leftBtnItem = [UIBarButtonItem itemWithNorImage:leftNorImage highImage:leftHighImage target:self action:@selector(friendThrendsLeftBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    //中间文字
    self.navigationItem.title = @"我的关注";
    
    
}

- (void)friendThrendsLeftBtnClick{
    NSLog(@"friendThrendsLeftBtnClick");
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
