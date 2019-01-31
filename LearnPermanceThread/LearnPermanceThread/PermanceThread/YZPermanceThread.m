//
//  YZPermanceThread.m
//  LearnPermanceThread
//
//  Created by ios on 2019/1/31.
//  Copyright © 2019 KN. All rights reserved.
//

#import "YZPermanceThread.h"

@interface YZThread : NSThread

@end

@implementation YZThread

- (void)dealloc
{
    NSLog(@"%s",__func__);
}

@end

@interface YZPermanceThread()

// 子线程
@property(nonatomic,strong)YZThread *thread;

@end

@implementation YZPermanceThread

- (instancetype)init
{
    if (self == [super init]) {
        [self initThread];
    }
    return self;
}

- (void)run
{
    if (!_thread) return;
    if ([_thread isExecuting]) return;
    [_thread start];
}

- (void)excuteBlock:(YZPermanceBlock)block
{
    if (block == nil) return;
    if (!_thread) return;
    [self performSelector:@selector(__excuteBlock:) onThread:_thread withObject:block waitUntilDone:false];
    
}

- (void)stop
{
    if (!_thread) return;
    if (![_thread isExecuting]) return;
    [self performSelector:@selector(__stop) onThread:_thread withObject:nil waitUntilDone:true];
    _thread = nil;
}

#pragma mark -- private mathod
- (void)initThread
{
    _thread = [[YZThread alloc] initWithBlock:^{
        NSLog(@"start -----");
        CFRunLoopSourceContext context = {0};
        CFRunLoopSourceRef source = CFRunLoopSourceCreate(kCFAllocatorDefault, 0, &context);
        CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
        CFRelease(source);
        // RunLoop没有Sources/Timers/Observe是无法运行的
        CFRunLoopRunInMode(kCFRunLoopDefaultMode, 1.0e10, false);
        NSLog(@"end -----");
    }];
}

- (void)__excuteBlock:(YZPermanceBlock)block
{
    block();
}

- (void)__stop
{
    CFRunLoopStop(CFRunLoopGetCurrent());
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
    [self stop];
}

@end
