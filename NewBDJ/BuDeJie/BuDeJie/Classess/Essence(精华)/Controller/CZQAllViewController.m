//
//  CZQAllViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/12/2.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQAllViewController.h"
#import "CZQTabBar.h"

@interface CZQAllViewController ()

//底部显示上拉刷新的footerView
@property(nonatomic, weak)UIView *footerView;
//底部显示上拉刷新的footerView上面的footerLable
@property(nonatomic,weak)UILabel *footLable;
//底部显示上拉刷新的footerView是否正在请求数据
@property(nonatomic, assign, getter=isFooterViewFefreshing)BOOL footerViewFefreshing;

//顶部显示上拉刷新的headerView
@property(nonatomic, weak)UIView *headerView;
//顶部显示上拉刷新的footerView上面的headerLable
@property(nonatomic,weak)UILabel *headerLable;
//顶部显示上拉刷新的headerView是否正在请求数据
@property(nonatomic, assign, getter=isHeaderViewFefreshing)BOOL headerViewFefreshing;

//记录cell个数
@property(nonatomic, assign)NSInteger dataCount;
@end

@implementation CZQAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //初始化cell的个数
    self.dataCount = 5;
    //设置tableView的contentInset，使tableView全屏穿透效果并且能够展示首位所有内容并且不会弹回
    //顶部为基础20+44+TitleView的35 == 99  底部为tabBar的高度49
    self.tableView.contentInset = UIEdgeInsetsMake(CZQTitleViewH, 0, CZQTabBarH + CZQContentInsetH, 0);
    //*********设置滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    //********添加监听CZQTabBarButtonDidRepeatClickNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:CZQTabBarButtonDidRepeatClickNotification object:nil];
    //**********添加监听CZQTitleButtonDidRepeatClickNotification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(titleButtonDidRepeatClick) name:CZQTitleButtonDidRepeatClickNotification object:nil];
    //设置刷新
    [self setUpRefresh];
  
}

//**********监听事件CZQTabBarButtonDidRepeatClickNotification
- (void)tabBarButtonDidRepeatClick{
    //如果重复点击的按钮不是精华按钮则返回，不刷新 ,*****************因为点击其他按钮的时候当前控制器会被暂时移除keyWindow
    if (self.view.window == nil) return;
    //如果精华页面显示的不是当前控制器的View返回，不刷新, **********因为如果精华当前显示的控制器view为当前控制器的view，只有当前控制器的view的scrollsToTop为YES
    if (self.tableView.scrollsToTop == NO) return;
    //排除上面两种可能后才能判断当前点击了精华按钮，并且显示的是当前控制器的View
       NSLog(@"CZQAllViewController监听了CZQTabBarButtonDidRepeatClickNotification点击------执行刷新");
    //执行刷新
    [self headerBeginFefreshing];
}

//***********监听事件CZQTitleButtonDidRepeatClickNotification
- (void)titleButtonDidRepeatClick{
    //如果重复点击的按钮不是精华按钮则返回，不刷新 ,*****************因为点击其他按钮的时候当前控制器会被暂时移除keyWindow
    if (self.view.window == nil) return;
    //如果精华页面显示的不是当前控制器的View返回，不刷新, **********因为如果精华当前显示的控制器view为当前控制器的view，只有当前控制器的view的scrollsToTop为YES
    if (self.tableView.scrollsToTop == NO) return;
    //排除上面两种可能后才能判断当前点击了精华按钮，并且显示的是当前控制器的View
    NSLog(@"CZQAllViewController监听了CZQTitleButtonDidRepeatClickNotification点击------执行刷新");
}

