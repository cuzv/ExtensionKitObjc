//
//  CHXGlobalServices.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-19.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CGBase.h>

@class UIView, UINavigationBar, UITabBar, UIImage, NSError;

@interface CHXGlobalServices : NSObject

#pragma mark - System infos

/// 设备系统版本号
NSUInteger chx_deviceSystemMajorVersion();

/// App build string
NSString *chx_appBuild();

/// App version string
NSString *chx_appVersion();

#pragma mark - Device Screen

/// 设备屏幕dounds
struct CGRect chx_screenBounds();

/// 屏幕宽度(pt)
CGFloat chx_screenWidth();

/// 屏幕高度(pt)
CGFloat chx_screenHeight();

/// 屏幕缩放比
CGFloat chx_screenScale();

#pragma mark - Angle & Radian

/// 角度转弧度
CGFloat chx_angleToRadian(CGFloat angle);

/// 弧度转角度
CGFloat chx_radianToAngle(CGFloat radian);

#pragma mark - Sandbox

/// 获取沙盒文档目录
NSString *chx_documentDirectory();

/// 获取沙盒缓存目录
NSString *chx_cachesDirectory();

/// 获取沙盒下载目录
NSString *chx_downloadsDirectory();

/// 获取沙盒电影目录
NSString *chx_moviesDirectory();

/// 获取沙盒音乐目录
NSString *chx_musicDirectory();

/// 获取沙盒图片目录
NSString *chx_picturesDirectory();

/// 目录下所有文件所占空间大小
long long chx_folderSizeAtPath(NSString *folderPath);

#pragma mark - UniqueIdentifier

/// 生成唯一字符串
NSString *chx_uniqueIdentifier();

#pragma mark - Perform external jump

/// 拨打电话
void chx_callPhoneNumber(NSString *phoneNumber);

/// 发送短信
void chx_sendSMSTo(NSString *phoneNumber);

/// 打开浏览器
void chx_openBrowser(NSURL *webURL);

/// 发送邮件
void chx_emailTo(NSString *receiverEmail);

/// 打开 App store
void chx_openAppStoreByAppLink(NSURL *appLink);

#pragma mark - Clear badge

/// 清除徽标
void chx_clearApplicationIconBadge();

#pragma mark - Hairline for bar

/// 获取 TabBar 顶部那一条灰线
UIView *chx_hairLineForTabBar(UITabBar *tabBar);

/// 隐藏 TabBar 顶部那一条灰线
void chx_hiddenHairLineForTabBar(UITabBar *tabBar);

/// 获取导航栏底部的那一条灰线
UIView *chx_hairLineForNavigationBar(UINavigationBar *navigationBar);

/// 隐藏导航栏底部的那一条灰线
void chx_removeHairLineForNavigationBar(UINavigationBar *navigationBar);

#pragma mark - Asynchronization get image

/// 异步获取图片
void chx_imageFromURL(NSURL *imageLink, void (^completionBlock)(UIImage *downloadedImage), void (^errorBlock)(NSError *error));

#pragma mark - Swizzle

/// Swizzle 实例方法，该方法应该在 dispatch_once 中执行
void chx_swizzleInstanceMethod(Class clazz, SEL originalSelector, SEL overrideSelector);

/// Swizzle 类方法，该方法应该在 dispatch_once 中执行
void chx_swizzleClassMethod(Class clazz, SEL originalSelector, SEL overrideSelector);

#pragma mark - Collection spacing

CGFloat chx_minimumInteritemSpacingForCollection(CGFloat collectionViewWidth, CGFloat cellWidth, CGFloat horizontalCount);

#pragma mark - Autolayout helpers

/// 添加左对齐约束
void chx_leftAlignAndVerticallySpaceOutViews(NSArray *views, CGFloat distance);

#pragma mark - 斜切变换

struct CGAffineTransform CGAffineTransformMakeShear(CGFloat x, CGFloat y);

#pragma mark - 键盘是否出现

BOOL chx_isKeyboardOnScreen();
BOOL chx_isKeyBoardInDisplay();

#pragma mark - 倒计时

/// 计算剩余时间
void chx_timeInterval(NSInteger timeInterval, void(^reduceBlock)(NSInteger days, NSInteger hours, NSInteger minutes, NSInteger seconds));

/// 计算剩余时间，返回数组中，分别为天、小时、分钟、秒钟；注意使用完后调用 free
NSInteger *chx_timeInterval_c(NSInteger timeInterval);

#pragma mark - 

/// 整型转字符串
NSString *chx_integerToString(NSInteger integerValue);


@end


