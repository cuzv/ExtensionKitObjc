//
//  UIScrollView+EKExtension.h
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

@interface UIScrollView (EKExtension)

@property (nonatomic, assign) CGFloat ek_insetTop;
@property (nonatomic, assign) CGFloat ek_insetLeft;
@property (nonatomic, assign) CGFloat ek_insetBottom;
@property (nonatomic, assign) CGFloat ek_insetRight;

@property (nonatomic, assign) CGFloat ek_scrollIndicatorInsetTop;
@property (nonatomic, assign) CGFloat ek_scrollIndicatorInsetLeft;
@property (nonatomic, assign) CGFloat ek_scrollIndicatorInsetBottom;
@property (nonatomic, assign) CGFloat ek_scrollIndicatorInsetRight;

@property (nonatomic, assign) CGFloat ek_contentOffsetX;
@property (nonatomic, assign) CGFloat ek_contentOffsetY;

@property (nonatomic, assign) CGFloat ek_contentSizeWidth;
@property (nonatomic, assign) CGFloat ek_contentSizeHeight;

#pragma mark -

- (void)ek_addRefreshControlWithActionHandler:(void (^_Nonnull)(UIScrollView *_Nonnull sender))handler;
@property (nonatomic, assign) BOOL ek_refreshControlEnabled;
@property (nonatomic, assign, readonly) BOOL ek_refreshing;
- (void)ek_beginRefreshing;
- (void)ek_endRefreshing;
- (void)ek_removeRefreshControl;

@end
