//
//  YFSourceTimer.m
//  YFDemo_Three_Timer
//
//  Created by 亚飞 on 2018/4/11.
//  Copyright © 2018年 yafei. All rights reserved.
//

#import "YFSourceTimer.h"

@interface YFSourceTimer ()
@property (nonatomic, strong) dispatch_source_t sourceTimer;
@end

@implementation YFSourceTimer

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)createTimer {
    //创建全局队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    //使用全局队列创建定时器
    _sourceTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);

    //定时器延迟时间
    NSTimeInterval delayTime = 1.0f;

    //定时器间隔时间
    NSTimeInterval timeInterval = 1.0f;

    //设置开始时间
    dispatch_time_t startDelayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime *NSEC_PER_SEC));

    //设置定时器
    dispatch_source_set_timer(_sourceTimer, DISPATCH_TIME_NOW, timeInterval * NSEC_PER_SEC, .01 * NSEC_PER_SEC);

    //执行事件
    dispatch_source_set_event_handler(_sourceTimer, ^{
        //销毁定时器
        //dispatch_source_cancel(_myTimer);
    });

    //启动定时器
    dispatch_resume(_sourceTimer);
}

/*
 特性：

 默认是重复执行的，可以在事件响应回调中通过dispatch_source_cancel方法来设置为只执行一次，如下代码:
 dispatch_source_set_event_handler(_timer, ^{
 //执行事件
 dispatch_source_cancel(_timer);}
 );
 重要属性：

 dispatch_source_set_timer(dispatch_source_t source,
 dispatch_time_t start,
 uint64_t interval,
 uint64_t leeway);
 start计时器起始时间，可以通过dispatch_time创建，如果使用DISPATCH_TIME_NOW，则创建后立即执行
 interval计时器间隔时间，可以通过timeInterval * NSEC_PER_SEC来设置，其中，timeInterval为对应的秒数
 leeway这个参数的理解，我觉得http://www.dreamingwish.com上Seven‘s同学的解释很直观也很易懂：“这个参数告诉系统我们需要计时器触发的精准程度。所有的计时器都不会保证100%精准，这个参数用来告诉系统你希望系统保证精准的努力程度。如果你希望一个计时器没五秒触发一次，并且越准越好，那么你传递0为参数。另外，如果是一个周期性任务，比如检查email，那么你会希望每十分钟检查一次，但是不用那么精准。所以你可以传入60，告诉系统60秒的误差是可接受的。这样有什么意义呢？简单来说，就是降低资源消耗。如果系统可以让cpu休息足够长的时间，并在每次醒来的时候执行一个任务集合，而不是不断的醒来睡去以执行任务，那么系统会更高效。如果传入一个比较大的leeway给你的计时器，意味着你允许系统拖延你的计时器来将计时器任务与其他任务联合起来一起执行。
 优点：

 时间准确
 可以使用子线程，解决定时间跑在主线程上卡UI问题
 注意事项：

 需要将dispatch_source_t timer设置为成员变量，不然会立即释放

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
