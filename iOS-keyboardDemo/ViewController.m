
/*!
 *  @header BAKit.h
 *          BABaseProject
 *
 *  @brief  BAKit
 *
 *  @author 博爱
 *  @copyright    Copyright © 2016年 博爱. All rights reserved.
 *  @version    V1.0
 */

//                            _ooOoo_
//                           o8888888o
//                           88" . "88
//                           (| -_- |)
//                            O\ = /O
//                        ____/`---'\____
//                      .   ' \\| |// `.
//                       / \\||| : |||// \
//                     / _||||| -:- |||||- \
//                       | | \\\ - /// | |
//                     | \_| ''\---/'' | |
//                      \ .-\__ `-` ___/-. /
//                   ___`. .' /--.--\ `. . __
//                ."" '< `.___\_<|>_/___.' >'"".
//               | | : `- \`.;`\ _ /`;.`/ - ` : | |
//                 \ \ `-. \_ __\ /__ _/ .-` / /
//         ======`-.____`-.___\_____/___.-`____.-'======
//                            `=---='
//
//         .............................................
//                  佛祖镇楼                  BUG辟易
//          佛曰:
//                  写字楼里写字间，写字间里程序员；
//                  程序人员写程序，又拿程序换酒钱。
//                  酒醒只在网上坐，酒醉还来网下眠；
//                  酒醉酒醒日复日，网上网下年复年。
//                  但愿老死电脑间，不愿鞠躬老板前；
//                  奔驰宝马贵者趣，公交自行程序员。
//                  别人笑我忒疯癫，我笑自己命太贱；
//                  不见满街漂亮妹，哪个归得程序员？

/*
 
 *********************************************************************************
 *
 * 在使用BAKit的过程中如果出现bug请及时以以下任意一种方式联系我，我会及时修复bug
 *
 * QQ     : 可以添加SDAutoLayout群 497140713 在这里找到我(博爱1616【137361770】)
 * 微博    : 博爱1616
 * Email  : 137361770@qq.com
 * GitHub : https://github.com/boai
 * 博客园  : http://www.cnblogs.com/boai/
 * 博客    : http://boai.github.io
 
 *********************************************************************************
 
 */


#import "ViewController.h"
#import "BAReplyView.h"
#import "proView.h"


#define KCOLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#pragma mark - ***** frame设置
// 当前设备的屏幕宽度
#define KSCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
// 当前设备的屏幕高度
#define KSCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height



@interface ViewController ()

@property (nonatomic, strong) BAReplyView *replyView;
@property (nonatomic, strong) UIButton *notBtn;

@property (nonatomic, strong) proView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"博爱键盘处理demo";
    
    self.replyView.hidden = NO;
    
    self.progressView.hidden = NO;
    

}

- (BAReplyView *)replyView
{
    if (!_replyView)
    {
        CGRect frame = CGRectMake(0, self.view.frame.size.height - 50, self.view.frame.size.width, 50);
        _replyView = [[BAReplyView alloc] initWithFrame:frame withImage:nil withPlaceHolder:@"聊天"  callBackIndex:^(NSString *contentStr) {
            
            if(contentStr.length > 0)
            {
                NSLog(@"发送内容：%@", contentStr);
                
            }
            else
            {
                
            }
            
        }];
        _replyView.backgroundColor = KCOLOR(245, 244, 245, 1.0);
        [self.view addSubview:_replyView];
        
        /*! 创建view的时候就注册键盘通知 */
        [_replyView registNotification];
    }
    return _replyView;
}

- (void)dealloc
{
    /*! 记得移除通知哈！ */
    [_replyView removeNotification];
}

// 点击空白-键盘收回
//-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
////    [self.view endEditing:YES];
//    self.progressView.progress += (arc4random() % 4 + 1) * 0.1;
//
//}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
//    self.progressView.progress += (arc4random() % 4 + 1) * 0.1;
    //    self.circleProgressView.progress = 0.5;
}

- (proView *)progressView
{
    if (!_progressView)
    {
        _progressView = [[proView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
//        _progressView.frame = CGRectMake(100, 100, 200, 200);
        _progressView.backgroundColor = [UIColor greenColor];
        _progressView.progress = 0.2;
        [self.view addSubview:_progressView];
        
        UISlider * slider = [[UISlider alloc]initWithFrame:CGRectMake(10, 400, KSCREEN_WIDTH - 20, 10)];
        [slider addTarget:self action:@selector(changeProgress:) forControlEvents:UIControlEventValueChanged];
        slider.maximumValue = 1.0;
        slider.minimumValue = 0.f;
        slider.value = self.progressView.progress;
        [self.view addSubview:slider];
    }
    return _progressView;
}

- (void)changeProgress:(UISlider *)slider
{
    self.progressView.progress = slider.value;
    //    [self.circleProgressView setNeedsDisplay];
}



@end
