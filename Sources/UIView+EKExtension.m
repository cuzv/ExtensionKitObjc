//
//  UIView+EKExtension.m
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

#import "UIView+EKExtension.h"
#import "EKCoreLibsExtension.h"
#import "UIImage+EKExtension.h"
#import "EKMacro.h"
#import "UIResponder+EKExtension.h"
#import "EKExtensionObjcInternal.h"

#pragma mark -

@implementation UIView (EKExtension)

@dynamic ek_isRoundingCornersExists;

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


#pragma mark - Borderline

- (void)ek_addBorderline {
    [self ek_addBorderlineRectEdge:UIRectEdgeAll width:0 color:nil multiplier:1 constant:0];
}

- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge {
    [self ek_addBorderlineRectEdge:edge width:0 color:nil multiplier:1 constant:0];
}

- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge color:(nullable UIColor *)color {
    [self ek_addBorderlineRectEdge:edge width:0 color:color multiplier:1 constant:0];
}

- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge width:(CGFloat)width color:(nullable UIColor *)color {
    [self ek_addBorderlineRectEdge:edge width:width color:color multiplier:1 constant:0];
}

- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge multiplier:(CGFloat)multiplier {
    [self ek_addBorderlineRectEdge:edge width:0 color:nil multiplier:multiplier constant:0];
}

- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge constant:(CGFloat)constant {
    [self ek_addBorderlineRectEdge:edge width:0 color:nil multiplier:1 constant:constant];
}

- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge width:(CGFloat)width color:(nullable UIColor *)color multiplier:(CGFloat)multiplier constant:(CGFloat)constant {
    if (edge == UIRectEdgeNone) {
        return;
    }
    
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:_EKBorderlineView.class]) {
            _EKBorderlineView *borderline = (_EKBorderlineView *)view;
            if (borderline.edge & edge) {
                return;
            }
        }
    }

    width = width > 0 ? width : 1.0f / [UIScreen mainScreen].scale;
    
    if (edge & UIRectEdgeLeft) {
        _EKAddBorderline(self, color, edge, NSLayoutAttributeLeft, NSLayoutAttributeCenterY, NSLayoutAttributeHeight, EKString(@"[borderline(%@)]", @(width)), multiplier, constant);
    }
    if (edge & UIRectEdgeRight) {
        _EKAddBorderline(self, color, edge, NSLayoutAttributeRight, NSLayoutAttributeCenterY, NSLayoutAttributeHeight, EKString(@"[borderline(%@)]", @(width)), multiplier, constant);
    }
    if (edge & UIRectEdgeTop) {
        _EKAddBorderline(self, color, edge, NSLayoutAttributeTop, NSLayoutAttributeCenterX, NSLayoutAttributeWidth, EKString(@"V:[borderline(%@)]", @(width)), multiplier, constant);
    }
    if (edge & UIRectEdgeBottom) {
        _EKAddBorderline(self, color, edge, NSLayoutAttributeBottom, NSLayoutAttributeCenterX, NSLayoutAttributeWidth, EKString(@"V:[borderline(%@)]", @(width)), multiplier, constant);
    }
}

void _EKAddBorderline(UIView *receiver,
                      UIColor *color,
                      UIRectEdge edge,
                      NSLayoutAttribute edgeAttribute,
                      NSLayoutAttribute centerAttribute,
                      NSLayoutAttribute sizeAttribute,
                      NSString *visualFormat,
                      CGFloat multiplier,
                      CGFloat constant)
{
    _EKBorderlineView *borderline = [_EKBorderlineView new];
    borderline.backgroundColor = color ?: [[UIColor blackColor] colorWithAlphaComponent:0.25];
    borderline.translatesAutoresizingMaskIntoConstraints = NO;
    borderline.edge = edge;
    [receiver addSubview:borderline];
    
    NSLayoutConstraint *edgeConstraint = [NSLayoutConstraint constraintWithItem:borderline attribute:edgeAttribute relatedBy:NSLayoutRelationEqual toItem:receiver attribute:edgeAttribute multiplier:1 constant:0];
    NSLayoutConstraint *centerConstraint = [NSLayoutConstraint constraintWithItem:borderline attribute:centerAttribute relatedBy:NSLayoutRelationEqual toItem:receiver attribute:centerAttribute multiplier:1 constant:0];
    NSLayoutConstraint *sizeConstraint = [NSLayoutConstraint constraintWithItem:borderline attribute:sizeAttribute relatedBy:NSLayoutRelationEqual toItem:receiver attribute:sizeAttribute multiplier:1 constant:constant];
    [receiver addConstraints:@[edgeConstraint, centerConstraint, sizeConstraint]];
    
    NSArray<__kindof NSLayoutConstraint *> *formatConstraint = [NSLayoutConstraint constraintsWithVisualFormat:visualFormat options:0 metrics:nil views:NSDictionaryOfVariableBindings(borderline)];
    [receiver addConstraints:formatConstraint];
}

