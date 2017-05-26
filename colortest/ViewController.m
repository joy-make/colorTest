//
//  ViewController.m
//  colortest
//
//  Created by wangguopeng on 2017/5/22.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "ViewController.h"
#import "UIView+ColorCategory.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, [UIScreen mainScreen].bounds.size.width-200, 100)];
    label.numberOfLines = 0;
    label.text = @"定时器快速切换渐变颜色,达到文字颜色变化效果";
    [label sizeToFit];
    [self.view addSubview:label];
    [label addColorWithStartPoint:CGPointMake(0, 0) endPoint:CGPointMake(1, 0)];
}
@end
