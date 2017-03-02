//
//  UIImage+EKExtension.m
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

#import "UIImage+EKExtension.h"
#import "EKCoreLibsExtension.h"
#import "EKMacro.h"

@implementation UIImage (EKExtension)

- (nonnull UIImage *)ek_original {
    return [self imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (null_unspecified UIImage *)ek_decompressed {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    [self drawAtPoint:CGPointZero];
    UIImage *decompressedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return decompressedImage;
}

- (null_unspecified UIImage *)ek_buildThumbnailTo:(CGSize)targetSize useFitting:(BOOL)fitting {
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0);
    // Establish the output thumbnail rectangle
    CGRect targetRect = EKRectMake(CGPointZero, targetSize);
    // Create the source image’s bounding rectangle
    CGRect naturalRect = EKRectMake(CGPointZero, self.size);
    // Calculate fitting or filling destination rectangle
    // See Chapter 2 for a discussion on these functions
    
    CGRect destinationRect = fitting ? EKRectFitting(naturalRect, targetRect) : EKRectFiling(naturalRect, targetRect);
    // Draw the new thumbnail
    [self drawInRect:destinationRect];
    // Retrieve and return the new image
    UIImage *thumbnail = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return thumbnail;
}

- (nullable UIImage *)ek_extractingIn:(CGRect)subRect {
    CGImageRef ref = CGImageCreateWithImageInRect(self.CGImage, subRect);
    if (ref) {
        return [UIImage imageWithCGImage:ref];
    }
    return nil;
}

- (nonnull UIImage *)ek_orientationTo:(UIImageOrientation)orientation {
    if (self.imageOrientation == orientation) {
        return self;
    }
    if (self.CGImage) {
        return [UIImage imageWithCGImage:self.CGImage scale:self.scale orientation:orientation];
    }
    return self;
}

// See: http://www.cnblogs.com/silence-cnblogs/p/6346729.html
/// 压缩图片质量和尺寸相结合的方式
- (NSData *)ek_compressToByte:(NSUInteger)maxLength {
    UIImage *image = self;
    // Compress by quality
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    if (data.length < maxLength) {
        return data;
    }
    
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length < maxLength * 0.9) {
            min = compression;
        } else if (data.length > maxLength) {
            max = compression;
        } else {
            break;
        }
    }
    if (data.length < maxLength) {
        return data;
    }

    // Compress by size
    UIImage *resultImage = [UIImage imageWithData:data];
    NSUInteger lastDataLength = 0;
    while (data.length > maxLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        // Use NSUInteger to prevent white blank
        CGFloat ratio = (CGFloat)maxLength / data.length;
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        UIGraphicsBeginImageContext(size);
        // Use image to draw (drawInRect:), image is larger but more compression time
        // Use result image to draw, image is smaller but less compression time
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, compression);
    }
    
    return data;
}



#pragma mark - Maker

+ (nullable instancetype)ek_imageWithColor:(nonnull UIColor *)color size:(CGSize)size roundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius strokeColor:(nullable UIColor *)strokeColor strokeLineWidth:(CGFloat)strokeLineWidth {
    UIGraphicsBeginImageContextWithOptions(size, false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return nil;
    }
    CGContextRetain(context);
    
    strokeColor = strokeColor ?: [UIColor clearColor];
    
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextSetLineWidth(context, strokeLineWidth);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);

    CGRect roundedRect = CGRectMake(strokeLineWidth, strokeLineWidth, size.width - strokeLineWidth * 2.0f, size.height - strokeLineWidth * 2.0f);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:roundedRect byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context, path.CGPath);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRelease(context);
    
    return output;
}

UIImage *_Nullable EKImageMake(UIColor *_Nonnull color, CGSize size, UIRectCorner roundingCorners, CGFloat radius, UIColor *_Nullable strokeColor, CGFloat strokeLineWidth) {
    return [UIImage ek_imageWithColor:color size:size roundingCorners:roundingCorners radius:radius strokeColor:strokeColor strokeLineWidth:strokeLineWidth];
}

- (nullable instancetype)ek_imageWithRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius strokeColor:(nullable UIColor *)strokeColor strokeLineWidth:(CGFloat)strokeLineWidth {
    UIGraphicsBeginImageContextWithOptions(self.size, false, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return nil;
    }
    CGContextRetain(context);
    
    strokeColor = strokeColor ?: [UIColor clearColor];

    CGRect rect = EKRectMake(CGPointZero, self.size);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(context, path.CGPath);
    CGContextClip(context);
    [self drawInRect:rect];
    CGContextSetLineWidth(context, strokeLineWidth);
    CGContextSetStrokeColorWithColor(context, strokeColor.CGColor);

    CGRect roundedRect = CGRectMake(strokeLineWidth, strokeLineWidth, self.size.width - strokeLineWidth * 2.0f, self.size.height - strokeLineWidth * 2.0f);
    UIBezierPath *roundedPath = [UIBezierPath bezierPathWithRoundedRect:roundedRect byRoundingCorners:roundingCorners cornerRadii:CGSizeMake(radius, radius)];
    [roundedPath stroke];

    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRelease(context);
    
    return output;
}

- (null_unspecified instancetype)ek_renderUsingColor:(nonnull UIColor *)color {
    return [self ek_renderUsingColor:color alpha:1.0f];
}

- (null_unspecified instancetype)ek_renderUsingAlpha:(CGFloat)alpha; {
    return [self ek_renderUsingColor:nil alpha:alpha];
}

- (null_unspecified instancetype)ek_renderUsingColor:(nullable UIColor *)color alpha:(CGFloat)alpha {
    alpha = alpha > 1.0f ? 1.0f : alpha;
    
    UIGraphicsBeginImageContext(self.size);
    if (color) {
        [color setFill];
    }
    CGRect rect = EKRectMake(CGPointZero, self.size);
    UIRectFill(rect);
    [self drawInRect:rect blendMode:kCGBlendModeOverlay alpha:alpha];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - Load


+ (nullable instancetype)ek_imageWithFilename:(nonnull NSString *)filename {
    return [self ek_imageWithFilename:filename ofType:@"png"];
}

+ (nullable instancetype)ek_imageWithFilename:(nonnull NSString *)filename ofType:(nonnull NSString *)extension {
    if (CGRectGetWidth(UIScreen.mainScreen.bounds) > 375) {
        NSString *filepath = _EKPathForResource(EKString(@"%@@3x", filename), extension);
        if (filepath) {
            return [UIImage imageWithContentsOfFile:filepath];
        }
    }
    
    NSString *filepath = _EKPathForResource(EKString(@"%@@2x", filename), extension);
    if (filepath) {
        return [UIImage imageWithContentsOfFile:filepath];
    }
    
    filepath = _EKPathForResource(filename, extension);
    return [UIImage imageWithContentsOfFile:filepath];
}

NSString *_Nullable _EKPathForResource(NSString *_Nonnull filename, NSString *_Nonnull type) {
    return [NSBundle.mainBundle pathForResource:filename ofType:type];
}

UIImage *_Nullable EKImageFrom(NSString *_Nonnull filename, NSString *_Nullable extension) {
    return [UIImage ek_imageWithFilename:filename ofType:extension ?: @"png"];
}


#pragma mark - GetColor

- (nullable UIColor *)colorAtPixel:(CGPoint)point {
    // Cancel if point is outside image coordinates
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, width, height), point)) {
        return nil;
    }
    
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
