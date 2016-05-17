
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


#import "BAReplyView.h"

// 字体
#define KFontSize(fontSize) [UIFont systemFontOfSize:fontSize]

#pragma mark - ***** frame设置
// 当前设备的屏幕宽度
#define KSCREEN_WIDTH    [[UIScreen mainScreen] bounds].size.width
// 当前设备的屏幕高度
#define KSCREEN_HEIGHT   [[UIScreen mainScreen] bounds].size.height

@implementation BAReplyView


#pragma mark - 初始化
- (instancetype)initWithFrame:(CGRect)frame withImage:(NSString *)imageName withPlaceHolder:(NSString *) placeHolder callBackIndex:(cilckIndexBlock)clickIndex
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.clickIndexBlock = clickIndex;
        self.placeHolder     = placeHolder;
        imageNameStr         = imageName;
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView
{
    userImageView                         = [UIImageView new];
    userImageView.backgroundColor = [UIColor redColor];
//    NSString *myPhotoURL                  = imageNameStr;
//    [userImageView sd_setImageWithURL:[NSURL URLWithString:myPhotoURL] placeholderImage:[UIImage imageNamed:@"userImage_placeholder"] options:0];
    userImageView.layer.masksToBounds     = YES;
    userImageView.layer.cornerRadius      = 40/2;
    userImageView.frame = CGRectMake(5, 5, 40, 40);
    
    self.replyTextField                   = [UITextField new];
    self.replyTextField.borderStyle       = UITextBorderStyleRoundedRect;
    self.replyTextField.delegate          = self;
    self.replyTextField.placeholder       = self.placeHolder;
    self.replyTextField.frame = CGRectMake(CGRectGetMaxX(userImageView.frame) + 5, 5, KSCREEN_WIDTH - 50 - 60, 40);
    
    sendButton                            = [UIButton buttonWithType:UIButtonTypeCustom];
    sendButton.layer.cornerRadius         = 5.0f;
    sendButton.layer.borderWidth          = 1.0;
    sendButton.layer.borderColor          = [UIColor lightGrayColor].CGColor;
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    sendButton.titleLabel.font            = KFontSize(15);
    [sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
    sendButton.frame = CGRectMake(KSCREEN_WIDTH - 55, 5, 50, 40);
    
    NSArray *subViews = @[userImageView, self.replyTextField, sendButton];
    [subViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        if ([view isKindOfClass:[UIView class]]) {
            [self addSubview:view];
        }
    }];
}

- (IBAction)sendMessage:(UIButton *)sender
{
    if (self.clickIndexBlock)
    {
        self.clickIndexBlock(self.replyTextField.text);
        self.replyTextField.text = @"";
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

/*! 先注册通知，然后实现具体当键盘弹出来要做什么，键盘收起来要做什么 */
-(void)registNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)removeNotification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/*! 键盘显示要做什么 */
- (void)keyboardWasShown:(NSNotification *)notification
{
    NSDictionary *info                                  = [notification userInfo];
    
    double duration                                     = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    CGFloat curkeyBoardHeight                           = [[info objectForKey:@"UIKeyboardBoundsUserInfoKey"] CGRectValue].size.height;
    CGRect begin                                        = [[info objectForKey:@"UIKeyboardFrameBeginUserInfoKey"] CGRectValue];
    CGRect end                                          = [[info objectForKey:@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    
    CGFloat keyBoardHeight;
    
    /*! 第三方键盘回调三次问题，监听仅执行最后一次 */
    if(begin.size.height > 0 && (begin.origin.y - end.origin.y > 0))
    {
        keyBoardHeight                                  = curkeyBoardHeight;
        [UIView animateWithDuration:duration animations:^{
            
            CGRect viewFrame                            = [self getCurrentViewController].view.frame;
            viewFrame.origin.y -= keyBoardHeight;
            [self getCurrentViewController].view.frame = viewFrame;
        }];
    }
}

- (void)keyboardWasHidden:(NSNotification *)notification
{
    NSDictionary *info = [notification userInfo];
    double duration = [info[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration animations:^{
        
        CGRect viewFrame = [self getCurrentViewController].view.frame;
        viewFrame.origin.y = 0;
        [self getCurrentViewController].view.frame = viewFrame;
    }];
}

/*!
 *  获取当前View的VC
 *
 *  @return 获取当前View的VC
 */
- (UIViewController *)getCurrentViewController
{
    for (UIView *view = self; view; view = view.superview)
    {
        UIResponder *nextResponder = [view nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

@end