- (void)ek_removeBorderline {
    [self ek_removeBorderlineRectEdge:UIRectEdgeAll];
}

- (void)ek_removeBorderlineRectEdge:(UIRectEdge)edge {
    if (edge == UIRectEdgeNone) {
        return;
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:_EKBorderlineView.class]) {
            _EKBorderlineView *borderline = (_EKBorderlineView *)view;
            if (borderline.edge & edge) {
                [view removeFromSuperview];
            }
        }
    }
}

- (BOOL)ek_isBorderlineExists {
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:_EKBorderlineView.class]) {
            return YES;
        }
    }
    return NO;
}

#pragma mark - Corner

- (void)ek_addRoundingCornersRadius:(CGFloat)radius {
    [self ek_addRoundingCorners:UIRectCornerAllCorners radius:radius fillColor:nil strokeColor:nil strokeLineWidth:0];
}

- (void)ek_addRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius {
    [self ek_addRoundingCorners:roundingCorners radius:radius fillColor:nil strokeColor:nil strokeLineWidth:0];
}

- (void)ek_addRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius strokeLineWidth:(CGFloat)strokeLineWidth {
    [self ek_addRoundingCorners:roundingCorners radius:radius fillColor:nil strokeColor:nil strokeLineWidth:strokeLineWidth];
}

/// 添加圆角，确保调用时视图 frame ! = 0
- (void)ek_addRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius fillColor:(nullable UIColor *)fillColor strokeColor:(nullable UIColor *)strokeColor strokeLineWidth:(CGFloat)strokeLineWidth {
    if (CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
        NSLog(@"Could not set rounding corners on zero size view.");
        return;
    }
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *backImage = [UIImage ek_imageWithColor:fillColor ?: self.backgroundColor ?: [UIColor whiteColor]
                                                   size:self.bounds.size
                                        roundingCorners:roundingCorners
                                                 radius:radius
                                            strokeColor:strokeColor ?: self.backgroundColor ?: [UIColor clearColor]
                                        strokeLineWidth:strokeLineWidth];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.backgroundColor = [UIColor clearColor];
            self.layer.contents = (__bridge id _Nullable)(backImage.CGImage);
            self.ek_isRoundingCornersExists = YES;
        });
    });
}

- (void)ek_removeRoundingCorners {
    self.layer.contents = nil;
    self.ek_isRoundingCornersExists = NO;
}

- (BOOL)ek_isRoundingCornersExists {
    return [EKGetAssociatedObject(self, _cmd) boolValue];
}

- (void)setEk_isRoundingCornersExists:(BOOL)ek_isRoundingCornersExists {
    EKSetAssociatedObject(self, @selector(ek_isRoundingCornersExists), @(ek_isRoundingCornersExists), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - Layer Properties

- (CGFloat)ek_cornerRadius {
    return self.layer.cornerRadius;
}

- (void)setEk_cornerRadius:(CGFloat)ek_cornerRadius {
    self.layer.cornerRadius = ek_cornerRadius;
    self.layer.masksToBounds = ek_cornerRadius > 0;
}

- (CGFloat)ek_borderWith {
    return self.layer.borderWidth;
}

- (void)setEk_borderWith:(CGFloat)ek_borderWith {
    self.layer.borderWidth = ek_borderWith;
}

- (UIColor *)ek_borderColor {
    CGColorRef borderColor = self.layer.borderColor;
    if (borderColor) {
        return [UIColor colorWithCGColor:borderColor];
    }
    return nil;
}

- (void)setEk_borderColor:(UIColor *)ek_borderColor {
    self.layer.borderColor = ek_borderColor.CGColor;
}

#pragma mark - Blur

+ (nonnull instancetype)ek_blur {
    return [self ek_viewWithBlurStyle:UIBlurEffectStyleExtraLight];
}

+ (nonnull instancetype)ek_viewWithBlurStyle:(UIBlurEffectStyle)style {
    return [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:style]];
}

+ (nonnull instancetype)ek_speclBlur {
    return [self ek_viewWithSpeclBlurStyle:UIBarStyleDefault];
}

+ (nonnull instancetype)ek_viewWithSpeclBlurStyle:(UIBarStyle)style {
    UIToolbar *toolbar = [UIToolbar new];
    toolbar.barStyle = style;
    toolbar.translucent = YES;
    return toolbar;
}

#pragma mark - AddSubView

- (void)ek_addSubview:(nonnull UIView *)subview {
    subview.frame = self.bounds;
    [self addSubview:subview];

    subview.translatesAutoresizingMaskIntoConstraints = NO;
    NSArray<__kindof NSLayoutConstraint *> *h = [NSLayoutConstraint constraintsWithVisualFormat:@"|[subview]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(subview)];
    NSArray<__kindof NSLayoutConstraint *> *v = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subview]|" options:NSLayoutFormatDirectionLeadingToTrailing metrics:nil views:NSDictionaryOfVariableBindings(subview)];
    [self addConstraints:h];
    [self addConstraints:v];
}


#pragma mark - ActivityIndicator Animation

- (void)ek_satrtActivityIndicatorAnimation {
    if (self.ek_isActivityIndicatorAnimating) {
        return;
    }
    if (self.ek_activityIndicatorView) {
        [self.ek_activityIndicatorView startAnimating];
        return;
    }
    
    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicatorView.userInteractionEnabled = NO;
    [activityIndicatorView startAnimating];
    [self ek_addSubview:activityIndicatorView];
    self.ek_activityIndicatorView = activityIndicatorView;
}

- (void)ek_stopActivityIndicatorAnimation {
    if (!self.ek_isActivityIndicatorAnimating) {
        return;
    }
    [self.ek_activityIndicatorView stopAnimating];
}

- (BOOL)ek_isActivityIndicatorAnimating {
    return self.ek_activityIndicatorView.isAnimating;
}

- (nullable UIActivityIndicatorView *)ek_activityIndicatorView {
    return EKGetAssociatedObject(self, _cmd);
}

- (void)setEk_activityIndicatorView:(nullable UIActivityIndicatorView *)ek_activityIndicatorView {
    EKSetAssociatedObject(self, @selector(ek_activityIndicatorView), ek_activityIndicatorView, OBJC_ASSOCIATION_ASSIGN);
}

#pragma mark - Snapshot 

- (nullable UIImage *)ek_snapshot {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) {
        return nil;
    }
    CGContextRetain(context);
    
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRelease(context);
    
    return output;
}

