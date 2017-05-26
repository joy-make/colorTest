
## colorTest [文档:http://www.jianshu.com/p/6bfe19255333]
实现效果如下
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
  gradientLayer = [CAGradientLayer layer];
  gradientLayer.endPoint = CGPointMake(1, 0);
  gradientLayer.startPoint = CGPointMake(0, 0);
  gradientLayer.frame = label.frame;
  gradientLayer.colors = @[(id)[UIColor blueColor].CGColor, (id)[UIColor greenColor].CGColor,(id)[UIColor redColor].CGColor]; 
  [self.view.layer addSublayer:gradientLayer];
  gradientLayer.mask = label.layer; 
  label.frame = gradientLayer.bounds;    
  CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
  [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode]; 
}
```
```
static float progress = 0;
- (void)update{
  progress =progress +=1>100?1: progress;
  gradientLayer.locations = @[@(0.0f), @(progress/100)];
}
```
