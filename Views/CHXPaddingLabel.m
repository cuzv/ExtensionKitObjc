//
//  CHXPaddingLabel.m
//  GettingStarted
//
//  Created by Moch Xiao on 2014-11-18.
//  Copyright (c) 2014 Moch Xiao (https://github.com/cuzv).
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

#import "CHXPaddingLabel.h"

#pragma mark - 具有 padding 效果的标签

@interface CHXPaddingLabel ()
@property (nonatomic, assign) UIEdgeInsets contentEdgeInsets;
@end

@implementation CHXPaddingLabel

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (!self) {
        return nil;
    }
    
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 8, 0, 8);
    
    return self;
}

- (instancetype)initWithContentEdgeInsets:(UIEdgeInsets)inset {
    self = [super initWithFrame:CGRectZero];
    if (!self) {
        return nil;
    }
    
    self.contentEdgeInsets = inset;
    
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [self sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
    CGFloat width = size.width + self.contentEdgeInsets.left + self.contentEdgeInsets.right;
    CGFloat height = size.height + self.contentEdgeInsets.top + self.contentEdgeInsets.bottom;
    return CGSizeMake(width, height);
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.contentEdgeInsets)];
}

@end
