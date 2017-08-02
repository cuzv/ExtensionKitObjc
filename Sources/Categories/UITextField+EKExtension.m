//
//  UITextField+EKExtension.m
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

#import "UITextField+EKExtension.h"
#import "EKCoreLibsExtension.h"
#import "EKTextObserver.h"

@implementation UITextField (EKExtension)

+ (void)load {
    EKSwizzleInstanceMethod(self, @selector(intrinsicContentSize), @selector(_ek_intrinsicContentSize));
    EKSwizzleInstanceMethod(self, @selector(textRectForBounds:), @selector(_ek_textRectForBounds:));
    EKSwizzleInstanceMethod(self, @selector(editingRectForBounds:), @selector(_ek_editingRectForBounds:));
}

- (CGSize)_ek_intrinsicContentSize {
    CGSize size = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    CGFloat width = size.width + self.ek_contentInsets.left + self.ek_contentInsets.right;
    CGFloat height = size.height + self.ek_contentInsets.top + self.ek_contentInsets.bottom;
    return CGSizeMake(width, height);
}

- (CGRect)_ek_textRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, self.ek_contentInsets);
}

- (CGRect)_ek_editingRectForBounds:(CGRect)bounds {
    return UIEdgeInsetsInsetRect(bounds, self.ek_contentInsets);
}

- (UIEdgeInsets)ek_contentInsets {
    return [EKGetAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)setEk_contentInsets:(UIEdgeInsets)ek_contentInsets {
    EKSetAssociatedObject(self, @selector(ek_contentInsets), [NSValue valueWithUIEdgeInsets:ek_contentInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -

- (void)ek_observerTextLenghtWithMax:(NSInteger)maxLength changing:(void(^_Nonnull)(NSInteger left))actionHandler {
    EKTextObserver *observer = [[EKTextObserver alloc] initWithMaxLenght:maxLength actionHandler:actionHandler];
    [observer observeTextField:self];
    EKSetAssociatedObject(self, _cmd, observer, OBJC_ASSOCIATION_RETAIN);
}



@end
