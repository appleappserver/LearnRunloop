//
//  YZWeakProxy.h
//  LearnDelayLoading
//
//  Created by ios on 2019/1/23.
//  Copyright © 2019年 KN. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YZWeakProxy : NSProxy

+ (instancetype)proxyWithTarget: (id)target;

@end
