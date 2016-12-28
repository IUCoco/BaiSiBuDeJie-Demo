//
//  CZQSettingViewController.m
//  BuDeJie
//
//  Created by 陈志强 on 16/11/23.
//  Copyright © 2016年 hdu. All rights reserved.
//

#import "CZQSettingViewController.h"
#import <SDImageCache.h>

#define CachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

static NSString * const ID = @"setCell";

@interface CZQSettingViewController ()

@end

@implementation CZQSettingViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    //设置cell展示缓存大小
    NSString *lableT = [self resolveSize];
    cell.textLabel.text = lableT;
    return cell;
}

//处理MB\KB\B
- (NSString *)resolveSize{
    //获取cache的大小
    NSInteger size = [SDImageCache sharedImageCache].getSize;
    NSString *lableT = @"清除缓存";
    if (size >= 1000 * 1000) {//MB
       CGFloat resolvedSize = size / (1000.0 * 1000.0);
        lableT = [NSString stringWithFormat:@"%@(%.1fMB)", lableT, resolvedSize];
    }else if (size >= 1000){
       CGFloat resolvedSize = size / 1000.0;
        lableT = [NSString stringWithFormat:@"%@(%.1fKB)", lableT, resolvedSize];
    }else if (size >= 0){
       CGFloat resolvedSize = size;
        lableT = [NSString stringWithFormat:@"%@(%.1fB)", lableT, resolvedSize];
    }
    return lableT;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击清空缓存
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *subPaths = [fileManager contentsOfDirectoryAtPath:CachePath error:nil];
    for (NSString *subPath in subPaths) {
        //拼接全路径
        NSString *fullSubPath = [CachePath stringByAppendingPathComponent:subPath];
        //删除路径
        [fileManager removeItemAtPath:fullSubPath error:nil];
    }
    [self.tableView reloadData];
}
////计算文件缓存大小
//- (void)cacheFileSize{
//    //获取cache文件路径
//    NSString *cacheFilePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
//    //创建文件管理者
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    //获取cache文件下的所有子文件路径
//    NSArray *cacheSubFilePath = [fileManager subpathsAtPath:cacheFilePath];
//    //cacheFilePath下文件的总大小
//    NSInteger totalSize = 0;
//    //遍历所有子文件
//    for (NSString *subPath in cacheSubFilePath) {
//       //拼接子文件文件全路径
//        NSString *fullSubPath = [cacheFilePath stringByAppendingPathComponent:subPath];
//        /* --------------    去掉隐藏文件和default下面的文件夹  ----------        **/
//        //判断隐藏文件
//        if ([fullSubPath containsString:@".DS"]) continue;
//        //判断是否是文件夹且文件是否存在
//        BOOL isDirectory;
//        BOOL isExit = [fileManager fileExistsAtPath:fullSubPath isDirectory:&isDirectory];
//        if (!isExit || isDirectory) continue;
//        /* --------------    去掉隐藏文件和default下面的文件夹  ----------        **/
//        //获取子路径下的文件大小
//        NSDictionary *attrs = [fileManager attributesOfItemAtPath:fullSubPath error:nil];
//        NSInteger fileSize = [attrs fileSize];
//        totalSize += fileSize;
//
//    }
//    NSLog(@"%ld", totalSize);
//}

@end
