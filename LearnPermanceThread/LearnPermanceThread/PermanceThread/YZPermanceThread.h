//
//  YZPermanceThread.h
//  LearnPermanceThread
//
//  Created by ios on 2019/1/31.
//  Copyright © 2019 KN. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^YZPermanceBlock)(void);

@interface YZPermanceThread : NSObject

/**
 运行子线程
 **/
- (void)run;
/**
 在当前子线程执行任务
 **/
- (void)excuteBlock:(YZPermanceBlock)block;
/**
 停止子线程
 **/
- (void)stop;

@end

NS_ASSUME_NONNULL_END
