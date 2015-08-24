//
//  UIView+CHXBorderLine.h
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

#import <UIKit/UIKit.h>

@interface UIView (CHXBorderLine)

/**
 *  设置边框
 */
- (void)chx_setBorderLine;

/**
 *  设置边框
 *
 *  @param aColor 边框颜色
 */
- (void)chx_setBorderLineColor:(UIColor *)aColor;

/**
 *  设置边框
 *
 *  @param aColor      边框颜色
 *  @param orientation 哪一条边框
 */
- (void)chx_setBorderLineColor:(UIColor *)aColor edge:(UIRectEdge)edge;

/**
 *  添加边线约束
 *
 *  @param color      边线颜色
 *  @param edge       边缘方向
 *  @param multiplier 边线高度、宽度乘法器([0, 1])
 */
- (void)chx_setBorderLineConstraintsWithColor:(UIColor *)color edge:(UIRectEdge)edge lineSizeMultiplier:(CGFloat)multiplier;

/**
 *  添加虚线边框
 *
 *  @param color 边线颜色
 */
- (void)chx_setDashborderLineColor:(UIColor *)color;

/**
 *  添加虚线边框
 *
 *  @param color 边线颜色
 *  @param edge  边线方向
 */
- (void)chx_setDashborderLineColor:(UIColor *)color edge:(UIRectEdge)edge;

/**
 *  设置边线
 *
 *  @param width       宽度
 *  @param borderColor 颜色
 */
- (void)chx_setBorderWidth:(CGFloat)width color:(UIColor *)borderColor;


@end
