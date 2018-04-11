//
//  YFCADisplayLink.m
//  YFDemo_Three_Timer
//
//  Created by 亚飞 on 2018/4/11.
//  Copyright © 2018年 yafei. All rights reserved.
//

#import "YFCADisplayLink.h"

@interface YFCADisplayLink ()
@property (strong,nonatomic)CADisplayLink *displaylinkTimer;
@end

@implementation YFCADisplayLink

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)createCADisplayLink {
    _displaylinkTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(handleDisplayLink:)];
    [_displaylinkTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)handleDisplayLink:(CADisplayLink *)displaylinkTimer {
    NSLog(@"%s -- %ld", __func__, displaylinkTimer.preferredFramesPerSecond);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_displaylinkTimer invalidate];
    _displaylinkTimer = nil;
}
/*
 解释：

 当把CADisplayLink对象add到runloop中后，selector就能被周期性调用，类似于重复的NSTimer被启动了；执行invalidate操作时，CADisplayLink对象就会从runloop中移除，selector调用也随即停止，类似于NSTimer的invalidate方法。

 特性：
 屏幕刷新时调用CADisplayLink是一个能让我们以和屏幕刷新率同步的频率将特定的内容画到屏幕上的定时器类。CADisplayLink以特定模式注册到runloop后，每当屏幕显示内容刷新结束的时候，runloop就会向CADisplayLink指定的target发送一次指定的selector消息， CADisplayLink类对应的selector就会被调用一次。所以通常情况下，按照iOS设备屏幕的刷新率60次/秒
 延迟iOS设备的屏幕刷新频率是固定的，CADisplayLink在正常情况下会在每次刷新结束都被调用，精确度相当高。但如果调用的方法比较耗时，超过了屏幕刷新周期，就会导致跳过若干次回调调用机会。如果CPU过于繁忙，无法保证屏幕60次/秒的刷新率，就会导致跳过若干次调用回调方法的机会，跳过次数取决CPU的忙碌程度。

 使用场景：
 从原理上可以看出，CADisplayLink适合做界面的不停重绘，比如视频播放的时候需要不停地获取下一帧用于界面渲染。
 重要属性：
 frameInterval(已过时，用preferredFramesPerSecond替代)  NSInteger类型的值，用来设置间隔多少帧调用一次selector方法，默认值是1，即每帧都调用一次。
 duration  readOnly的CFTimeInterval值，表示两次屏幕刷新之间的时间间隔。需要注意的是，该属性在target的selector被首次调用以后才会被赋值。selector的调用间隔时间计算方式是：调用间隔时间 = duration × frameInterval
 */



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
