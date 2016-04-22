//
//  CPTaskScreenBlur.m
//  CPTaskScreenBlur
//

#import "CPTaskScreenBlur.h"
#import "FXBlurView.h"

const int kDefaultBlurRadius = 40;      /*!< 默认的模糊程度 */

@interface CPTaskScreenBlur()

@property(nonatomic, weak) UIWindow* window;    /*!< 程序的window */
@property(nonatomic) int blurRadius;            /*!< 模糊程度 */
@property(nonatomic) BOOL blurAnimation;        /*!< 模糊动画 */

@end

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 实现后台模糊功能
 */
@implementation CPTaskScreenBlur {
    FXBlurView* _blurView;          /*!< 处理模糊效果的视图 */
}

#pragma mark
#pragma mark shareInstance

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 获取后台模糊操作对象
 *  @return 后台模糊操作对象
 */
+(CPTaskScreenBlur*) shareInstance
{
    static CPTaskScreenBlur* sTaskScreenBlur = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sTaskScreenBlur = [[CPTaskScreenBlur alloc] init];
        sTaskScreenBlur.blurRadius = kDefaultBlurRadius;
    });
    return sTaskScreenBlur;
}

#pragma mark
#pragma mark init & dealloc

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark
#pragma mark member functions

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 显示模糊
 */
-(void) showBlur
{
    [self showBlurInView:self.window];
}

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 显示模糊
 *  @param view 需要模糊化的窗体
 */
-(void) showBlurInView:(UIView*)view
{
    // 如果该窗体已经模糊则退出
    if( _blurView.superview == view )
    {
        // 将模糊效果置于窗体最上面
        [view bringSubviewToFront:_blurView];
        return;
    }
    
    // 重新绘制模糊效果
    _blurView = [[FXBlurView alloc] initWithFrame:view.bounds];
    _blurView.backgroundColor = [UIColor clearColor];
    _blurView.tintColor = [UIColor clearColor];
    [view addSubview:_blurView];
    
    _blurView.dynamic = YES;
    _blurView.blurRadius = self.blurRadius;
    [_blurView setNeedsDisplay];
}



/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 隐藏模糊
 */
-(void) hideBlur
{
    // 如果已经删除则跳过
    if( !_blurView ) return;
    
    FXBlurView* bview = _blurView;
    _blurView = nil;
    
    if( self.blurAnimation )
    {
        // 渐变删除
        [UIView animateWithDuration:0.3 animations:^{
            bview.blurRadius = 0;
        } completion:^(BOOL finished) {
            if( finished )
            {
                [bview removeFromSuperview];
            }
        }];
    }
    else
    {
        // 直接删除
        [bview removeFromSuperview];
    }
}

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 是否开启自动模糊，开启后不需要调用显式showBlur/hideBlur
 *  @param autoBlur 是否开启自动模糊
 */
+(void) enableAutoBlur:(BOOL)autoBlur inWindow:(UIWindow*)window
{
    [[self class] shareInstance].window = window;
    
    // 是否开启自动模糊
    if( autoBlur )
    {
        // 添加切换到后台的监听
        [[NSNotificationCenter defaultCenter] addObserver:[[self class] shareInstance]
                                                 selector:@selector(showBlur)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
        
        // 添加切换到前台的监听
        [[NSNotificationCenter defaultCenter] addObserver:[[self class] shareInstance]
                                                 selector:@selector(hideBlur)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
    }
    else
    {
        // 不开启自动模糊则删除后台监听，需要手动调用showBlur/hideBlur
        [[NSNotificationCenter defaultCenter] removeObserver:[[self class] shareInstance]];
    }
}

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 显示模糊
 */
+(void) showBlurInView:(id)view
{
    [[[self class] shareInstance] showBlurInView:view];
}

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 隐藏模糊
 */
+(void) hideBlur
{
    [[[self class] shareInstance] hideBlur];
}

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 设置模糊程度
 *  @param blurRadius 模糊程度(1-100)
 */
+(void) setBlurRadius:(int)blurRadius
{
    [[self class] shareInstance].blurRadius = blurRadius;
}

/*!
 *  @author LeiQiao, 16-03-15
 *  @brief 设置模糊动画
 *  @param blurAnimationEnabled 是否开启模糊动画
 */
+(void) setBlurAnimation:(BOOL)blurAnimationEnabled
{
    [[self class] shareInstance].blurAnimation = blurAnimationEnabled;
}

@end
