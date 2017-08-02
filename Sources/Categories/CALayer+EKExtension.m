//
//  CALayer+EKExtension.m
//  ExtensionKitObjc
//
//  Created by Moch Xiao on 2/23/17.
//  Copyright © 2017 Moch Xiao. All rights reserved.
//

#import "CALayer+EKExtension.h"

@implementation CALayer (EKExtension)

#pragma mark - Frame Accessor

- (CGPoint)ek_origin {
    return self.frame.origin;
}

- (void)setEk_origin:(CGPoint)ek_origin {
    self.frame = CGRectMake(ek_origin.x, ek_origin.y, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGSize)ek_size {
    return self.bounds.size;
}

- (void)setEk_size:(CGSize)ek_size {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), ek_size.width, ek_size.height);
}

- (CGFloat)ek_minX {
    return CGRectGetMinX(self.frame);
}

- (void)setEk_minX:(CGFloat)ek_minX {
    self.frame = CGRectMake(ek_minX, CGRectGetMinY(self.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGFloat)ek_midX {
    return CGRectGetMidX(self.frame);
}

- (void)setEk_midX:(CGFloat)ek_midX {
    self.frame = CGRectMake(ek_midX - CGRectGetWidth(self.bounds) / 2.0f, CGRectGetMinY(self.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGFloat)ek_maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setEk_maxX:(CGFloat)ek_maxX {
    self.frame = CGRectMake(ek_maxX - CGRectGetWidth(self.bounds), CGRectGetMinY(self.frame), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGFloat)ek_minY {
    return CGRectGetMinY(self.frame);
}

- (void)setEk_minY:(CGFloat)ek_minY {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), ek_minY, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGFloat)ek_midY {
    return CGRectGetMidY(self.frame);
}

- (void)setEk_midY:(CGFloat)ek_midY {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), ek_midY - CGRectGetHeight(self.bounds) / 2.0f, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGFloat)ek_maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setEk_maxY:(CGFloat)ek_maxY {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), ek_maxY - CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (CGFloat)ek_width {
    return CGRectGetWidth(self.bounds);
}

- (void)setEk_width:(CGFloat)ek_width {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), ek_width, CGRectGetHeight(self.bounds));
}

- (CGFloat)ek_height {
    return CGRectGetHeight(self.bounds);
}

- (void)setEk_height:(CGFloat)ek_height {
    self.frame = CGRectMake(CGRectGetMinX(self.frame), CGRectGetMinY(self.frame), CGRectGetWidth(self.bounds), ek_height);
}

- (CGFloat)ek_left {
    return self.ek_minX;
}

- (void)setEk_left:(CGFloat)ek_left {
    self.ek_minX = ek_left;
}

- (CGFloat)ek_right {
    return self.ek_maxX;
}

- (void)setEk_right:(CGFloat)ek_right {
    self.ek_maxX = ek_right;
}

- (CGFloat)ek_top {
    return self.ek_maxY;
}

- (void)setEk_top:(CGFloat)ek_top {
    self.ek_minY = ek_top;
}

- (CGFloat)ek_bottom {
    return self.ek_maxY;
}

- (void)setEk_bottom:(CGFloat)ek_bottom {
    self.ek_maxY = ek_bottom;
}

- (CGFloat)ek_centerX {
    return self.ek_minX;
}

- (void)setEk_centerX:(CGFloat)ek_centerX {
    self.ek_midX = ek_centerX;
}

- (CGFloat)ek_centerY {
    return self.ek_midY;
}

- (void)setEk_centerY:(CGFloat)ek_centerY {
    self.ek_midY = ek_centerY;
}

- (CGPoint)ek_center {
    return CGPointMake(self.frame.origin.x + self.frame.size.width * 0.5,
                       self.frame.origin.y + self.frame.size.height * 0.5);
}

- (void)setEk_center:(CGPoint)ek_center {
    CGRect frame = self.frame;
    frame.origin.x = ek_center.x - frame.size.width * 0.5;
    frame.origin.y = ek_center.y - frame.size.height * 0.5;
    self.frame = frame;
}

#pragma mark - 

- (nullable UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self renderInContext:context];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (nullable NSData *)snapshotPDF {
    CGRect bounds = self.bounds;
    NSMutableData *data = [NSMutableData data];
    CGDataConsumerRef consumer = CGDataConsumerCreateWithCFData((__bridge CFMutableDataRef)data);
    CGContextRef context = CGPDFContextCreate(consumer, &bounds, NULL);
    CGDataConsumerRelease(consumer);
    if (!context) return nil;
    CGPDFContextBeginPage(context, NULL);
    CGContextTranslateCTM(context, 0, bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    [self renderInContext:context];
    CGPDFContextEndPage(context);
    CGPDFContextClose(context);
    CGContextRelease(context);
    return data;
}

- (void)setLayerShadow:(nonnull UIColor *)color offset:(CGSize)offset radius:(CGFloat)radius {
    self.shadowColor = color.CGColor;
    self.shadowOffset = offset;
    self.shadowRadius = radius;
    self.shadowOpacity = 1;
    self.shouldRasterize = YES;
    self.rasterizationScale = [UIScreen mainScreen].scale;
}

- (void)removeAllSublayers {
    for (CALayer *layer in self.sublayers) {
        [layer removeFromSuperlayer];
    }
}

@end