//移除监听
- (void)dealloc{
    //移除CZQAllViewController的监听
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

 //设置刷新------上拉拉刷新---  --下拉刷新
- (void)setUpRefresh{
    //tableHeaderView广告
    UILabel *adLable = [[UILabel alloc] init];
    adLable.frame = CGRectMake(0, 0, self.tableView.czq_with, 30);
    adLable.text = @"广告";
    adLable.backgroundColor = [UIColor blueColor];
    adLable.textAlignment = NSTextAlignmentCenter;
    self.tableView.tableHeaderView = adLable;
    
    //-----下拉刷新,添加到tableView上面
    UIView *headerView = [[UIView alloc] init];
    headerView.frame = CGRectMake(0, -50, self.tableView.czq_with, 50);
    self.headerView = headerView;
    UILabel *headerLable = [[UILabel alloc] init];
    headerLable.frame = headerView.bounds;
    headerLable.backgroundColor = [UIColor redColor];
    headerLable.text = @"下拉可以加载更多数据...";
    headerLable.textAlignment = NSTextAlignmentCenter;
    self.headerLable = headerLable;
    [headerView addSubview:headerLable];
    //添加到tableView上面
    [self.tableView addSubview:headerView];
    //***********进入的时候自动刷新
    [self headerBeginFefreshing];
    
    //------tableFooterView上拉拉刷新-
    UIView *footerView = [[UIView alloc] init];
    footerView.frame = CGRectMake(0, 0, self.tableView.czq_with, 35);
    self.footerView = footerView;
    UILabel *footLable = [[UILabel alloc] init];
    footLable.frame = footerView.bounds;
    footLable.backgroundColor = [UIColor redColor];
    footLable.text = @"上拉可以加载更多数据...";
    footLable.textAlignment = NSTextAlignmentCenter;
    self.footLable = footLable;
    [footerView addSubview:footLable];
    self.tableView.tableFooterView = footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //*********当数据为零时候，fooerView的状态为隐藏状态
    self.footerView.hidden = (self.dataCount == 0);
    return self.dataCount;
 
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

#pragma mark - UITableViewDelegate
//符合条件执行上拉---下拉刷新
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{//scrollViewDelegate
    //处理footerView上拉刷新
    [self dealFooterView];
    //处理headerView下拉刷新
    [self dealHeaderView];
    
}

//处理停止拖拽---下拉刷新

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //如果正在刷新状态则什么都不做
    if (self.isHeaderViewFefreshing == YES) return;
    //tableView的contentInset(20 + 44 + 35) + headerView的高度（50）
    //    CGFloat offsetY = - (35 + 50);
    CGFloat offsetY = -(CZQTitleViewH + self.headerView.czq_hight);
    if (self.tableView.contentOffset.y <= offsetY) {//此时headerView已经完全出现
        //1开始执行刷新******** ---headerBeginFefreshing中包含headerEndFefreshing
        [self headerBeginFefreshing];
    }
}

//处理footerView上拉刷新
- (void)dealFooterView{
    //当self.tableView.contentSize.height == 0 得时候没有必要判断，防止第一次进入由于self.tableView.contentOffset.y >= contOfSet 产生BUG
    if (self.tableView.contentSize.height == 0) return;
    //**************如果正在刷新则返回，防止多次请求的情况
    if (self.isFooterViewFefreshing) return;
    //当tableView的scrollView的偏移量y值>= offSet的时候，代表tableFooterView已经**完全**出现
    CGFloat contOfSet = self.tableView.contentSize.height + self.tableView.contentInset.bottom - self.tableView.czq_hight;
    if (self.tableView.contentOffset.y >= contOfSet  && self.tableView.contentOffset.y >= -self.tableView.contentInset.top) {//解决数据量少的时候上下同时刷新的Bug，只有footerView同时具备完全出现+self.tableView.contentOffset.y >= 50+35才满足**********
        NSLog(@"tableFooterView已经出现");
        //1*******------.符合条件执行上拉刷新，footerBeginFefreshing中包含footerEndFefreshing
        [self footerBeginFefreshing];
    }
}

//处理headerView下拉刷新
- (void)dealHeaderView{
    //如果处于刷新状态返回
    if (self.isHeaderViewFefreshing == YES) return;
    //tableView的contentInset(20 + 44 + 35) + headerView的高度（50）
//    CGFloat offsetY = - (35 + 50);
    CGFloat offsetY = -(CZQTitleViewH + self.headerView.czq_hight);
    if (self.tableView.contentOffset.y <= offsetY) {//此时headerView已经完全出现
        //请求刷新数据
        self.headerLable.text = @"松开加载更多数据...";
    }else{//松开返回的状态--********执行代理----endDraging
        self.headerLable.text = @"下拉可以加载更多数据";
    }
}

#pragma mark -

#pragma mark - footerFefreshing
//
-(void)footerBeginFefreshing{
    //**************如果正在刷新则返回，防止多次请求的情况
    if (self.isFooterViewFefreshing) return;
    //1------.符合条件执行上拉刷新
    self.footLable.text = @"数据正在加载中...";
    //*************重新设置请求数据状态为YES
    self.footerViewFefreshing = YES;
    //2.请求数据,发送给服务器
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //服务器请求回来了
        self.dataCount += 5;
        [self.tableView reloadData];
        //2.----------结束刷新
        [self footerEndFefreshing];
    });
}

-(void)footerEndFefreshing{
    //2.----------结束刷新
    //1.重新设置footLable
    self.footLable.text = @"上拉可以加载更多数据...";
    //*************重新设置请求数据状态为NO
    self.footerViewFefreshing = NO;
}
#pragma mark - headerFefreshing

-(void)headerBeginFefreshing{
    //如果处于刷新状态返回
    if (self.isHeaderViewFefreshing == YES) return;
    //1.-------请求刷新数据,开始刷新
    self.headerLable.text = @"正在刷新...";
    //更改刷新状态，此时为刷新状态
    self.headerViewFefreshing = YES;
    //增加内边距，使之下拉刷新（正在刷新状态）的时候停留一会
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets edgInset = self.tableView.contentInset;
        edgInset.top += self.headerView.czq_hight;
        self.tableView.contentInset = edgInset;
        
        //************拉倒很底部的时候刷新，要修改偏移量，才能移动到最上面
        self.tableView.contentOffset = CGPointMake(self.tableView.contentOffset.x, - edgInset.top);
        
//    } completion:^(BOOL finished) {
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            //服务器数据
//            self.dataCount = 20;
//            [self.tableView reloadData];
//            //2.---------结束刷新改变刷新状态
//            [self headerEndFefreshing];
//        });
    }];
    
    CZQLog(@"发送请求给服务器，下拉刷新数据");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //服务器数据
        self.dataCount = 20;
        [self.tableView reloadData];
        //2.---------结束刷新改变刷新状态
        [self headerEndFefreshing];

    });
}

-(void)headerEndFefreshing{
    //2.---------结束刷新改变刷新状态
    self.headerViewFefreshing = NO;
    //结束刷新减小内边距
    UIEdgeInsets edgInset = self.tableView.contentInset;
    edgInset.top -= self.headerView.czq_hight;
    self.tableView.contentInset = edgInset;
}
@end
