//
//  YZWeakProxy.m
//  LearnDelayLoading
//
//  Created by ios on 2019/1/23.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "YZWeakProxy.h"

@interface YZWeakProxy()

// target
@property(nonatomic, weak, readonly) id target;

@end

@implementation YZWeakProxy

- (instancetype)initWithTarget:(id)target
{
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target
{
    return [[self alloc] initWithTarget:target];
}

// 当一个SEL到来的时候，在这里返回SEL对应的NSMethodSignature
// 1.查询该方法的方法签名
- (NSMethodSignature*)methodSignatureForSelector:(SEL)sel
{
    return [_target methodSignatureForSelector:sel];
}

// 2.有了方法签名之后就会调用方法实现
- (void)forwardInvocation:(NSInvocation *)invocation
{
    if ([_target respondsToSelector:invocation.selector]) {
        [invocation invokeWithTarget:_target];
    }
}

- (NSUInteger)hash
{
    return [_target hash];
}

- (Class)superclass
{
    return [_target superclass];
}

- (Class)class
{
    return [_target class];
}

- (BOOL)isKindOfClass:(Class)aClass
{
    return [_target isKindOfClass:aClass];
}

- (BOOL)isMemberOfClass:(Class)aClass
{
    return [_target isMemberOfClass:aClass];
}

- (BOOL)conformsToProtocol:(Protocol *)aProtocol
{
    return [_target conformsToProtocol:aProtocol];
}

- (BOOL)isProxy
{
    return YES;
}

- (NSString *)description
{
    return [_target description];
}

- (NSString *)debugDescription
{
    return [_target debugDescription];
}

@end
