//
//  UITextView+EKExtension.m
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

#import "UITextView+EKExtension.h"
#import "EKCoreLibsExtension.h"
#import "UIColor+EKExtension.h"
#import "NSString+EKExtension.h"
#import "EKMacro.h"
#import "EKTextObserver.h"

@implementation UITextView (EKExtension)

+ (void)load {
    EKSwizzleInstanceMethod(self, @selector(setText:), @selector(_ek_setText:));
    EKSwizzleInstanceMethod(self, @selector(layoutSubviews), @selector(_ek_layoutSubviews));
    EKSwizzleInstanceMethod(self, @selector(init), @selector(_ek_init));
    EKSwizzleInstanceMethod(self, NSSelectorFromString(@"dealloc"), @selector(_ek_dealloc));
}

- (void)_ek_dealloc {
    if (self.ek_observer) {
        [NSNotificationCenter.defaultCenter removeObserver:self.ek_observer];
    }
    [self _ek_dealloc];
}

- (instancetype)_ek_init {
    id value = [self _ek_init];
    [self _ek_commitInit];
    return value;
}

- (void)_ek_commitInit {
    UILabel *placeholderLabel = [UILabel new];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.textColor = [UIColor ek_placeholder];
    placeholderLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleFootnote];
    placeholderLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    placeholderLabel.numberOfLines = 0;
    
    [self addSubview:placeholderLabel];
    self.ek_placeholderLabel = placeholderLabel;

    @weakify(self);
    self.ek_observer =
    [NSNotificationCenter.defaultCenter addObserverForName:UITextViewTextDidChangeNotification object:self queue:NSOperationQueue.mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        @strongify(self);
        self.ek_placeholderLabel.hidden = self.text && self.text.length != 0;
    }];
}

- (void)_ek_updatePlaceholderLabel {
    CGSize size = [self.ek_placeholder ek_sizeFromFont:self.ek_placeholderFont preferredMaxLayoutWidth:CGRectGetWidth(self.bounds) - 10];
    self.ek_placeholderLabel.frame = CGRectMake(5, 4, size.width + 10, size.height + 8);
}

- (void)_ek_setText:(NSString *)text {
    [self _ek_setText:text];
    self.ek_placeholderLabel.hidden = self.text && self.text.length != 0;
}

- (void)_ek_layoutSubviews {
    [self _ek_layoutSubviews];
    [self _ek_updatePlaceholderLabel];
}

#pragma mark -

- (nullable UILabel *)ek_placeholderLabel {
    return EKGetAssociatedObject(self, _cmd);
}

- (void)setEk_placeholderLabel:(nullable UILabel *)ek_placeholderLabel {
    EKSetAssociatedObject(self, @selector(ek_placeholderLabel), ek_placeholderLabel, OBJC_ASSOCIATION_ASSIGN);
}

- (nullable id)ek_observer {
    return EKGetAssociatedObject(self, _cmd);
}

- (void)setEk_observer:(nullable id)ek_observer {
    EKSetAssociatedObject(self, @selector(ek_observer), ek_observer, OBJC_ASSOCIATION_RETAIN);
}

#pragma mark -

- (nullable NSString *)ek_placeholder {
    return self.ek_placeholderLabel.text;
}

- (void)setEk_placeholder:(nullable NSString *)ek_placeholder {
    self.ek_placeholderLabel.text = ek_placeholder;
    [self _ek_updatePlaceholderLabel];
}

- (nullable UIFont *)ek_placeholderFont {
    return self.ek_placeholderLabel.font;
}

- (void)setEk_placeholderFont:(UIFont *)ek_placeholderFont {
    self.ek_placeholderLabel.font = ek_placeholderFont;
    [self _ek_updatePlaceholderLabel];
}

#pragma mark - 

- (void)ek_observerTextLenghtWithMax:(NSInteger)maxLength changing:(void(^_Nonnull)(NSInteger left))actionHandler {
    EKTextObserver *observer = [[EKTextObserver alloc] initWithMaxLenght:maxLength actionHandler:actionHandler];
    [observer observeTextView:self];
    EKSetAssociatedObject(self, _cmd, observer, OBJC_ASSOCIATION_RETAIN);
}


@end
