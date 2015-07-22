//
//  UIImageExtension.m
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

#import "UIImageExtension.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIImageExtension
@end

#pragma mark - 获取 NSBundle 中的图片

@implementation UIImage (CHXFetch)

+ (UIImage *)chx_imageWithFileName:(NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    return [UIImage imageWithContentsOfFile:path];
}

+ (UIImage *)chx_imageWithName:(NSString *)imageName {
    return [self chx_imageWithName:imageName extension:@"png"];
}

+ (UIImage *)chx_imageWithName:(NSString *)imageName extension:(NSString *)extension {
    return [self pr_imageWithName:imageName extension:extension] ?:
            ([self pr_imageWithName:[imageName stringByAppendingString:@"@2x"] extension:extension] ?:
            ([self pr_imageWithName:[imageName stringByAppendingString:@"@3x"] extension:extension]));
}

+ (UIImage *)pr_imageWithName:(NSString *)imageName extension:(NSString *)extension {
    return [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:imageName ofType:extension]];
}

@end


#pragma mark - 快速生成图片

@implementation UIImage (CHXGenerate)

+ (UIImage *)chx_imageWithColor:(UIColor *)aColor {
    return [self chx_imageWithColor:aColor size:CGSizeMake(1, 1)];
}

+ (UIImage *)chx_imageWithColor:(UIColor *)aColor size:(CGSize)aSize {
    UIGraphicsBeginImageContext(aSize);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [aColor CGColor]);
    CGRect rect = CGRectMake(0, 0, aSize.width, aSize.height);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+ (UIImage *)chx_captureImageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}



@end

@implementation UIImage (CHXAddition)

- (instancetype)chx_scaledImageForNewSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [self drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (instancetype)chx_originalImage {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}


- (NSData *)chx_UIImageJPEGRepresentationTargetKibibytes:(CGFloat)targetKibibytes targetRepresentionSize:(CGSize)representionSize {
    // 先压缩图片 size
    CGFloat currentRepresention = self.size.width * self.size.height;
    CGFloat targetRepresentionSize = representionSize.width * representionSize.height;
    UIImage *scaledImage = self;
    if (currentRepresention > targetRepresentionSize) {
        scaledImage = [self chx_scaledImageForNewSize:representionSize];
    }
    
    // 压缩图片质量
    CGFloat compressionQuality = 0.5f;
    CGFloat minBytes = targetKibibytes * 1024;
    NSData *compressedImageData = UIImageJPEGRepresentation(scaledImage, compressionQuality);
    while (compressedImageData.length > minBytes && compressionQuality > 0.1f) {
        compressionQuality -= 0.1f;
        compressedImageData = UIImageJPEGRepresentation(scaledImage, compressionQuality);
    }
    
    return compressedImageData;
}

- (NSData *)chx_UIImageJPEGRepresentationTargetKibibytes:(CGFloat)targetKibibytes {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat width = size.width * scale;
    CGSize newSize = CGSizeMake(width, width);
    
    return [self chx_UIImageJPEGRepresentationTargetKibibytes:targetKibibytes targetRepresentionSize:newSize];
}

@end