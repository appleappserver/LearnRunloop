//
//  SecondViewController.m
//  LearnPermanceThread
//
//  Created by ios on 2019/1/31.
//  Copyright © 2019 KN. All rights reserved.
//

#import "SecondViewController.h"
#import "YZPermanceThread.h"

@interface SecondViewController ()

// 永久线程
@property(nonatomic,strong)YZPermanceThread *thread;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _thread = [[YZPermanceThread alloc] init];
    [_thread run];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_thread excuteBlock:^{
        NSLog(@"%@",[NSThread currentThread]);
    }];
}

- (IBAction)stopThread:(id)sender {
    [_thread stop];
}

- (void)dealloc
{
    NSLog(@"%s",__func__);
}


@end
