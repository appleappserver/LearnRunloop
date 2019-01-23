//
//  ViewController.m
//  LearnDelayLoading
//
//  Created by ios on 2019/1/23.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "ViewController.h"
#import "DelayViewController.h"
#import "TimerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc]initWithFrame:(CGRectMake(0, 0, 200, 200))];
    [button setCenter:self.view.center];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [button.titleLabel setFont:[UIFont systemFontOfSize:24]];
    [button setTitle:@"NSTimer" forState:(UIControlStateNormal)];
    [button.layer setCornerRadius:10.0f];
    [button.layer setMasksToBounds:true];
    [button setBackgroundColor:[UIColor grayColor]];
    [button addTarget:self action:@selector(buttonClick) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:button];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DelayViewController *vc = [[DelayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)buttonClick
{
    TimerViewController *vc = [[TimerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
