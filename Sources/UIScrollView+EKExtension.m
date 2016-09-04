//
//  UIScrollView+EKExtension.m
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

#import "UIScrollView+EKExtension.h"
#import "EKCoreLibsExtension.h"
#import "EKExtensionObjcInternal.h"
#import "EKMacro.h"

@implementation UIScrollView (EKExtension)

- (CGFloat)ek_insetTop {
    return self.contentInset.top;
}

- (void)setEk_insetTop:(CGFloat)ek_insetTop {
    UIEdgeInsets insets = self.contentInset;
    insets.top = ek_insetTop;
    self.contentInset = insets;
}

- (CGFloat)ek_insetLeft {
    return self.contentInset.left;
}

- (void)setEk_insetLeft:(CGFloat)ek_insetLeft {
    UIEdgeInsets insets = self.contentInset;
    insets.left = ek_insetLeft;
    self.contentInset = insets;
}

- (CGFloat)ek_insetBottom {
    return self.contentInset.bottom;
}

- (void)setEk_insetBottom:(CGFloat)ek_insetBottom {
    UIEdgeInsets insets = self.contentInset;
    insets.bottom = ek_insetBottom;
    self.contentInset = insets;
}

- (CGFloat)ek_insetRight {
    return self.contentInset.right;
}

- (void)setEk_insetRight:(CGFloat)ek_insetRight {
    UIEdgeInsets insets = self.contentInset;
    insets.right = ek_insetRight;
    self.contentInset = insets;
}

- (CGFloat)ek_scrollIndicatorInsetTop {
    return self.scrollIndicatorInsets.top;
}

- (void)setEk_scrollIndicatorInsetTop:(CGFloat)ek_scrollIndicatorInsetTop {
    UIEdgeInsets scrollIndicatorInsets = self.scrollIndicatorInsets;
    scrollIndicatorInsets.top = ek_scrollIndicatorInsetTop;
    self.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (CGFloat)ek_scrollIndicatorInsetLeft {
    return self.scrollIndicatorInsets.left;
}

- (void)setEk_scrollIndicatorInsetLeft:(CGFloat)ek_scrollIndicatorInsetLeft {
    UIEdgeInsets scrollIndicatorInsets = self.scrollIndicatorInsets;
    scrollIndicatorInsets.left = ek_scrollIndicatorInsetLeft;
    self.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (CGFloat)ek_scrollIndicatorInsetBottom {
    return self.scrollIndicatorInsets.bottom;
}

- (void)setEk_scrollIndicatorInsetBottom:(CGFloat)ek_scrollIndicatorInsetBottom {
    UIEdgeInsets scrollIndicatorInsets = self.scrollIndicatorInsets;
    scrollIndicatorInsets.bottom = ek_scrollIndicatorInsetBottom;
    self.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (CGFloat)ek_scrollIndicatorInsetRight {
    return self.scrollIndicatorInsets.right;
}

- (void)setEk_scrollIndicatorInsetRight:(CGFloat)ek_scrollIndicatorInsetRight {
    UIEdgeInsets scrollIndicatorInsets = self.scrollIndicatorInsets;
    scrollIndicatorInsets.right = ek_scrollIndicatorInsetRight;
    self.scrollIndicatorInsets = scrollIndicatorInsets;
}

- (CGFloat)ek_contentOffsetX {
    return self.contentOffset.x;
}

- (void)setEk_contentOffsetX:(CGFloat)ek_contentOffsetX {
    CGPoint offset = self.contentOffset;
    offset.x = ek_contentOffsetX;
    self.contentOffset = offset;
}

- (CGFloat)ek_contentOffsetY {
    return self.contentOffset.y;
}

- (void)setEk_contentOffsetY:(CGFloat)ek_contentOffsetY {
    CGPoint offset = self.contentOffset;
    offset.y = ek_contentOffsetY;
    self.contentOffset = offset;
}

- (CGFloat)ek_contentSizeWidth {
    return self.contentSize.width;
}

- (void)setEk_contentSizeWidth:(CGFloat)ek_contentSizeWidth {
    CGSize contentSize = self.contentSize;
    contentSize.width = ek_contentSizeWidth;
    self.contentSize = contentSize;
}

- (CGFloat)ek_contentSizeHeight {
    return self.contentSize.height;
}

- (void)setEk_contentSizeHeight:(CGFloat)ek_contentSizeHeight {
    CGSize contentSize = self.contentSize;
    contentSize.height = ek_contentSizeHeight;
    self.contentSize = contentSize;
}

#pragma mark -

- (void)ek_addRefreshControlWithActionHandler:(void (^_Nonnull)(UIScrollView *_Nonnull sender))handler {
    if (self.ek_refreshControl) {
        return;
    }
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(UIScreen.mainScreen.bounds), 64)];
    [self addSubview:refreshControl];
    [self sendSubviewToBack:refreshControl];
    self.ek_refreshControl = refreshControl;
    
    @weakify(self);
    _EKActionTrampoline *trampoline = [[_EKActionTrampoline alloc] initWithAction:^(id _Nonnull obj) {
        @strongify(self);
        if (self.ek_refreshControlEnabled) {
            handler(self);
        } else {
            [self ek_endRefreshing];
        }
    }];
    [refreshControl addTarget:trampoline action:@selector(handleAction:) forControlEvents:UIControlEventValueChanged];
    EKSetAssociatedObject(self, [EKString(@"%s", sel_getName(_cmd)) UTF8String], trampoline, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)ek_beginRefreshing {
    [self.ek_refreshControl beginRefreshing];
}

- (void)ek_endRefreshing {
    [self.ek_refreshControl endRefreshing];
}

- (void)ek_removeRefreshControl {
    [self.ek_refreshControl removeFromSuperview];
    self.ek_refreshControl = nil;
}

- (BOOL)ek_refreshing {
    return self.ek_refreshControl.refreshing;
}

- (BOOL)ek_refreshControlEnabled {
    return self.ek_refreshControl.enabled;
}

- (void)setEk_refreshControlEnabled:(BOOL)ek_refreshControlEnabled {
    self.ek_refreshControl.enabled = ek_refreshControlEnabled;
    self.ek_refreshControl.alpha = ek_refreshControlEnabled ? 1 : 0;
}

- (nullable UIRefreshControl *)ek_refreshControl {
    return EKGetAssociatedObject(self, _cmd);
}

- (void)setEk_refreshControl:(UIRefreshControl *)ek_refreshControl {
    EKSetAssociatedObject(self, @selector(ek_refreshControl), ek_refreshControl, OBJC_ASSOCIATION_ASSIGN);
}

@end

