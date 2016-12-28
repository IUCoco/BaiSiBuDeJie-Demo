//
//  CZQFllowViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/24.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQFllowViewController.h"
#import <AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import "CZQFollowItem.h"
#import "CZQFollowCell.h"
#import <SVProgressHUD/SVProgressHUD.h>


static NSString * const ID = @"FOLLOWCell";

@interface CZQFllowViewController ()

@property(nonatomic, strong)NSArray *FollowDtaArr;
//AFN管理者对象
@property(nonatomic, weak)AFHTTPSessionManager *manager;

@end

@implementation CZQFllowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //设置顶部标题
    self.navigationItem.title = @"订阅";
    //加载follow数据
    [self loadFollwData];
    //注册自定义cell的标识符
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CZQFollowCell class]) bundle:nil] forCellReuseIdentifier:ID];
    //去掉不必要的cell
    self.tableView.tableFooterView = [[UIView alloc] init];
    //SVProgressHUD加载提示
    [SVProgressHUD showWithStatus:@"正在加载"];

}

//加载失败后点击返回按钮情况下处理
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
    //销毁SVProgressHUD提示圈
    [SVProgressHUD dismiss];
    //取消当前AFN管理的所有任务
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

//加载follow数据
- (void)loadFollwData{
    //创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    _manager = manager;
    //设置参数
    NSMutableDictionary *parDic = [NSMutableDictionary dictionary];
    parDic[@"a"] =@"tag_recommend";
    parDic[@"action"] = @"sub";
    parDic[@"c"] = @"topic";
    //延迟
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        //设置请求
        [manager GET:@"http://api.budejie.com/api/api_open.php" parameters:parDic progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            //SVProgressHUD取消加载提示
            [SVProgressHUD dismiss];
            //        NSLog(@"%@", responseObject);
            //写入plist文件，方便查看
            //      [responseObject writeToFile:@"/Users/chenzhiqiang/Desktop/follow.plist" atomically:YES];
            //字典数组转模型数组转模型
            self.FollowDtaArr = [CZQFollowItem mj_objectArrayWithKeyValuesArray:responseObject];
            //刷新表格
            [self.tableView reloadData];
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            //SVProgressHUD取消加载提示
            [SVProgressHUD dismiss];
            NSLog(@"Error");
        }];
        
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.FollowDtaArr.count;

}

//设置tableView数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CZQFollowCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {//已经使用注册方式不用这步骤了
//        //不要忘记给xib绑定标识符，否则导致cell无法重用
//        cell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([CZQFollowCell class]) owner:nil options:nil]firstObject];
//    }
    CZQFollowItem *item = self.FollowDtaArr[indexPath.row];
    cell.item = item;
    
    return cell;
}

//设置tableView row高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
