# CPTaskScreenBlur
实现程序切换到后台时页面变模糊的功能

# Supported iOS & SDK Versions
* iOS 7+
* XCode 6.4

# ARC Compatibility
支持ARC

# Installation
`pod 'CPTaskScreenBlur', '~0.0.1'`

# Usage
`+(void) enableAutoBlur:(BOOL)autoBlur inWindow:(UIWindow*)window;`<br/>
自动模糊，在需要的时候（比如登录登出后）调用这个方法。<br/>
<br/>
`+(void) showBlurInView:(UIView*)view;`<br/>
`+(void) hideBlur;`<br/>
手动设置显示关闭模糊效果。<br/>
<br/>
`+(void) setBlurRadius:(int)blurRadius;`<br/>
设置模糊程度。</br>
<br/>
`+(void) setBlurAnimation:(BOOL)blurAnimationEnabled;`<br/>
开启/关闭模糊动画。<br/>
<br/>

# Release Notes
Version 0.0.1
* 添加模糊指定视图功能
* 设置模糊的程度
* 设置模糊的动画
* 添加自动模糊隐藏功能

# Dependencies
* <a href="https://github.com/nicklockwood/FXBlurView">FXBlurView</a> 一个可以模糊任意窗口的功能

# License
GNU General Public License