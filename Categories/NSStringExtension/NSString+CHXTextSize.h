//
//  NSString+CHXTextSize.h
//  WildAppExtensionRunner
//
//  Created by Moch Xiao on 2014-11-18.
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
#import <UIKit/UIKit.h>

@interface NSString (CHXTextSize)

/**
 *  根据字体获取所占空间尺寸大小
 *
 *  @param font 字体
 *
 *  @return 尺寸大小
 */
- (CGSize)chx_sizeWithFont:(UIFont *)font;

/**
 *  根据字体获取所占空间尺寸大小
 *
 *  @param font  字体
 *  @param width 最大宽度
 *
 *  @return 尺寸大小
 */
- (CGSize)chx_sizeWithFont:(UIFont *)font width:(CGFloat)width;

/**
 *  根据字体属性获取所占空间尺寸大小
 *
 *  @param attributes 属性
 *  @param width      最大宽度
 *
 *  @return 尺寸大小
 */
- (CGSize)chx_sizeWithAttributes:(NSDictionary *)attributes width:(CGFloat)width;


@end

