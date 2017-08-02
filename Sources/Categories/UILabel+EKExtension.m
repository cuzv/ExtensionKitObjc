//
//  UILabel+EKExtension.m
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

#import "UILabel+EKExtension.h"
#import "UIView+EKExtension.h"
#import "UIImage+EKExtension.h"
#import "EKCoreLibsExtension.h"

@implementation UILabel (EKExtension)

- (void)ek_addRoundingCorners:(UIRectCorner)roundingCorners radius:(CGFloat)radius fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor strokeLineWidth:(CGFloat)strokeLineWidth {
    if (self.ek_isRoundingCornersExists) {
        return;
    }
    if (CGSizeEqualToSize(self.bounds.size, CGSizeZero)) {
        NSLog(@"Could not set rounding corners on zero size view.");
        return;
    }
    if (!self.superview) {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *backImage = [UIImage ek_imageWithColor:fillColor size:self.bounds.size roundingCorners:roundingCorners radius:radius strokeColor:strokeColor strokeLineWidth:strokeLineWidth];
        if (!backImage) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImageView *backImageView = [[UIImageView alloc] initWithImage:backImage];
            backImageView.frame = self.frame;
            [self.superview addSubview:backImageView];
            [self.superview sendSubviewToBack:backImageView];
            self.backgroundColor = [UIColor clearColor];
            
            [self setValue:@(YES) forKey:NSStringFromSelector(@selector(ek_isRoundingCornersExists))];
        });
    });
}

#pragma mark - 

+ (void)load {
    EKSwizzleInstanceMethod(self, @selector(intrinsicContentSize), @selector(_ek_intrinsicContentSize));
    EKSwizzleInstanceMethod(self, @selector(drawTextInRect:), @selector(_ek_drawTextInRect:));
}

- (CGSize)_ek_intrinsicContentSize {
    CGSize size = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    CGFloat width = size.width + self.ek_contentInsets.left + self.ek_contentInsets.right;
    CGFloat height = size.height + self.ek_contentInsets.top + self.ek_contentInsets.bottom;
    return CGSizeMake(width, height);
}

- (void)_ek_drawTextInRect:(CGRect)rect {
    [self _ek_drawTextInRect:UIEdgeInsetsInsetRect(rect, self.ek_contentInsets)];
}

- (UIEdgeInsets)ek_contentInsets {
    return [EKGetAssociatedObject(self, _cmd) UIEdgeInsetsValue];
}

- (void)setEk_contentInsets:(UIEdgeInsets)ek_contentInsets {
    EKSetAssociatedObject(self, @selector(ek_contentInsets), [NSValue valueWithUIEdgeInsets:ek_contentInsets], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
