//
//  EKCoreLibsExtension.h
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
#import <Objc/runtime.h>

#pragma mark - Size & Rect

CGSize EKCeilSize(CGSize size);
CGSize EKSizeScaling(CGSize size, CGFloat factor);
CGFloat EKSizeAspectScaleToFit(CGSize size, CGRect destination);
CGFloat EKSizeAspectScaleToFill(CGSize size, CGRect destination);
CGSize EKFloorSize(CGSize size);

CGRect EKCeilRect(CGRect rect);
CGRect EKFloorRect(CGRect rect);
CGRect EKRectMake(CGPoint orign, CGSize size);
CGRect EKRectFrom(CGPoint center, CGSize size);
CGPoint EKRectGetCenter(CGRect rect);
CGRect EKRectCentering(CGRect source, CGRect destination);
CGRect EKRectFitting(CGRect source, CGRect destination);
CGRect EKRectFiling(CGRect source, CGRect destination);

typedef struct _EKRange {
    NSUInteger start;
    NSUInteger end;
} EKRange;

EKRange EKRangeMake(NSUInteger start, NSUInteger end);
NSInteger EKRandomIn(EKRange range);

NSString *_Nonnull EKFormatPrice(CGFloat price);

CGFloat EKRadian(CGFloat native);
CGFloat EKAngle(CGFloat native);

#pragma mark - AssociatedObject

_Nullable id EKGetAssociatedObject(id _Nullable object, const void *_Nonnull key);
void EKSetAssociatedObject(id _Nullable object, const void *_Nonnull key, _Nullable id value, objc_AssociationPolicy policy);


#pragma mark - Swizzle

// 该方法应该在 dispatch_once 中执行
void EKSwizzleInstanceMethod(Class _Nonnull clazz,  SEL _Nonnull originalSelector, SEL _Nonnull overrideSelector);
// 该方法应该在 dispatch_once 中执行
void EKSwizzleClassMethod(Class _Nonnull clazz, SEL _Nonnull originalSelector, SEL _Nonnull overrideSelector);


#pragma mark -

void EKUIThreadAsyncAction(dispatch_block_t _Nonnull block);
void EKBackgroundThreadAsyncAction(dispatch_block_t _Nonnull block);



