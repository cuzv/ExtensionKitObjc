//
//  CHXUtilsMacro.h
//  Haioo
//
//  Created by Moch Xiao on 5/4/15.
//  Copyright (c) 2015 Milanoo. All rights reserved.
//

#ifndef Haioo_CHXUtilsMacro_h
#define Haioo_CHXUtilsMacro_h

#define iOS6Supportable (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_5_1)
#define iOS7Supportable (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_6_1)
#define iOS8Supportable (NSFoundationVersionNumber > NSFoundationVersionNumber_iOS_7_1)

#define inch3_5 (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 320, 480)))
#define inch4_0 (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 320, 568)))
#define inch4_7 (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 375, 667)))
#define inch5_5 (CGRectEqualToRect([UIScreen mainScreen].bounds, CGRectMake(0, 0, 414, 736)))

//
//  TODOMacro.h
//  TodoMacro
//
//  Created by sunnyxx on 15/3/1.
//  Copyright (c) 2015年 sunnyxx. All rights reserved.
//

// 转成字符串
#define STRINGIFY(S) #S
// 需要解两次才解开的宏
#define DEFER_STRINGIFY(S) STRINGIFY(S)

#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))

// 为warning增加更多信息
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)

// 使宏前面可以加@
#define KEYWORDIFY try {} @catch (...) {}

// 最终使用的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))

#endif
