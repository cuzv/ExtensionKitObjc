//
//  UIImage+EKExtension.h
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

UIImage *_Nullable EKImageMake(UIColor *_Nonnull color, CGSize size, UIRectCorner roundingCorners, CGFloat radius, UIColor *_Nullable strokeColor, CGFloat strokeLineWidth);
UIImage *_Nullable EKImageFrom(NSString *_Nonnull filename, NSString *_Nullable extension);

UIImage *_Nullable EKImageFrom(NSString *_Nonnull filename, NSString *_Nullable extension);

@interface UIImage (EKExtension)

#pragma mark -

@property (nonnull ,nonatomic, strong, readonly) UIImage *ek_original;
@property (null_unspecified ,nonatomic, strong, readonly) UIImage *ek_decompressed;

- (null_unspecified UIImage *)ek_buildThumbnailTo:(CGSize)targetSize useFitting:(BOOL)fitting;
- (nullable UIImage *)ek_extractingIn:(CGRect)subRect;
- (nonnull UIImage *)ek_orientationTo:(UIImageOrientation)orientation;
- (nullable NSData *)ek_compressImageToByte:(NSUInteger)maxLength;

#pragma mark - Maker

/// 生成图片
+ (nullable instancetype)ek_imageWithColor:(nonnull UIColor *)color size:(CGSize)size roundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius strokeColor:(nullable UIColor *)strokeColor strokeLineWidth:(CGFloat)strokeLineWidth;

/// 生成图片
- (nullable instancetype)ek_imageWithRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius strokeColor:(nullable UIColor *)strokeColor strokeLineWidth:(CGFloat)strokeLineWidth;

- (null_unspecified instancetype)ek_renderUsingColor:(nonnull UIColor *)color;
- (null_unspecified instancetype)ek_renderUsingAlpha:(CGFloat)alpha;
- (null_unspecified instancetype)ek_renderUsingColor:(nullable UIColor *)color alpha:(CGFloat)alpha;

#pragma mark - Load

+ (nullable instancetype)ek_imageWithFilename:(nonnull NSString *)filename;
+ (nullable instancetype)ek_imageWithFilename:(nonnull NSString *)filename ofType:(nonnull NSString *)extension;

#pragma mark - GetColor

- (nullable UIColor *)colorAtPixel:(CGPoint)point;


@end


