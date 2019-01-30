//
//  ViewController.m
//  LearnRunloop
//
//  Created by ios on 2019/1/30.
//  Copyright © 2019 KN. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

void observerRunloopStute(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info)
{
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"即将进入runloop");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"即将处理Timer");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"即将处理Source");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"即将进入休眠");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"即将唤醒runloop");
            break;
        case kCFRunLoopExit:
            NSLog(@"runloop 退出");
            break;
        default:
            break;
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    CFRunLoopRef runloop = CFRunLoopGetMain();
    NSLog(@"%@",runloop);
    CFRelease(runloop);
    
    CFRunLoopObserverRef observerRef = CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, observerRunloopStute, nil);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observerRef, kCFRunLoopCommonModes);
    CFRelease(observerRef);
    
    CFRunLoopObserverRef ref = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, kCFRunLoopAllActivities, true, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
                NSLog(@"runloop 进入");
                break;
            case kCFRunLoopExit:
                NSLog(@"runloop 退出");
                break;
                
            default:
                break;
        }
    });
    CFRelease(ref);
}

- (void)delay
{
    NSLog(@"%s",__func__);
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self performSelector:@selector(delay) withObject:nil afterDelay:3.0];
    
    NSLog(@"click screen");
}

@end