#pragma mark - Responsder

- (nullable UIViewController *)ek_responsderViewController {
    return (UIViewController *)[self ek_responderOf:UIViewController.class];
}

#pragma mark - GestureRecognizer

- (void)ek_tapAction:(nonnull void(^)(UIView *_Nonnull sender))action {
    [self ek_tapAction:action withNumberOfTapsRequired:1];
}

- (void)ek_doubleTapAction:(nonnull void(^)(UIView *_Nonnull sender))action {
    [self ek_tapAction:action withNumberOfTapsRequired:2];
}

- (void)ek_tapAction:(nonnull void(^)(UIView *_Nonnull sender))action withNumberOfTapsRequired:(NSUInteger)required {
    self.userInteractionEnabled = YES;
    
    _EKActionTrampoline *trampoline = [[_EKActionTrampoline alloc] initWithAction:action];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:trampoline action:@selector(handleAction:)];
    tap.numberOfTapsRequired = required;
    [self addGestureRecognizer:tap];
    EKSetAssociatedObject(self, [EKString(@"%s-%@", sel_getName(_cmd), @(required)) UTF8String], trampoline, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:UITapGestureRecognizer.class] ||
            [gesture isKindOfClass:UILongPressGestureRecognizer.class]) {
            [tap requireGestureRecognizerToFail:gesture];
        }
    }
}

- (void)ek_longPressAction:(nonnull void(^)(UIView *_Nonnull sender))action {
    self.userInteractionEnabled = YES;
    
    _EKActionTrampoline *trampoline = [[_EKActionTrampoline alloc] initWithAction:action];
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc] initWithTarget:trampoline action:@selector(handleAction:)];
    [self addGestureRecognizer:tap];

    EKSetAssociatedObject(self, [EKString(@"%s", sel_getName(_cmd)) UTF8String], trampoline, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    for (UIGestureRecognizer *gesture in self.gestureRecognizers) {
        if ([gesture isKindOfClass:UILongPressGestureRecognizer.class]) {
            [tap requireGestureRecognizerToFail:gesture];
        }
    }
}

#pragma mark - ExtendTouchRect

- (UIEdgeInsets)ek_touchExtendInsets {
    return [EKGetAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)setEk_touchExtendInsets:(UIEdgeInsets)ek_touchExtendInsets {
    EKSetAssociatedObject(self, @selector(ek_touchExtendInsets), [NSValue valueWithUIEdgeInsets:ek_touchExtendInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (void)load {
    EKSwizzleInstanceMethod(self, @selector(pointInside:withEvent:), @selector(_ek_pointInside:withEvent:));
}

- (BOOL)_ek_pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (UIEdgeInsetsEqualToEdgeInsets(self.ek_touchExtendInsets, UIEdgeInsetsZero) ||
        self.hidden ||
        ([self isKindOfClass:UIControl.class] && !((UIControl *)self).enabled)) {
        return [self _ek_pointInside:point withEvent:event];
    }
    CGRect hitFrame = UIEdgeInsetsInsetRect(self.bounds, self.ek_touchExtendInsets);
    hitFrame.size.width = MAX(hitFrame.size.width, 0);
    hitFrame.size.height = MAX(hitFrame.size.height, 0);
    return CGRectContainsPoint(hitFrame, point);
}


@end

