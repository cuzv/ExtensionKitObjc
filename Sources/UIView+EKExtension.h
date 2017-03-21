//
//  UIView+EKExtension.h
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

@interface UIView (EKExtension)

#pragma mark - Frame Accessor

@property (nonatomic, assign) CGPoint ek_origin;
@property (nonatomic, assign) CGSize ek_size;
@property (nonatomic, assign) CGFloat ek_minX;
@property (nonatomic, assign) CGFloat ek_midX;
@property (nonatomic, assign) CGFloat ek_maxX;
@property (nonatomic, assign) CGFloat ek_minY;
@property (nonatomic, assign) CGFloat ek_midY;
@property (nonatomic, assign) CGFloat ek_maxY;
@property (nonatomic, assign) CGFloat ek_width;
@property (nonatomic, assign) CGFloat ek_height;

@property (nonatomic, assign) CGFloat ek_left;
@property (nonatomic, assign) CGFloat ek_right;
@property (nonatomic, assign) CGFloat ek_top;
@property (nonatomic, assign) CGFloat ek_bottom;

@property (nonatomic, assign) CGFloat ek_centerX;
@property (nonatomic, assign) CGFloat ek_centerY;
@property (nonatomic, assign) CGPoint ek_center;

#pragma mark - Borderline

- (void)ek_addBorderline;
- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge;
- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge color:(nullable UIColor *)color;
- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge width:(CGFloat)width color:(nullable UIColor *)color;
- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge multiplier:(CGFloat)multiplier;
- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge constant:(CGFloat)constant;
/// 添加边线，width = 0 会替换为默认宽度，color = nil 会替换为默认颜色
- (void)ek_addBorderlineRectEdge:(UIRectEdge)edge width:(CGFloat)width color:(nullable UIColor *)color multiplier:(CGFloat)multiplier constant:(CGFloat)constant;

- (void)ek_removeBorderline;
- (void)ek_removeBorderlineRectEdge:(UIRectEdge)edge;

- (BOOL)ek_isBorderlineExists;

#pragma mark - Corner

- (void)ek_addRoundingCornersRadius:(CGFloat)radius;
- (void)ek_addRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius;
- (void)ek_addRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius strokeLineWidth:(CGFloat)strokeLineWidth;
/// 添加圆角，请确保调用时视图 size ! = CGSizeZero
- (void)ek_addRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius fillColor:(nullable UIColor *)fillColor strokeColor:(nullable UIColor *)strokeColor strokeLineWidth:(CGFloat)strokeLineWidth;

- (void)ek_removeRoundingCorners;

@property (nonatomic, assign, readonly) BOOL ek_isRoundingCornersExists;

#pragma mark - Layer Properties

@property (nonatomic, assign) CGFloat ek_cornerRadius;
@property (nonatomic, assign) CGFloat ek_borderWith;
@property (nonatomic, assign, nullable) UIColor *ek_borderColor;

#pragma mark - Blur

+ (nonnull instancetype)ek_blur NS_AVAILABLE_IOS(8_0);
+ (nonnull instancetype)ek_viewWithBlurStyle:(UIBlurEffectStyle)style NS_AVAILABLE_IOS(8_0);
+ (nonnull instancetype)ek_speclBlur NS_AVAILABLE_IOS(6_0);
+ (nonnull instancetype)ek_viewWithSpeclBlurStyle:(UIBarStyle)style NS_AVAILABLE_IOS(6_0);

#pragma mark - AddSubView

- (void)ek_addSubview:(nonnull UIView *)subview;

#pragma mark - ActivityIndicator Animation

- (void)ek_satrtActivityIndicatorAnimation;
- (void)ek_stopActivityIndicatorAnimation;
@property (nonatomic, assign, readonly) BOOL ek_isActivityIndicatorAnimating;

#pragma mark - bgColor

- (nullable UIColor *)ek_bgColor;

#pragma mark - Snapshot

@property (nonatomic, strong, nullable, readonly) UIImage *ek_snapshot;

#pragma mark - Responsder

@property (nonatomic, strong, nullable, readonly) UIViewController *ek_responsderViewController;

#pragma mark - GestureRecognizer

- (void)ek_tapAction:(nonnull void(^)(UIView *_Nonnull sender))action;
- (void)ek_doubleTapAction:(nonnull void(^)(UIView *_Nonnull sender))action;
/// 添加点击手势，先添加需要点击次数多的手势。
- (void)ek_tapAction:(nonnull void(^)(UIView *_Nonnull sender))action withNumberOfTapsRequired:(NSUInteger)required;
/// 添加长按手势，应该先于点击手势。
- (void)ek_longPressAction:(nonnull void(^)(UIView *_Nonnull sender))action;


#pragma mark - ExtendTouchRect

/// Override @selector(pointInside:withEvent:)
@property (nonatomic, assign) UIEdgeInsets ek_touchExtendInsets;


#pragma mark - LayerImage

@property (nonatomic, strong, nullable) UIImage *ek_layerImage;

@end
