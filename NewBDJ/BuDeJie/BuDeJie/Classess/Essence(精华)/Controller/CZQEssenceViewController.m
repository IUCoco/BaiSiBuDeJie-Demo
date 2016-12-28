//
//  CZQEssenceViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/21.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQEssenceViewController.h"
#import "CZQTitleButton.h"
#import "CZQAllViewController.h"
#import "CZQVideoViewController.h"
#import "CZQVoiceViewController.h"
#import "CZQPictureViewController.h"
#import "CZQWordViewController.h"


#define CZQColor(r,g,b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1]

@interface CZQEssenceViewController ()<UIScrollViewDelegate>

//标题栏View
@property(nonatomic, weak)UIView *titleView;
//保存上一个选中按钮
@property(nonatomic, weak)CZQTitleButton *previousClickTitleBtn;
//下划线underLine
@property(nonatomic, weak)UIView *underLine;
//记录所有的scrollView
@property(nonatomic, weak)UIScrollView *scrollView;

@end

@implementation CZQEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor redColor];
    //初始化子控制器
    [self setUpChildViewContrS];
    //设置导航条
    [self setUpNavBar];
    //添加ScrollerView
    [self setUpScrollView];
    //添加标题栏
    [self setUpTitleView];
    //创建第零个子控制器
    [self addChildVCViewIntoScrollView:0];
}


//初始化子控制器
- (void)setUpChildViewContrS{
    //添加五个子控制器
    [self addChildViewController:[[CZQAllViewController alloc] init]];
    [self addChildViewController:[[CZQVideoViewController alloc] init]];
    [self addChildViewController:[[CZQVoiceViewController alloc] init]];
    [self addChildViewController:[[CZQPictureViewController alloc] init]];
    [self addChildViewController:[[CZQWordViewController alloc] init]];
}

//添加ScrollerView
- (void)setUpScrollView{
    //计算子控制器的个数
    NSInteger count = self.childViewControllers.count;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    //取消水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //可以分页·
    scrollView.pagingEnabled = YES;
    //取消点击状态栏自动回滚到最顶部的效果 *************  only if there's one on-screen scroll
    scrollView.scrollsToTop = NO;
    scrollView.backgroundColor = [UIColor orangeColor];
    //设置水平方向可滚动的大小为  子控制器的个数 * self的宽度
    scrollView.contentSize = CGSizeMake(scrollView.czq_with * count, 0);
    //设置代理监听滑动
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
    
    //添加scrollView的子控件  为了优化不是一次性创建只在点击按钮的时候才创建
//    CGFloat childViewW = scrollView.czq_with;
//    CGFloat childViewH = scrollView.czq_hight;//减去底部tabbar的高度和顶部64+35的高度
//    CGFloat childViewY = 0;//在自动下移64的基础之上下移titleView的高度35
//    for (NSInteger i = 0; i < count; i ++) {
//        //取出每个子控制器的view
//        UIView *childView = self.childViewControllers[i].view;
//        //设置每个子控制器的view的frame
////        CGFloat childViewW = scrollView.czq_with;
////        CGFloat childViewH = scrollView.czq_hight;
////        CGFloat childViewY = 0;
//        CGFloat childViewX = i * childViewW;
//        childView.frame = CGRectMake(childViewX, childViewY, childViewW, childViewH);
//        childView.backgroundColor = CZQColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
//        [scrollView addSubview:childView];
//        
//    }
}

//添加标题栏
- (void)setUpTitleView{
    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.5];
    titleView.frame = CGRectMake(0, 64, CZQScreenWith, 35);
    [self.view addSubview:titleView];
    self.titleView = titleView;
    //添加标题栏按钮
    [self setUpTitleBtn];
    //添加底部下划线
    [self setUpTitleUnderLine];
}

