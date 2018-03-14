//
//  ZWViewController.m
//  NetWorkAuthorizationTool
//
//  Created by zhangwei5436 on 03/14/2018.
//  Copyright (c) 2018 zhangwei5436. All rights reserved.
//

#import "ZWViewController.h"
#import "NetWorkAuthorizationTool.h"

@interface ZWViewController ()
{
    // 对象用全局对象 局部变量 ，，回调还没拿到 ，对象就被销毁了
    NetWorkAuthorizationTool * _ttt;
}
@end

@implementation ZWViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    _ttt = [[NetWorkAuthorizationTool alloc]init];
    [_ttt requestCellularAuthorization:^(BOOL isOpen) {
        if (isOpen) {
            NSLog(@"蜂窝数据开启");
        }else{
            NSLog(@"蜂窝数据关闭");
        }
    }];
    
    [_ttt judgeisCellularNetDataWithClosedCellularNet:^(BOOL sure) {
        if (sure) {
            NSLog(@"属于 移动数据开启 但是未开启移动数据权限");
        }else{
            NSLog(@"不属于移动数据开发 或者 属于移动开发 同时开启了蜂窝数据");
        }
    }];
    
}

@end
