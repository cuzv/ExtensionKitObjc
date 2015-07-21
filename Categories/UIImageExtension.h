//
//  UIImageExtension.h
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/atcuan).
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

@interface UIImageExtension : NSObject
@end

#pragma mark - 获取 NSBundle 中的图片

@interface UIImage (CHXFetch)

/**
 *  获取图片
 *
 *  @param fileName 文件名，含扩展名
 *
 *  @return 图片
 */
+ (UIImage *)chx_imageWithFileName:(NSString *)fileName;

/**
 *  获取图片
 *
 *  @param imageName 图片名，png
 *
 *  @return 图片
 */
+ (UIImage *)chx_imageWithName:(NSString *)imageName;

/**
 *  获取图片
 *
 *  @param imageName 图片名
 *  @param extension 扩展名
 *
 *  @return 图片
 */
+ (UIImage *)chx_imageWithName:(NSString *)imageName extension:(NSString *)extension;

@end


#pragma mark - 快速生成图片

@interface UIImage (CHXGenerate)

/**
 *  根据颜色快速生成图片
 *
 *  @param aColor 图片颜色
 *
 *  @return 生成的图片
 */
+ (UIImage *)chx_imageWithColor:(UIColor *)aColor;

/**
 *  根据颜色生成指定大小的图片
 *
 *  @param aColor 图片颜色
 *  @param aSize  图片尺寸大小
 *
 *  @return 生成的图片
 */
+ (UIImage *)chx_imageWithColor:(UIColor *)aColor size:(CGSize)aSize;

/**
 *  截屏，iOS 7 以前
 *
 *  @param view 需要被截屏的视图
 *
 *  @return 图片
 */
+ (UIImage *)chx_captureImageFromView:(UIView *)view;

@end


@interface UIImage (CHXAddition)

/**
 *  缩放UIImage到指定大小
 *
 *  @param newSize 新的大小
 *
 *  @return 缩放后的图片
 */
- (instancetype)chx_scaledImageForNewSize:(CGSize)newSize;

/**
 *  原始图片
 *
 *  @return 原始图片
 */
- (instancetype)chx_originalImage;

@end
