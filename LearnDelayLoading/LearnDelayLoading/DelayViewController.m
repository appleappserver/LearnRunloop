//
//  DelayViewController.m
//  LearnDelayLoading
//
//  Created by ios on 2019/1/23.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "DelayViewController.h"

typedef void(^PDDelayedBlockHandle)(BOOL cancel);

@interface DelayViewController ()

// 定时器
@property(nonatomic,weak)NSTimer *timer;

// 子线程
@property(nonatomic,strong)NSThread *thread;

// 自定义取消GCD延时加载
@property (nonatomic, weak) PDDelayedBlockHandle delayedBlockHandle;


@end

@implementation DelayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    static int i = 0;
    if (i % 2 == 0) {
        NSLog(@"delay load");
        // 1. 第一种
        [self performSelector:@selector(delay:) withObject:@"performSelector" afterDelay:2.0f];
        
        // 2. 第二种
        _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(delay:) userInfo:@"NSTimer" repeats:true];
        
        // 3. 第三种 放入子线程防止阻塞主线程
        _thread = [[NSThread alloc]initWithTarget:self selector:@selector(threadDelay) object:nil];
        [_thread start];
        
        // 4. 第四种
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self delay:@"GCD"];
        });
        // 执行
        _delayedBlockHandle = perform_block_after_delay(2.0f, ^{
            [self delay:@"CustomGCD"];
        });
        
    }else {
        NSLog(@"cancel");
        // 1. 第一种取消 需要在主线程取消 参数需要完全相同
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(delay:) object:@"performSelector"];
//        [NSObject cancelPreviousPerformRequestsWithTarget:self];
        
        // 2. 第二种取消
        [_timer invalidate];
        
        // 3. 第三种取消 无效  应该还有办法解决
        NSLog(@"%i",[_thread isCancelled]);
        [_thread cancel];
        NSLog(@"%i",[_thread isCancelled]);
        
        // 4. 第四种取消
        cancel_delayed_block(_delayedBlockHandle);
//        _delayedBlockHandle = nil;
    }
    
    i++;
   
}

// 提供了GCD取消的思路

static void cancel_delayed_block(PDDelayedBlockHandle delayedHandle) {
    if (nil == delayedHandle) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        delayedHandle(YES);
    });
}

static PDDelayedBlockHandle perform_block_after_delay(CGFloat seconds, dispatch_block_t block) {
    if (block == nil) {
        return nil;
    }
    
    __block dispatch_block_t blockToExecute = [block copy];
    __block PDDelayedBlockHandle delayHandleCopy = nil;
    
    PDDelayedBlockHandle delayHandle = ^(BOOL cancel) {
        if (!cancel && blockToExecute) {
            blockToExecute();
        }
        
        // Once the handle block is executed, canceled or not, we free blockToExecute and the handle.
        // Doing this here means that if the block is canceled, we aren't holding onto retained objects for any longer than necessary.
#if !__has_feature(objc_arc)
        [blockToExecute release];
        [delayHandleCopy release];
#endif
        
        blockToExecute = nil;
        delayHandleCopy = nil;
    };
    // delayHandle also needs to be moved to the heap.
    delayHandleCopy = [delayHandle copy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, seconds * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        if (nil != delayHandleCopy) {
            delayHandleCopy(NO);
        }
    });
    
    return delayHandleCopy;
}

- (void)threadDelay
{
    [NSThread sleepForTimeInterval:2.0];
    [self delay:@"NSThread"];
}

- (void)delay:(NSString *)method
{
    NSLog(@"%@ 延迟加载,%@",self,method);
}

- (void)dealloc
{
    NSLog(@"DelayViewController dealloc");
}
@end
