//
//  CPTaskScreenBlur.h
//  CPTaskScreenBlur
//

#import <UIKit/UIKit.h>

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 实现后台模糊功能
 */
@interface CPTaskScreenBlur : NSObject

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 是否开启自动模糊，开启后不需要调用显式showBlur/hideBlur
 *  @param autoBlur 是否开启自动模糊
 */
+(void) enableAutoBlur:(BOOL)autoBlur inWindow:(UIWindow*)window;

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 显示模糊
 *  @param view 需要模糊化的窗体
 */
+(void) showBlurInView:(UIView*)view;

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 隐藏模糊
 */
+(void) hideBlur;

/*!
 *  @author LeiQiao, 16-02-25
 *  @brief 设置模糊程度
 *  @param blurRadius 模糊程度(1-100)，默认40
 */
+(void) setBlurRadius:(int)blurRadius;

/*!
 *  @author LeiQiao, 16-03-15
 *  @brief 设置模糊动画，默认关闭
 *  @param blurAnimationEnabled 是否开启模糊动画
 */
+(void) setBlurAnimation:(BOOL)blurAnimationEnabled;

@end
