//
//  CZQTabBarController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/21.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQTabBarController.h"
#import "CZQEssenceViewController.h"
#import "CZQFriendThrendsViewController.h"
#import "CZQMeViewController.h"
#import "CZQNewViewController.h"
#import "CZQPublishViewController.h"
#import "UIImage+CZQImage.h"
#import "CZQTabBar.h"
#import "CZQNavigationViewController.h"

@interface CZQTabBarController ()

@end

@implementation CZQTabBarController

//代码加载进内存时候调用，只调用一次
+ (void)load{
    //全局修改 appearance 制定修改
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[[CZQTabBarController class]]];
    //设置字体颜色，防止被渲染1
    NSMutableDictionary *attributesSel = [NSMutableDictionary dictionary];
    attributesSel[NSForegroundColorAttributeName] = [UIColor blackColor];
     attributesSel[NSFontAttributeName] = [UIFont systemFontOfSize:50];
    [tabBarItem setTitleTextAttributes:attributesSel forState:UIControlStateSelected];
    //设置字体大小 只有在正常状态下才能设置字体大小
    NSMutableDictionary *attributesNor = [NSMutableDictionary dictionary];
    attributesNor[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    [tabBarItem setTitleTextAttributes:attributesNor forState:UIControlStateNormal];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加所有子控制器
    [self setUPAllChildViewController];
    //设置所有tabBarItem
    [self setUpAlltabBarItemContent];
    //自定义tabBar
    [self setUpTabBar];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 自定义tabBar
- (void)setUpTabBar{
    CZQTabBar *tabBar = [[CZQTabBar alloc] init];
    [self setValue:tabBar forKeyPath:@"tabBar"];
}

#pragma mark - 添加所有子控制器

- (void)setUPAllChildViewController{
    //--------2.1添加子控制器-----------
    
    // -------精华
    CZQEssenceViewController *essenceVC = [[CZQEssenceViewController alloc] init];
    //创建导航控制器,根控制器为精华控制器
    CZQNavigationViewController *essenceNVC = [[CZQNavigationViewController alloc] initWithRootViewController:essenceVC];
    //窗口根控制器winRootVC添加essenceNVC为子控制器
    [self addChildViewController:essenceNVC];
    
    //---------新帖
    CZQNewViewController *newVC = [[CZQNewViewController alloc] init];
    //创建导航控制器,根控制器为新帖控制器
    CZQNavigationViewController *newNVC = [[CZQNavigationViewController alloc] initWithRootViewController:newVC];
    //窗口根控制器winRootVC添加newNVC为子控制器
    [self addChildViewController:newNVC];
    
//    //----------发布
//    CZQPublishViewController *pubishVC = [[CZQPublishViewController alloc] init];
//    //窗口根控制器winRootVC添加publishNVC为子控制器
//    [self addChildViewController:pubishVC];
//    
    //---------关注
    CZQFriendThrendsViewController *friendThrendsVC = [[CZQFriendThrendsViewController alloc] init];
    //创建导航控制器,根控制器为关注控制器
    CZQNavigationViewController *friendThrendsNVC = [[CZQNavigationViewController alloc] initWithRootViewController:friendThrendsVC];
    //窗口根控制器winRootVC添加friendThrendsNVC为子控制器
    [self addChildViewController:friendThrendsNVC];
    
    //---------我
    UIStoryboard *meVCStory = [UIStoryboard storyboardWithName:NSStringFromClass([CZQMeViewController class]) bundle:nil];
    CZQMeViewController *meVC = [meVCStory instantiateInitialViewController];
    //创建导航控制器,根控制器为我控制器
    CZQNavigationViewController *meNVC = [[CZQNavigationViewController alloc] initWithRootViewController:meVC];
    //窗口根控制器winRootVC添加meNVC为子控制器
    [self addChildViewController:meNVC];
}
#pragma mark - 设置所有tabBarItem

- (void)setUpAlltabBarItemContent{
    //--------2.1添加TableBar上面的按钮----------- ?
    //--------------------------问题 图片被自动渲染 字体较大 发布按钮图片显示不出来---------------------------------------------
    //essenceNVC 精华
    UINavigationController *essenceNVC = self.childViewControllers[0];
    essenceNVC.tabBarItem.title = @"精华";
    essenceNVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_essence_icon"];
    essenceNVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    //newNVC 新帖
    UINavigationController *newNVC = self.childViewControllers[1];
    newNVC.tabBarItem.title = @"新帖";
    newNVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_new_icon"];
    newNVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    //pubishVC 发布
//    //    pubishVC.tabBarItem.title = @"发布";
//    CZQPublishViewController *pubishVC = self.childViewControllers[2];
//    pubishVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_publish_icon"];
//    pubishVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_publish_click_icon"];
//    //设置图片位置，由于图片位置不对
//    pubishVC.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    //friendThrendsNVC 关注
    UINavigationController *friendThrendsNVC = self.childViewControllers[2];
    friendThrendsNVC.tabBarItem.title = @"关注";
    friendThrendsNVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_friendTrends_icon"];
    friendThrendsNVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    //meNVC 我
    UINavigationController *meNVC = self.childViewControllers[3];
    meNVC.tabBarItem.title = @"我";
    meNVC.tabBarItem.image = [UIImage imageOriginalWithName:@"tabBar_me_icon"];
    meNVC.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];

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
