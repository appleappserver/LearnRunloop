//
//  TimerViewController.m
//  LearnDelayLoading
//
//  Created by ios on 2019/1/23.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "TimerViewController.h"
#import "DelayViewController.h"
#import "YZWeakProxy.h"

@interface TimerViewController ()

// 定时器
@property(nonatomic,weak)NSTimer *timer;

@end

@implementation TimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    UIButton *button = [[UIButton alloc]initWithFrame:(CGRectMake(0, 0, 200, 200))];
    [button setCenter:self.view.center];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [button setTitle:@"Push" forState:(UIControlStateNormal)];
    [button.layer setCornerRadius:10.0f];
    [button.layer setMasksToBounds:true];
    [button setBackgroundColor:[UIColor brownColor]];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
    
    // 第二种方案
    YZWeakProxy *proxy = [YZWeakProxy proxyWithTarget:self];
     _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(delay) userInfo:nil repeats:true];
}
//// 解决方案1  满足不了push新vc时继续工作的需求
//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    // 当repeats的值为True时会造成循环引用
//    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(delay) userInfo:nil repeats:true];
//}
//
//- (void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    [_timer invalidate];
//}

- (void)delay
{
    NSLog(@"delay");
}

- (void)buttonClick
{
    DelayViewController *vc = [[DelayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)dealloc
{
    [_timer invalidate];
    NSLog(@"TimerViewController dealloc");
}
@end
