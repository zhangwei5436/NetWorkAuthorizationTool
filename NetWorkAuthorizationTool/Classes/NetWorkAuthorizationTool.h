//
//  NetWorkAuthorizationTool.h
//  NetIsOkTest
//
//  Created by 张威 on 2018/2/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetWorkAuthorizationTool : NSObject

/**
 是否开启蜂窝数据网络
 */
- (void)requestCellularAuthorization:(void(^)(BOOL isOpen))cellularNetIsOpenBlock;

/**
 是否属于移动数据开启 但是未开启移动数据权限
 */
- (void)judgeisCellularNetDataWithClosedCellularNet:(void(^)(BOOL sure))iscellularNetClosedCellular;
@end
