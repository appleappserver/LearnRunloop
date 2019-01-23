//
//  ViewController.m
//  LearnDelayLoading
//
//  Created by ios on 2019/1/23.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "ViewController.h"
#import "DelayViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    DelayViewController *vc = [[DelayViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
