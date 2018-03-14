//
//  NetWorkAuthorizationTool.m
//  NetIsOkTest
//
//  Created by 张威 on 2018/2/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "NetWorkAuthorizationTool.h"
#import <CoreTelephony/CTCellularData.h>
#import "AFNetworkReachabilityManager.h"
@interface NetWorkAuthorizationTool()
/**
 监测句柄对象
 */
@property (nonatomic, strong) CTCellularData * requestCellularDataHandle;
@property (nonatomic, strong) CTCellularData * judgeCellularDataHandle;
@property (nonatomic, assign) BOOL cellularNetIsOpen;
@end

@implementation NetWorkAuthorizationTool

- (void)requestCellularAuthorization:(void(^)(BOOL isOpen))cellularNetIsOpenBlock
{
    if (@available(iOS 9.0, *)){
        __weak typeof(self) weakSelf = self;
        self.requestCellularDataHandle.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            __strong typeof(weakSelf) strongSelf = weakSelf;
            //获取联网状态
            switch (state) {
                case kCTCellularDataRestricted: //蜂窝权限被关闭，有网络权限完全关闭or只有WiFi权限 两种情况"
                {
                    if (cellularNetIsOpenBlock) {
                        cellularNetIsOpenBlock(NO);
                        strongSelf.cellularNetIsOpen = NO;
                    }
                }
                    break;
                case kCTCellularDataNotRestricted:// 蜂窝权限开启
                {
                    if (cellularNetIsOpenBlock) {
                        cellularNetIsOpenBlock(YES);
                        strongSelf.cellularNetIsOpen = YES;
                    }
                }
                    break;
                case kCTCellularDataRestrictedStateUnknown:// 权限未知
                {
                    if (cellularNetIsOpenBlock) {
                        cellularNetIsOpenBlock(NO);
                        strongSelf.cellularNetIsOpen = NO;
                    }
                }
                    break;
                default:
                    break;
            };
        };
    }else{
        cellularNetIsOpenBlock(YES);
        self.cellularNetIsOpen = YES;
    }
}
//AFNetworkReachabilityStatusUnknown          = -1,  未知
//AFNetworkReachabilityStatusNotReachable     = 0,   未连接
//AFNetworkReachabilityStatusReachableViaWWAN = 1,   3G
//AFNetworkReachabilityStatusReachableViaWiFi = 2,   无线连接
//kCTCellularDataRestricted   蜂窝权限被关闭，有 网络权限完全关闭 or 只有WiFi权限 两种情况
//kCTCellularDataNotRestricted 蜂窝权限开启
//kCTCellularDataRestrictedStateUnknown 权限未知
- (void)judgeisCellularNetDataWithClosedCellularNet:(void(^)(BOOL sure))iscellularNetClosedCellular
{
    dispatch_queue_t queue = dispatch_queue_create("cellcilar", DISPATCH_QUEUE_SERIAL);
    dispatch_group_t group = dispatch_group_create();

    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        __weak typeof(self) weakSelf = self;

        if (@available(iOS 9.0, *)) {
            self.judgeCellularDataHandle.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
                __strong typeof(weakSelf) strongSelf = weakSelf;
                //获取联网状态
                if (state == kCTCellularDataNotRestricted) {
                    strongSelf.cellularNetIsOpen = YES;
                }else{
                    strongSelf.cellularNetIsOpen = NO;
                }
                dispatch_group_leave(group);
            };
        }else{
            self.cellularNetIsOpen = YES;
            dispatch_group_leave(group);
        }
    });

    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];

    dispatch_group_notify(group, queue, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (manager.reachableViaWWAN && !self.cellularNetIsOpen) {
                if (iscellularNetClosedCellular) {
                    iscellularNetClosedCellular(YES);
                }
            }else{
                if (iscellularNetClosedCellular) {
                    iscellularNetClosedCellular(NO);
                }
            }
        });
    });
}

- (CTCellularData *)requestCellularDataHandle
{
    if (_requestCellularDataHandle == nil)
    {
        if (@available(iOS 9.0, *)) {
            _requestCellularDataHandle =  [[CTCellularData alloc]init];
        }
    }
    return _requestCellularDataHandle;
}

- (CTCellularData *)judgeCellularDataHandle
{
    if (_judgeCellularDataHandle == nil)
    {
        if (@available(iOS 9.0, *)) {
            _judgeCellularDataHandle =  [[CTCellularData alloc]init];
        }
    }
    return _judgeCellularDataHandle;
}

- (void)dealloc{
    if (@available(iOS 9.0, *)) {
        _requestCellularDataHandle.cellularDataRestrictionDidUpdateNotifier = nil;
        _requestCellularDataHandle = nil;
        _judgeCellularDataHandle.cellularDataRestrictionDidUpdateNotifier = nil;
        _judgeCellularDataHandle = nil;
    }
}
@end
