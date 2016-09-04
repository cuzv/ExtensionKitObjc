//
//  EKCoreLibsExtension.m
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

#import "EKCoreLibsExtension.h"
#import "EKMacro.h"
#import <Objc/runtime.h>
#import <objc/objc.h>

#pragma mark - Size & Rect

CGSize EKCeilSize(CGSize size) {
    return CGSizeMake(ceil(size.width), ceil(size.height));
}

CGSize EKSizeScaling(CGSize size, CGFloat factor) {
    return CGSizeMake(size.width * factor, size.height * factor);
}

CGFloat EKSizeAspectScaleToFit(CGSize size, CGRect destination) {
    return MIN(destination.size.width / size.width, destination.size.height / size.height);
}

CGFloat EKSizeAspectScaleToFill(CGSize size, CGRect destination) {
    return MAX(destination.size.width / size.width, destination.size.height / size.height);
}

CGSize EKFloorSize(CGSize size) {
    return CGSizeMake(floor(size.width), floor(size.height));
}


CGRect EKCeilRect(CGRect rect) {
    return CGRectMake(ceil(rect.origin.x), ceil(rect.origin.y), ceil(CGRectGetWidth(rect)), ceil(CGRectGetHeight(rect)));
}

CGRect EKFloorRect(CGRect rect) {
    return CGRectMake(floor(rect.origin.x), floor(rect.origin.y), floor(CGRectGetWidth(rect)), floor(CGRectGetHeight(rect)));
}

CGRect EKRectMake(CGPoint orign, CGSize size) {
    return CGRectMake(orign.x, orign.y, size.width, size.height);
}

CGRect EKRectFrom(CGPoint center, CGSize size) {
    return CGRectMake(center.x - size.width / 2.0f, center.y - size.height / 2.0f, size.width, size.height);
}

CGPoint EKRectGetCenter(CGRect rect) {
    return CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect));
}

CGRect EKRectCentering(CGRect source, CGRect destination) {
    return CGRectOffset(source, CGRectGetMidX(destination) - CGRectGetMidX(source), CGRectGetMidY(destination) - CGRectGetMidY(source));
}

CGRect EKRectFitting(CGRect source, CGRect destination) {
    CGFloat aspect = EKSizeAspectScaleToFit(source.size, destination);
    CGSize targetSize = EKSizeScaling(source.size, aspect);
    return EKRectFrom(EKRectGetCenter(destination), targetSize);
}

CGRect EKRectFiling(CGRect source, CGRect destination) {
    CGFloat aspect = EKSizeAspectScaleToFill(source.size, destination);
    CGSize targetSize = EKSizeScaling(source.size, aspect);
    return EKRectFrom(EKRectGetCenter(destination), targetSize);
}

EKRange EKRangeMake(NSUInteger start, NSUInteger end) {
    return (EKRange){start, end};
}

NSInteger EKRandomIn(EKRange range) {
    assert(range.start < range.end);
    return arc4random_uniform((u_int32_t)(range.end - range.start)) + range.start;
}

NSString *_Nonnull EKFormatPrice(CGFloat price) {
    NSString *str = EKString(@"¥%.2f", price);
    if ([str hasSuffix:@"00"]) {
        return EKString(@"¥%.0f", price);
    }
    if ([str hasSuffix:@"0"]) {
        return EKString(@"¥%.1f", price);
    }
    return str;
}

CGFloat EKRadian(CGFloat native) {
    return native / 180.0f * M_PI;
}

CGFloat EKAngle(CGFloat native) {
    return native / M_PI * 180.0f;
}

#pragma mark - AssociatedObject

_Nullable id EKGetAssociatedObject(id _Nullable object, const void *_Nonnull key) {
    return objc_getAssociatedObject(object, key);
}

void EKSetAssociatedObject(id _Nullable object, const void *_Nonnull key, _Nullable id value, objc_AssociationPolicy policy) {
    [object willChangeValueForKey:(__bridge NSString * _Nonnull)(key)];
    objc_setAssociatedObject(object, key, value, policy);
    [object didChangeValueForKey:(__bridge NSString * _Nonnull)(key)];
}

#pragma mark - Swizzle

void EKSwizzleInstanceMethod(Class _Nonnull clazz,  SEL _Nonnull originalSelector, SEL _Nonnull overrideSelector) {
    Method originalMethod = class_getInstanceMethod(clazz, originalSelector);
    Method overrideMethod = class_getInstanceMethod(clazz, overrideSelector);
    
    if (class_addMethod(clazz, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(clazz, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

void EKSwizzleClassMethod(Class _Nonnull clazz, SEL _Nonnull originalSelector, SEL _Nonnull overrideSelector) {
    Method originalMethod = class_getClassMethod(clazz, originalSelector);
    Method overrideMethod = class_getClassMethod(clazz, overrideSelector);
    
    if (class_addMethod(clazz, originalSelector, method_getImplementation(overrideMethod), method_getTypeEncoding(overrideMethod))) {
        class_replaceMethod(clazz, overrideSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, overrideMethod);
    }
}

#pragma mark -

void EKUIThreadAsyncAction(dispatch_block_t _Nonnull block) {
    if (NSThread.isMainThread) {
        block();
        return;
    }
    dispatch_async(dispatch_get_main_queue(), block);
}

void EKBackgroundThreadAsyncAction(dispatch_block_t _Nonnull block) {
    if (!NSThread.isMainThread) {
        block();
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
}
