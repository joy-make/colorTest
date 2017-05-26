# colorTest [文档:http://www.jianshu.com/p/6bfe19255333]
 实现如下效果
![](http://upload-images.jianshu.io/upload_images/1488115-9e6e41b64c297024.gif?imageMogr2/auto-orient/strip)
```
#import "ViewController.h"
@interface ViewController ()
{
CAGradientLayer *gradientLayer;
}
@end
```
```
@implementation ViewController
- (void)viewDidLoad {
[super viewDidLoad];
UILabel *label = [[UILabel alloc] init];
label.numberOfLines = 0;
label.text = @"定时器快速切换渐变颜色,达到文字颜色变化效果";
[label sizeToFit];
label.center = CGPointMake(200, 100);    // 疑问：label只是用来做文字裁剪，能否不添加到view上。
// 必须要把Label添加到view上，如果不添加到view上，label的图层就不会调用drawRect方法绘制文字，也就没有文字裁剪了。
// 如何验证，自定义Label,重写drawRect方法，看是否调用,发现不添加上去，就不会调用
[self.view addSubview:label];    
// 创建渐变层
gradientLayer = [CAGradientLayer layer];
//设置渐变的开始位置、结束位置两个点儿，范围是（0,0）->(1,1)
gradientLayer.endPoint = CGPointMake(1, 0);
gradientLayer.startPoint = CGPointMake(0, 0);
gradientLayer.frame = label.frame;    // 设置渐变层的颜色，随机颜色渐变
gradientLayer.colors = @[(id)[self randomColor].CGColor, (id)[self randomColor].CGColor,(id)[self randomColor].CGColor];    
// 疑问:渐变层能不能加在label上
// 不能，mask原理：默认会显示mask层底部的内容，如果渐变层放在mask层上，就不会显示了
// 添加渐变层到控制器的view图层上
[self.view.layer addSublayer:gradientLayer];    // mask层工作原理:按照透明度裁剪，只保留非透明部分，文字就是非透明的，因此除了文字，其他都被裁剪掉，这样就只会显示文字下面渐变层的内容，相当于留了文字的区域，让渐变层去填充文字的颜色。
// 设置渐变层的裁剪层
/* 注意:一旦把label层设置为mask层，label层就不能显示了,会直接从父层中移除，然后作为渐变层的mask层，且label层的父层会指向渐变层，这样做的目的：以渐变层为坐标系，方便计算裁剪区域，如果以其他层为坐标系，还需要做点的转换，需要把别的坐标系上的点，转换成自己坐标系上点，判断当前点在不在裁剪范围内，比较麻烦。父层改了，坐标系也就改了，需要重新设置label的位置，才能正确的设置裁剪区域。*/
gradientLayer.mask = label.layer; 
label.frame = gradientLayer.bounds;    
// 利用定时器，快速的切换渐变颜色，就有文字颜色变化效果
CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
[link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];    // 随机颜色方法
}

// 很显然，我们实际开发时基本不可能通过切换颜色来达到这种效果于是还有一种方式是通过不断改变分割点达到的，如下
```
static float progress = 0;
- (void)update{
progress =progress +=1>100?1: progress;
gradientLayer.locations = @[@(0.0f), @(progress/100)];
}
```
