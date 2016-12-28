//
//  CZQADViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/23.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQADViewController.h"
#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "CZQADItem.h"
#import <UIImageView+WebCache.h>
#import "CZQTabBarController.h"

#define code2 @"phcqnauGuHYkFMRquANhmgN_IauBThfqmgKsUARhIWdGULPxnz3vndtkQW08nau_I1Y1P1Rhmhwz5Hb8nBuL5HDknWRhTA_qmvqVQhGGUhI_py4MQhF1TvChmgKY5H6hmyPW5RFRHzuET1dGULnhuAN85HchUy7s5HDhIywGujY3P1n3mWb1PvDLnvF-Pyf4mHR4nyRvmWPBmhwBPjcLPyfsPHT3uWm4FMPLpHYkFh7sTA-b5yRzPj6sPvRdFhPdTWYsFMKzuykEmyfqnauGuAu95Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiu9mLfqHbD_H70hTv6qnHn1PauVmynqnjclnj0lnj0lnj0lnj0lnj0hThYqniuVujYkFhkC5HRvnB3dFh7spyfqnW0srj64nBu9TjYsFMub5HDhTZFEujdzTLK_mgPCFMP85Rnsnbfknbm1QHnkwW6VPjujnBdKfWD1QHnsnbRsnHwKfYwAwiuBnHfdnjD4rjnvPWYkFh7sTZu-TWY1QW68nBuWUHYdnHchIAYqPHDzFhqsmyPGIZbqniuYThuYTjd1uAVxnz3vnzu9IjYzFh6qP1RsFMws5y-fpAq8uHT_nBuYmycqnau1IjYkPjRsnHb3n1mvnHDkQWD4niuVmybqniu1uy3qwD-HQDFKHakHHNn_HR7fQ7uDQ7PcHzkHiR3_RYqNQD7jfzkPiRn_wdKHQDP5HikPfRb_fNc_NbwPQDdRHzkDiNchTvwW5HnvPj0zQWndnHRvnBsdPWb4ri3kPW0kPHmhmLnqPH6LP1ndm1-WPyDvnHKBrAw9nju9PHIhmH9WmH6zrjRhTv7_5iu85HDhTvd15HDhTLTqP1RsFh4ETjYYPW0sPzuVuyYqn1mYnjc8nWbvrjTdQjRvrHb4QWDvnjDdPBuk5yRzPj6sPvRdgvPsTBu_my4bTvP9TARqnam"

@interface CZQADViewController ()
//广告view
@property (weak, nonatomic) IBOutlet UIView *adView;
//启动图片ImageView
@property (weak, nonatomic) IBOutlet UIImageView *launchImageView;
//广告图片
@property(nonatomic, weak)UIImageView *adImageView;
//item
@property(nonatomic, strong)CZQADItem *adItem;
//定时器
@property(nonatomic, weak)NSTimer *timer;
//定时器跳转按钮
@property (weak, nonatomic) IBOutlet UIButton *jumpTimBtn;

@end

@implementation CZQADViewController

//广告图片懒加载
- (UIImageView *)adImageView{
    if (_adImageView == nil) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //给广告图片添加点击手势，达到点击监控的目的
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(adTapGesClick)];
        [imageView addGestureRecognizer:tapGes];
        imageView.userInteractionEnabled = YES;
        
        [self.adView addSubview:imageView];
        _adImageView = imageView;
    }
    return _adImageView;
}

//实现手势监控 广告跳转
- (void)adTapGesClick{
    //广告跳转
    UIApplication *application = [UIApplication sharedApplication];
    //广告跳转的目的地址
    NSURL *aimUrl = [NSURL URLWithString:_adItem.ori_curl];
    if ([application canOpenURL:aimUrl]) {
        [application openURL:aimUrl];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //设置启动图片
    [self setUpLaunchImage];
    
    /*
     
     由于URL有时候会出现问题导致'_adItem数据拿不到出现问题 _adCALayer position contains NaN: [160 nan]'错误
     所以暂时停止加载广告
     
     **/
    //加载广告数据
//    [self loadAdData];
    
    //创建定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timeChange) userInfo:nil repeats:YES];
}

//监听定时器跳转按钮
- (IBAction)jumpTimBtnClick {
    //销毁广告界面，进入主流框架界面
    CZQTabBarController *tabBarVC = [[CZQTabBarController alloc] init];
    
    //设置tabBarVC的delegate为APPDelegate，为什么不能用ADVC？因为ADVC会被销毁，delegate会失效
//    tabBarVC.delegate = (id<UITabBarControllerDelegate>)[UIApplication sharedApplication].delegate;
    
    [UIApplication sharedApplication].keyWindow.rootViewController = tabBarVC;
    //销毁定时器
    [_timer invalidate];
}

//定时器监听方法
- (void)timeChange{
    //广告展示时间只有三秒
    static int i = 3;
    if (i == 0) {
        //销毁广告界面，进入主流框架界面,销毁定时器
        [self jumpTimBtnClick];
    }
    i--;
    //设置定时器按钮倒计时
    [_jumpTimBtn setTitle:[NSString stringWithFormat:@"跳过(%d)", i] forState:UIControlStateNormal];
}

//加载广告数据
- (void)loadAdData{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //请求参数
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    //设置参数
    paramter[@"code2"] = code2;
    [manager GET:@"http://mobads.baidu.com/cpro/ui/mads.php" parameters:paramter progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary * _Nullable responseObject) {
//        NSLog(@"%@", responseObject);
        //写入plist文件，方便查看
//        [responseObject writeToFile:@"/Users/chenzhiqiang/Desktop/ad.plist" atomically:YES];
        //获取字典responseObject(dic)-->里面的ad(数组)-->数据(dic)
        NSDictionary *adDic = [responseObject[@"ad"] firstObject];
        //字典来创建一个模型
        _adItem = [CZQADItem mj_objectWithKeyValues:adDic];
        //创建UIImageView展示图片
        //按照比例设置广告图片高度
        CGFloat h = (CZQScreenWith / _adItem.w) * _adItem.h;
        /*
         
         由于URL有时候会出现问题导致'_adItem数据拿不到出现问题 _adCALayer position contains NaN: [160 nan]'错误
         所以暂时停止加载广告
         
         **/
        //由于URL有时候会出现问题导致'_adItem数据拿不到出现问题 _adCALayer position contains NaN: [160 nan]'错误
        self.adImageView.frame = CGRectMake(0, 0, CZQScreenWith, h);
        //加载广告界面
        [self.adImageView sd_setImageWithURL:[NSURL URLWithString:_adItem.w_picurl]];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Error");
        
    }];
}

//设置启动图片
- (void)setUpLaunchImage{
    //6p 414 x 736
    //6 375 x 667
    //5 320 x 568
    //4s 320 x 480
    if (iPhone7P) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];
        
    }else if (iPhone7){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];

    }else if (iPhone6P){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-Portrait-736h@3x"];

    }else if (iPhone6) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-800-667h@2x"];

    }else if (iPhone5){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];

    }else if (iPhone4s) {
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage-700-568h@2x"];

    }else if (iPodTouch){
        self.launchImageView.image = [UIImage imageNamed:@"LaunchImage"];

    }

    
    
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
