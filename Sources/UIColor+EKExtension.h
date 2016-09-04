//
//  UIColor+EKExtension.h
//  Copyright (c) 2014-2016 Moch Xiao (http://mochxiao.com).
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

#import <UIKit/UIKit.h>

UIColor *_Nullable EKColorMake(CGFloat red, CGFloat green, CGFloat blue, CGFloat alpha);
UIColor *_Nullable EKColorFrom(NSString *_Nonnull hex, CGFloat alpha);


@interface UIColor (EKExtension)

+ (nullable instancetype)ek_random;
+ (nullable instancetype)ek_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+ (nullable instancetype)ek_colorWithHex:(nonnull NSString *)hex alpah:(CGFloat)alpha;

+ (nullable instancetype)ek_tint;
+ (nullable instancetype)ek_separator;
+ (nullable instancetype)ek_groupedBackground;
+ (nullable instancetype)ek_activityBackground;
+ (nullable instancetype)ek_disclosureIndicator;
+ (nullable instancetype)ek_naviTitle;
+ (nullable instancetype)ek_subTitle;
+ (nullable instancetype)ek_placeholder;

@end

