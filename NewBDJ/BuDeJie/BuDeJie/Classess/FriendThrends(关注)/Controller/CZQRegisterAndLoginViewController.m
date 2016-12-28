//
//  CZQRegisterAndLoginViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/27.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQRegisterAndLoginViewController.h"
#import "CZQLoginAndRegisteModelView.h"
#import "CZQFastLoginView.h"

@interface CZQRegisterAndLoginViewController ()
//中间View
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leadingCons;
//底部View
@property (weak, nonatomic) IBOutlet UIView *bottomView;


@end



@implementation CZQRegisterAndLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //登录View
    CZQLoginAndRegisteModelView *loginView = [CZQLoginAndRegisteModelView loginView];
    [self.middleView addSubview:loginView];
    //注册View
    CZQLoginAndRegisteModelView *registerView = [CZQLoginAndRegisteModelView registerView];
    [self.middleView addSubview:registerView];
    //快速登录View
    CZQFastLoginView *fastLoginView = [CZQFastLoginView fastLoginView];
    [self.bottomView addSubview:fastLoginView];
    
    
}
/*-------- viewDidLayoutSubviews ---------**/
//布局
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    //登录注册
    CZQLoginAndRegisteModelView *loginView = self.middleView.subviews[0];
    loginView.frame = CGRectMake(0, 0, self.middleView.czq_with * 0.5, self.middleView.czq_hight);
    CZQLoginAndRegisteModelView *registerView = self.middleView.subviews[1];
    registerView.frame = CGRectMake(self.middleView.czq_with * 0.5, 0, self.middleView.czq_with * 0.5, self.middleView.czq_hight);
    //快速登录
    CZQFastLoginView *fastLoginView = self.bottomView.subviews[0];
    fastLoginView.frame = self.bottomView.bounds;
}

//退出登录
- (IBAction)dismissBtnClick:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
//点击注册按钮
- (IBAction)registBtnClick:(UIButton *)registBtn {
    registBtn.selected = !registBtn.selected;
    //将middleView向右移动
    _leadingCons.constant = _leadingCons.constant == 0? - self.middleView.czq_with * 0.5:0;
    [UIView animateWithDuration:0.5 animations:^{
        [self.view layoutIfNeeded]; 
    }];
    
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