//添加标题栏按钮
- (void)setUpTitleBtn{
    //按钮文字数组
    NSArray *btnTitleArr = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    NSInteger count = btnTitleArr.count;
    //按钮尺寸
    CGFloat titleBtnW = CZQScreenWith / count;
    CGFloat titleBtnH = self.titleView.czq_hight;
    for (NSInteger i = 0; i < count; i ++) {
        
        CZQTitleButton *titleBtn = [[CZQTitleButton alloc]init];
        //给titleBtn添加事件监听
        [titleBtn addTarget:self action:@selector(titleBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        titleBtn.frame = CGRectMake(i * titleBtnW, 0, titleBtnW, titleBtnH);
        //随机颜色
        //titleBtn.backgroundColor = CZQColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
        //设置标题
        [titleBtn setTitle:btnTitleArr[i] forState:UIControlStateNormal];
        //设置标题大小
        titleBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        //选中为红色，不选中状态为亮黑色
        [titleBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [titleBtn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [self.titleView addSubview:titleBtn];
        //*******给previousClickTitleBtn最开始赋值,以至于刚进入程序展示allViewController的view时候点击一下TitleView上全部按钮就刷新
        if (i == 0 && self.previousClickTitleBtn == nil) {
            self.previousClickTitleBtn = titleBtn;
        }
        
    }
}

//titleBtn按钮点击事件监听
- (void)titleBtnClick:(CZQTitleButton *)titleBtn{
    //**********监听重复点击标题按钮
    if (self.previousClickTitleBtn == titleBtn) {//如果前一次和这次啊点击的按钮为同一个按钮
        CZQLog(@"titleBtnClick双点击");
        //发布通知
        [[NSNotificationCenter defaultCenter] postNotificationName:CZQTitleButtonDidRepeatClickNotification object:nil];
    }
    
    CZQLog(@"titleBtnClick");
    //选中为红色，不选中状态为亮黑色
    //切换按钮时候以前选中按钮状态设置为不选中状态
    self.previousClickTitleBtn.selected = NO;
    //当前选中按钮为选中状态
    titleBtn.selected = YES;
    //当前选中按钮赋值给previousClickTitleBtn
    self.previousClickTitleBtn = titleBtn;
    
    //获取索引
    NSUInteger index = [self.titleView.subviews indexOfObject:titleBtn];
    //---------------设置下画线中心按钮的X值，动态设置-----------
    [UIView animateWithDuration:0.25 animations:^{
        NSMutableDictionary *attributs = [NSMutableDictionary dictionary];
        attributs[NSFontAttributeName] = titleBtn.titleLabel.font;
        _underLine.czq_with = [titleBtn.currentTitle sizeWithAttributes:attributs].width;
        _underLine.czq_centerX = titleBtn.czq_centerX;
         
        //点击按钮设置scrollView的contentOfSet，以至于点击titleBtn按钮底部tableView跟着相对移动
//        NSUInteger index = [self.titleView.subviews indexOfObject:titleBtn];
        CGFloat conOfSetX = self.scrollView.czq_with * index;
        self.scrollView.contentOffset = CGPointMake(conOfSetX, self.scrollView.contentOffset.y);
    } completion:^(BOOL finished) {
        //添加scrollView的子控件
        [self addChildVCViewIntoScrollView:index];
//
    }];
    //---------------设置下画线中心按钮的X值，动态设置-----------
    
    //获取子控件个数
    NSInteger count = self.childViewControllers.count;
    //取消点击状态栏自动回滚到最顶部的效果    *************  only if there's one on-screen scroll,只有在当前index下的tableView才能滚动
    for (int i = 0; i < count; i++) {
        UIViewController *childVC = self.childViewControllers[i];
        //*****************如果子控制器的view没有被创建就不需要设置 ，直接跳出本次循环
        if (!childVC.isViewLoaded) continue;
        UIScrollView *childV = (UIScrollView *)childVC.view;
        //如果子控制器的view不是UIScrollView，则不需要设置直接调过本次循环
        if (![childV isKindOfClass:[UIScrollView class]]) continue;
        //只有此子控制器的view的索引与当前按钮索引相同才能够设置滑动
        childV.scrollsToTop = (index == i);
    }
     //取消点击状态栏自动回滚到最顶部的效果    *************  only if there's one on-screen scroll,只有在当前index下的tableView才能滚动
}

//添加底部下划线titleBtnClick:实现
- (void)setUpTitleUnderLine{
    CZQTitleButton *titleBtn = self.titleView.subviews[0];
    UIView *underLine = [[UIView alloc] init];
    
    //----------------设置首次展示的frame，由于在viewDidLoad调用该方法，控件还没有显示，大小为空--------------
    underLine.czq_hight = 2;
    underLine.czq_y = self.titleView.czq_hight - underLine.czq_hight;
    
    NSMutableDictionary *attributs = [NSMutableDictionary dictionary];
    attributs[NSFontAttributeName] = titleBtn.titleLabel.font;
    underLine.czq_with = [titleBtn.currentTitle sizeWithAttributes:attributs].width;
    
    underLine.czq_centerX = titleBtn.czq_centerX;
    //----------------设置首次展示的frame--------------
    underLine.backgroundColor = [titleBtn titleColorForState:UIControlStateSelected];
    [self.titleView addSubview:underLine];
    _underLine = underLine;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //获取当前scrollView的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.czq_with;
    //实现点击对应按钮
    CZQTitleButton *btn = self.titleView.subviews[index];
    [self titleBtnClick:btn];
}

#pragma mark - 设置导航条
- (void)setUpNavBar{
    //左边按钮
    UIImage *leftNorImage = [UIImage imageNamed:@"nav_item_game_icon"];
    UIImage *leftHighImage = [UIImage imageNamed:@"nav_item_game_click_icon"];
    //调用UIBarButtonItem分类直接生成需要的buttonItem
    UIBarButtonItem *leftBtnItem = [UIBarButtonItem itemWithNorImage:leftNorImage highImage:leftHighImage target:self action:@selector(essenceLeftBtnClick)];
    self.navigationItem.leftBarButtonItem = leftBtnItem;
    //右边按钮
    UIImage *rightNorImage = [UIImage imageNamed:@"navigationButtonRandom"];
    UIImage *rightHighImage = [UIImage imageNamed:@"navigationButtonRandomClick"];
    //调用UIBarButtonItem分类直接生成需要的buttonItem
    UIBarButtonItem *rightBtnItem = [UIBarButtonItem itemWithNorImage:rightNorImage highImage:rightHighImage target:self action:@selector(essenceRightBtnClick)];
    self.navigationItem.rightBarButtonItem = rightBtnItem;
    //中间图片
    UIImage *centerImage = [UIImage imageNamed:@"MainTitle"];
    UIImageView *centerImageView = [[UIImageView alloc] initWithImage:centerImage];
    self.navigationItem.titleView = centerImageView;
    
    
}

- (void)essenceLeftBtnClick{
    NSLog(@"essenceLeftBtnClick");
}

- (void)essenceRightBtnClick{
    NSLog(@"essenceRightBtnClick");
}

#pragma mark - 根据索引index的子控制器的view添加到scrollView上面
- (void)addChildVCViewIntoScrollView:(NSInteger) index{
    //添加scrollView的子控件

    
    //取出每个子控制器的view
    UIView *childView = self.childViewControllers[index].view;
    //*************如果childView的superView有值说明已经加过了就不用再加一遍了*************
    if (childView.superview) return;
    
    CGFloat childViewW = self.scrollView.czq_with;
    CGFloat childViewH = self.scrollView.czq_hight;//减去底部tabbar的高度和顶部64+35的高度
    CGFloat childViewY = 0;//在自动下移64的基础之上下移titleView的高度35
    CGFloat childViewX = index * childViewW;
    childView.frame = CGRectMake(childViewX, childViewY, childViewW, childViewH);
    childView.backgroundColor = CZQColor(arc4random_uniform(255), arc4random_uniform(255), arc4random_uniform(255));
    [self.scrollView addSubview:childView];
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
