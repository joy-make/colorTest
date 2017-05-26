//
//  UIView+ColorCategory.m
//  colortest
//
//  Created by wangguopeng on 2017/5/22.
//  Copyright © 2017年 joymake. All rights reserved.
//

#import "UIView+ColorCategory.h"
#import <objc/runtime.h>

static const NSString *key = @"key";
@implementation UIView (ColorCategory)
- (void)addColorWithStartPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    objc_setAssociatedObject(self, _cmd, gradientLayer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    gradientLayer.endPoint = endPoint;
    gradientLayer.startPoint = startPoint;
    gradientLayer.frame = self.frame;
    gradientLayer.colors = @[(id)[UIColor blueColor].CGColor,
                             (id)[UIColor redColor].CGColor,
                             (id)[UIColor yellowColor].CGColor];
    [self.superview.layer addSublayer:gradientLayer];
    gradientLayer.mask = self.layer;
    self.frame = gradientLayer.bounds;    // 利用定时器，快速的切换渐变颜色，就有文字颜色变化效果
    NSTimer *_timer = [NSTimer scheduledTimerWithTimeInterval:0.02 target:self selector:@selector(update) userInfo:@"" repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:UITrackingRunLoopMode];
    [_timer fire];
    objc_setAssociatedObject(self, &key, _timer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIColor *)randomColor{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

static float progress = 0;
// 定时器触发方法
- (void)update{
    CAGradientLayer *gradientLayer = objc_getAssociatedObject(self, @selector(addColorWithStartPoint:endPoint:));
    progress +=1;
    if (progress>100) {
        progress = 1;
    }
    //定时改变分割点
    gradientLayer.locations = @[@(0.0f), @(progress/100)];
}

-(void)cancle{
    NSTimer *_timer = objc_getAssociatedObject(self, &key);
    [_timer invalidate];
    _timer = nil;
}
@end
