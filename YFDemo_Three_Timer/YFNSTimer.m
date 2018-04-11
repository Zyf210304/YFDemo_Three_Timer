//
//  YFNSTimer.m
//  YFDemo_Three_Timer
//
//  Created by 亚飞 on 2018/4/11.
//  Copyright © 2018年 yafei. All rights reserved.
//

#import "YFNSTimer.h"

@interface YFNSTimer ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation YFNSTimer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self creatTimer];
}

- (void)creatTimer {

    _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerStart:) userInfo:nil repeats:YES];

    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];

    [_timer fire];

}

- (void)timerStart:(NSTimer *)timer {
    NSLog(@"%s -- %lf", __func__, timer.timeInterval);
}


- (void)viewWillDisappear:(BOOL)animated {
    [_timer invalidate];
    _timer = nil;
}

/*
 解释：
 TimerInterval: 执行之前等待的时间。比如设置成1.0，就代表1秒后执行方法
 target: 需要执行方法的对象。
 selector : 需要执行的方法
 repeats : 是否需要循环

 注意 :
 ->调用创建方法后，target对象的计数器会加1，直到执行完毕，自动减1。如果是循环执行的话，就必须手动关闭，否
 则可以不执行释放方法。

 特性：
 ->存在延迟
 不管是一次性的还是周期性的timer的实际触发事件的时间，都会与所加入的RunLoop和RunLoop Mode有关，如果此
 RunLoop正在执行一个连续性的运算，timer就会被延时出发。重复性的timer遇到这种情况，如果延迟超过了一个周
 期，则会在延时结束后立刻执行，并按照之前指定的周期继续执行。
 ->必须加入Runloop
 使用上面的创建方式，会自动把timer加入MainRunloop的NSDefaultRunLoopMode中。如果使用以下方式创建定时
 器，就必须手动加入Runloop:
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
